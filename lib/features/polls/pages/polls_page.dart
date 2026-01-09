import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/poll_model.dart' as poll;
import '../providers/polls_provider.dart';
import 'poll_details_page.dart';
import 'dart:convert';

class PollsPage extends ConsumerStatefulWidget {
  final VoidCallback? onBackPressed;

  const PollsPage({super.key, this.onBackPressed});

  @override
  ConsumerState<PollsPage> createState() => _PollsPageState();
}

class _PollsPageState extends ConsumerState<PollsPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshPolls() async {
    await ref.read(pollsProvider.notifier).refresh();
  }

  List<poll.PollOptionModel> _parseOptions(String optionsJson) {
    try {
      final List<dynamic> optionsList = json.decode(optionsJson);
      return optionsList.asMap().entries.map((entry) {
        final option = entry.value;
        return poll.PollOptionModel(
          id: entry.key + 1, // Simple ID based on index
          text: option['text'] ?? '',
          voteCount: 0, // Will be filled from poll results if available
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: (widget.onBackPressed != null || Navigator.canPop(context))
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (widget.onBackPressed != null) {
                    widget.onBackPressed!();
                  } else {
                    Navigator.pop(context);
                  }
                },
              )
            : null,
        title: const Text('Polls & Surveys'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final pollsAsync = ref.watch(pollsProvider);

    return pollsAsync.when(
      data: (polls) {
        if (polls.isEmpty) {
          return RefreshIndicator(
            onRefresh: _refreshPolls,
            color: AppTheme.primaryColor,
            backgroundColor: Colors.white,
            displacement: 20,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 200),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ballot_outlined,
                        size: 64,
                        color: AppTheme.textSecondary,
                      ),
                      Gap(16),
                      Text(
                        'No polls available',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Gap(8),
                      Text(
                        'Pull down to refresh',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _refreshPolls,
          color: AppTheme.primaryColor,
          backgroundColor: Colors.white,
          displacement: 20,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: polls.length,
            itemBuilder: (context, index) {
              final poll = polls[index];
              final options = _parseOptions(poll.options);

              return _PollCard(
                pollData: poll,
                options: options,
                onTap: () => _navigateToPollDetails(poll),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const Gap(16),
            Text(
              'Failed to load polls',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
            const Gap(8),
            Text(
              error.toString(),
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: _refreshPolls,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPollDetails(poll.PollModel pollData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PollDetailsPage(pollData: pollData),
      ),
    );
  }
}

class _PollCard extends StatelessWidget {
  final poll.PollModel pollData;
  final List<poll.PollOptionModel> options;
  final VoidCallback onTap;

  const _PollCard({
    required this.pollData,
    required this.options,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasEndDate = pollData.endsAt != null;
    final daysRemaining = hasEndDate ? pollData.endsAt!.difference(DateTime.now()).inDays : null;
    final isActive = !hasEndDate || (daysRemaining != null && daysRemaining >= 0);
    final totalVotes = options.fold<int>(0, (sum, option) => sum + option.voteCount);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status
              Row(
                children: [
                  Expanded(
                    child: Text(
                      pollData.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: pollData.hasVoted ? Colors.green : AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      pollData.hasVoted ? 'Voted' : 'Active',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const Gap(8),

              // Description
              Text(
                pollData.description ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Gap(16),

              // Stats row
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(4),
                  Text(
                    '$totalVotes votes',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const Gap(16),
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(4),
                  Text(
                    !hasEndDate
                        ? 'Ongoing'
                        : (daysRemaining! >= 0
                            ? '$daysRemaining days left'
                            : 'Poll ended'),
                    style: TextStyle(
                      fontSize: 14,
                      color: isActive
                          ? AppTheme.textSecondary
                          : Colors.red,
                    ),
                  ),
                ],
              ),

              // Vote button if not voted
              if (!pollData.hasVoted && isActive) ...[
                const Gap(12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap,
                    child: const Text('Vote Now'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}