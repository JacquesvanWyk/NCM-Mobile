import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';

class EventDetailsPage extends ConsumerStatefulWidget {
  final EventModel event;

  const EventDetailsPage({
    super.key,
    required this.event,
  });

  @override
  ConsumerState<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends ConsumerState<EventDetailsPage> {
  bool _isRegistering = false;
  bool _isCancelling = false;
  bool _isRegistered = false;

  @override
  void initState() {
    super.initState();
    _isRegistered = widget.event.userRsvpStatus == 'attending';
  }

  Future<void> _registerForEvent() async {
    if (_isRegistering || _isRegistered) return;

    setState(() => _isRegistering = true);

    try {
      // TODO: Get actual API service instance
      // final response = await ApiService().registerForEvent(widget.event.id);

      // Mock delay for now
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isRegistered = true;
        _isRegistering = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully registered for event!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      setState(() => _isRegistering = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _cancelRegistration() async {
    if (_isCancelling || !_isRegistered) return;

    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Registration'),
        content: const Text('Are you sure you want to cancel your registration for this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep Registration'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel Registration'),
          ),
        ],
      ),
    );

    if (shouldCancel != true) return;

    setState(() => _isCancelling = true);

    try {
      // TODO: Get actual API service instance
      // await ApiService().cancelEventRegistration(widget.event.id);

      // Mock delay for now
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isRegistered = false;
        _isCancelling = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration cancelled successfully'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (error) {
      setState(() => _isCancelling = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to cancel registration: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Color _getTypeColor() {
    switch (widget.event.eventType) {
      case 'meeting':
        return Colors.blue;
      case 'workshop':
        return Colors.orange;
      case 'program':
        return Colors.green;
      case 'community':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getTypeText() {
    return (widget.event.eventType ?? 'event').toUpperCase();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE, MMMM dd, yyyy \'at\' hh:mm a').format(dateTime);
  }

  bool _isEventInPast() {
    return widget.event.eventDate.isBefore(DateTime.now());
  }

  bool _isEventFull() {
    if (widget.event.capacity == null) return false;
    return widget.event.totalAttending >= widget.event.capacity!;
  }

  int get _availableSpots {
    if (widget.event.capacity == null) return 999;
    return widget.event.capacity! - widget.event.totalAttending;
  }

  @override
  Widget build(BuildContext context) {
    final isEventInPast = _isEventInPast();
    final isEventFull = _isEventFull();
    final availableSpots = _availableSpots;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareEvent(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image placeholder or header
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _getTypeColor().withOpacity(0.7),
                    _getTypeColor(),
                  ],
                ),
              ),
              child: _buildDefaultEventHeader(),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event type and registration status
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _getTypeText(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (_isRegistered) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'REGISTERED',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ] else if (isEventFull && !isEventInPast) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'EVENT FULL',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const Gap(20),

                  // Event title
                  Text(
                    widget.event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                      height: 1.3,
                    ),
                  ),

                  const Gap(24),

                  // Event details cards
                  _buildDetailCard(
                    icon: Icons.access_time,
                    title: 'Date & Time',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDateTime(widget.event.eventDate),
                          style: const TextStyle(fontSize: 14),
                        ),
                        if (widget.event.registrationDeadline != null) ...[
                          const Gap(4),
                          Text(
                            'Register by: ${_formatDateTime(widget.event.registrationDeadline!)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const Gap(12),

                  _buildDetailCard(
                    icon: Icons.location_on,
                    title: 'Location',
                    content: Text(
                      widget.event.location,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),

                  const Gap(12),

                  _buildDetailCard(
                    icon: Icons.people,
                    title: 'Attendance',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.capacity != null
                              ? '${widget.event.totalAttending} / ${widget.event.capacity} registered'
                              : '${widget.event.totalAttending} attending',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Gap(8),
                        if (widget.event.capacity != null)
                          LinearProgressIndicator(
                            value: widget.event.totalAttending / widget.event.capacity!,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isEventFull ? Colors.red : AppTheme.primaryColor,
                            ),
                          ),
                        const Gap(4),
                        if (!isEventInPast && !isEventFull && widget.event.capacity != null)
                          Text(
                            '$availableSpots spots remaining',
                            style: TextStyle(
                              fontSize: 12,
                              color: availableSpots <= 10 ? Colors.orange : AppTheme.textSecondary,
                              fontWeight: availableSpots <= 10 ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                  ),

                  const Gap(24),

                  // Description section
                  const Text(
                    'About This Event',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),

                  const Gap(12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      widget.event.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppTheme.textPrimary,
                        height: 1.6,
                      ),
                    ),
                  ),

                  const Gap(32),

                  // Action buttons
                  if (!isEventInPast) ...[
                    if (_isRegistered) ...[
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isCancelling ? null : _cancelRegistration,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isCancelling
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Cancel Registration'),
                        ),
                      ),
                    ] else if (!isEventFull) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isRegistering ? null : _registerForEvent,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isRegistering
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Register for Event'),
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_busy,
                              color: Colors.red.shade600,
                              size: 24,
                            ),
                            const Gap(12),
                            const Expanded(
                              child: Text(
                                'This event is full. Registration is no longer available.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: AppTheme.textSecondary,
                            size: 24,
                          ),
                          const Gap(12),
                          const Expanded(
                            child: Text(
                              'This event has ended.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultEventHeader() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event,
              size: 64,
              color: Colors.white.withOpacity(0.8),
            ),
            const Gap(12),
            Text(
              widget.event.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Gap(8),
                  content,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareEvent(BuildContext context) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon'),
      ),
    );
  }
}