import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/api_provider.dart';
import 'event_details_page.dart';

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();
  List<EventModel> _events = [];
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  String _currentFilter = 'upcoming';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadEvents();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      String newFilter;
      switch (_tabController.index) {
        case 0:
          newFilter = 'upcoming';
          break;
        case 1:
          newFilter = 'ongoing';
          break;
        case 2:
          newFilter = 'past';
          break;
        default:
          newFilter = 'upcoming';
      }
      if (newFilter != _currentFilter) {
        setState(() => _currentFilter = newFilter);
        _loadEvents();
      }
    }
  }

  Future<void> _loadEvents() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      // Get authenticated user and municipality
      final authState = ref.read(authProvider);
      final user = authState.valueOrNull;

      if (user == null || user.municipalities == null || user.municipalities!.isEmpty) {
        throw Exception('No user or municipality found');
      }

      final municipalityId = user.municipalities!.first.id;

      // Get API service from provider
      final apiService = ref.read(apiServiceProvider);

      // Determine query parameters based on filter
      bool? upcomingOnly;
      DateTime? dateFrom;
      DateTime? dateTo;

      final now = DateTime.now();
      switch (_currentFilter) {
        case 'upcoming':
          upcomingOnly = true;
          break;
        case 'ongoing':
          // For ongoing events, get all events and filter them client-side
          upcomingOnly = false;
          break;
        case 'past':
          // For past events, set dateTo to now
          dateTo = now;
          upcomingOnly = false;
          break;
      }

      // Call API
      final response = await apiService.getEvents(
        municipalityId,
        upcomingOnly: upcomingOnly,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      // Filter events if needed (for ongoing tab)
      List<EventModel> filteredEvents = response;
      if (_currentFilter == 'ongoing') {
        filteredEvents = response.where((event) {
          return event.eventDate.isBefore(now.add(const Duration(hours: 24))) &&
                 event.eventDate.isAfter(now.subtract(const Duration(hours: 24)));
        }).toList();
      }

      setState(() {
        _events = filteredEvents;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Events'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Ongoing'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_hasError) {
      return Center(
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
              'Failed to load events',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
            if (_errorMessage != null) ...[
              const Gap(8),
              Text(
                _errorMessage!,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const Gap(24),
            ElevatedButton(
              onPressed: _loadEvents,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_outlined,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const Gap(16),
            Text(
              'No $_currentFilter events',
              style: const TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadEvents,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return _EventCard(
            event: event,
            onTap: () => _navigateToEventDetails(event),
          );
        },
      ),
    );
  }

  void _navigateToEventDetails(EventModel event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(event: event),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const _EventCard({
    required this.event,
    required this.onTap,
  });

  Color _getTypeColor() {
    switch (event.eventType) {
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
    return (event.eventType ?? 'event').toUpperCase();
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (dateTime.isAfter(now)) {
      if (difference.inDays > 7) {
        return DateFormat('MMM dd, yyyy').format(dateTime);
      } else if (difference.inDays > 0) {
        return 'In ${difference.inDays} day${difference.inDays > 1 ? 's' : ''}';
      } else if (difference.inHours > 0) {
        return 'In ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}';
      } else {
        return 'Starting soon';
      }
    } else {
      if (difference.inDays.abs() == 0) {
        return 'Today';
      } else if (difference.inDays.abs() == 1) {
        return 'Yesterday';
      } else {
        return '${difference.inDays.abs()} days ago';
      }
    }
  }

  bool _isEventFull() {
    if (event.capacity == null) return false;
    return event.totalAttending >= event.capacity!;
  }

  bool get _isRegistered => event.userRsvpStatus == 'attending';

  int get _availableSpots {
    if (event.capacity == null) return 999;
    return event.capacity! - event.totalAttending;
  }

  @override
  Widget build(BuildContext context) {
    final availableSpots = _availableSpots;
    final isEventInPast = event.eventDate.isBefore(DateTime.now());

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
              // Header with type and registration status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getTypeText(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (_isRegistered) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'REGISTERED',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ] else if (_isEventFull() && !isEventInPast) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'FULL',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              const Gap(12),

              // Title
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),

              const Gap(8),

              // Description preview
              Text(
                event.description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Gap(16),

              // Event details
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(4),
                  Text(
                    _formatDateTime(event.eventDate),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const Gap(16),
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      event.location,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const Gap(8),

              // Attendance info
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(4),
                  Text(
                    event.capacity != null
                        ? '${event.totalAttending} / ${event.capacity} attendees'
                        : '${event.totalAttending} attending',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  if (!isEventInPast && availableSpots > 0 && availableSpots <= 10) ...[
                    const Gap(8),
                    Text(
                      '($availableSpots spots left)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),

              // Action button for upcoming events
              if (!isEventInPast) ...[
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isRegistered || _isEventFull() ? null : onTap,
                    child: Text(
                      _isRegistered
                        ? 'View Details'
                        : _isEventFull()
                          ? 'Event Full'
                          : 'Register Now',
                    ),
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