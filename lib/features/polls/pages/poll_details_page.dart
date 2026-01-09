import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/poll_model.dart' as poll;
import '../../../data/models/poll_statistics_response.dart';
import '../providers/polls_provider.dart';
import '../providers/poll_statistics_provider.dart';
import '../../../core/services/api_service.dart' hide OptionStatistic, PollStatisticsResponse;

class PollDetailsPage extends ConsumerStatefulWidget {
  final poll.PollModel pollData;

  const PollDetailsPage({
    super.key,
    required this.pollData,
  });

  @override
  ConsumerState<PollDetailsPage> createState() => _PollDetailsPageState();
}

class _PollDetailsPageState extends ConsumerState<PollDetailsPage> {
  int? _selectedOptionId;
  bool _hasVoted = false;
  bool _isSubmitting = false;
  List<Map<String, dynamic>> _pollOptions = [];

  @override
  void initState() {
    super.initState();
    _hasVoted = widget.pollData.hasVoted;
    _parseOptions();
  }

  void _parseOptions() {
    try {
      final List<dynamic> optionsList = json.decode(widget.pollData.options);
      _pollOptions = optionsList.asMap().entries.map((entry) {
        final option = entry.value;
        return {
          'id': entry.key + 1,
          'text': option['text'] ?? '',
        };
      }).toList();
    } catch (e) {
      _pollOptions = [];
    }
  }

  void _selectOption(int optionId) {
    if (!_hasVoted) {
      setState(() {
        _selectedOptionId = optionId;
      });
    }
  }

  Future<void> _submitVote() async {
    if (_selectedOptionId == null || _hasVoted || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Submit vote using the enhanced vote provider
      await ref.read(pollVoteProvider.notifier).submitVote(
        widget.pollData.id,
        _selectedOptionId! - 1, // Convert to 0-based index for API
      );

      // Update poll detail state to reflect vote
      ref.read(pollDetailProvider(widget.pollData.id).notifier).markAsVoted();

      setState(() {
        _hasVoted = true;
        _isSubmitting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vote submitted successfully and queued for processing!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Force immediate refresh of statistics after vote submission
        await ref.read(pollStatisticsProvider(widget.pollData.id).notifier)
            .refreshAfterVote();

        // Refresh polls list to show updated vote status
        ref.read(pollsProvider.notifier).refresh();
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });

      if (mounted) {
        String errorMessage = 'Failed to submit vote';

        // Use enhanced error handling from vote provider
        final voteProvider = ref.read(pollVoteProvider.notifier);
        if (voteProvider.errorMessage != null) {
          errorMessage = voteProvider.errorMessage!;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _submitVote(),
            ),
          ),
        );
      }
    }
  }

  Widget _buildOptionTile(Map<String, dynamic> option) {
    final optionId = option['id'] as int;
    final optionText = option['text'] as String;
    final isSelected = _selectedOptionId == optionId;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: _hasVoted ? null : () => _selectOption(optionId),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryColor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? AppTheme.primaryColor
                  : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected
                    ? AppTheme.primaryColor
                    : Colors.grey[400],
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  optionText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final statisticsAsync = ref.watch(pollStatisticsProvider(widget.pollData.id));
    final statisticsNotifier = ref.watch(pollStatisticsProvider(widget.pollData.id).notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Live Poll Results',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (statisticsNotifier.isLoading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  const Gap(8),
                  IconButton(
                    onPressed: statisticsNotifier.isLoading
                        ? null
                        : () => statisticsNotifier.refreshStatistics(),
                    icon: const Icon(Icons.refresh),
                    iconSize: 20,
                    tooltip: 'Refresh statistics',
                  ),
                ],
              ),
            ],
          ),

          // Last updated timestamp
          if (statisticsNotifier.hasValidStatistics)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Updated ${statisticsNotifier.lastUpdatedFormatted}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          const Gap(16),

          statisticsAsync.when(
            data: (statistics) {
              if (statistics == null) {
                return const Column(
                  children: [
                    Icon(Icons.bar_chart, size: 48, color: Colors.grey),
                    Gap(8),
                    Text(
                      'No votes yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Be the first to vote!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  // Overall statistics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard(
                        'Total Votes',
                        statisticsNotifier.totalVotes.toString(),
                        Icons.how_to_vote,
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Participation',
                        statisticsNotifier.participationRateFormatted,
                        Icons.people,
                        statistics.hasSignificantParticipation
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Option breakdown using sorted statistics
                  if (statisticsNotifier.sortedOptionStatistics.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Results Breakdown',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (statistics.hasClearWinner)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Clear Winner',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(12),
                    ...statisticsNotifier.sortedOptionStatistics.map((option) =>
                      _buildResultBar(option, isLeading: option == statisticsNotifier.leadingOption)
                    ),
                  ],

                  // Additional insights
                  if (statistics.isCloseVoting && statisticsNotifier.totalVotes > 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.orange[300]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.trending_up,
                                 color: Colors.orange[700], size: 16),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                'Close race! Top options are within 10%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Column(
                children: [
                  Icon(Icons.error_outline, color: Colors.red[700], size: 24),
                  const Gap(8),
                  Text(
                    'Unable to load statistics',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    error.toString(),
                    style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(8),
                  TextButton(
                    onPressed: () => statisticsNotifier.refreshStatistics(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const Gap(4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultBar(OptionStatistic option, {bool isLeading = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (isLeading) ...[
                      Icon(
                        Icons.emoji_events,
                        color: Colors.amber[700],
                        size: 14,
                      ),
                      const Gap(4),
                    ],
                    Expanded(
                      child: Text(
                        option.optionText,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isLeading ? FontWeight.bold : FontWeight.w500,
                          color: isLeading ? Colors.green[700] : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${option.voteCount} votes (${option.percentage.toStringAsFixed(1)}%)',
                style: TextStyle(
                  fontSize: 12,
                  color: isLeading ? Colors.green[600] : Colors.grey,
                  fontWeight: isLeading ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
          const Gap(4),
          Container(
            height: isLeading ? 8 : 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: option.percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: isLeading
                      ? Colors.green[500]
                      : AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle pull-to-refresh action
  /// Constitutional requirement: Real-time data refresh (FR-003)
  Future<void> _handleRefresh() async {
    try {
      // Refresh poll details to get latest vote status
      await ref.read(pollDetailProvider(widget.pollData.id).notifier).refresh();

      // Refresh poll statistics to get latest results
      await ref.read(pollStatisticsProvider(widget.pollData.id).notifier)
          .refreshStatistics();

      // Update local state if poll details changed
      final updatedPoll = ref.read(pollDetailProvider(widget.pollData.id)).valueOrNull;
      if (updatedPoll != null && updatedPoll.hasVoted != _hasVoted) {
        setState(() {
          _hasVoted = updatedPoll.hasVoted;
        });
      }
    } catch (e) {
      // Handle refresh errors gracefully
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh: ${e.toString()}'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasEndDate = widget.pollData.endsAt != null;
    final daysRemaining = hasEndDate ? widget.pollData.endsAt!.difference(DateTime.now()).inDays : null;
    final isActive = !hasEndDate || (daysRemaining != null && daysRemaining >= 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poll Details'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _handleRefresh,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh poll data',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppTheme.primaryColor,
        backgroundColor: Colors.white,
        displacement: 20,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Poll header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pollData.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _hasVoted ? Colors.green : AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _hasVoted ? 'Voted' : 'Active',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Gap(8),
                      Text(
                        !hasEndDate
                            ? 'Ongoing'
                            : (daysRemaining! >= 0
                                ? '$daysRemaining days remaining'
                                : 'Poll ended'),
                        style: TextStyle(
                          color: isActive ? AppTheme.textSecondary : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Gap(16),

            // Description
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    widget.pollData.description ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            const Gap(16),

            // Poll options
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Options',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(16),
                  ..._pollOptions.map((option) => _buildOptionTile(option)),
                ],
              ),
            ),

            const Gap(24),

            // Vote button
            if (!_hasVoted && isActive)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedOptionId != null && !_isSubmitting
                      ? _submitVote
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Submit Vote',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

            // Already voted message
            if (_hasVoted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[700],
                    ),
                    const Gap(8),
                    Text(
                      'You have already voted in this poll',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Poll statistics section
            const Gap(24),
            _buildStatisticsSection(),
            ],
          ),
        ),
      ),
    );
  }
}