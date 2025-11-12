import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/visit_model.dart';
import '../../../providers/visits_provider.dart';
import '../../members/pages/quick_registration_page.dart';

class VisitExecutionPage extends ConsumerStatefulWidget {
  final VisitModel visit;

  const VisitExecutionPage({
    super.key,
    required this.visit,
  });

  @override
  ConsumerState<VisitExecutionPage> createState() => _VisitExecutionPageState();
}

class _VisitExecutionPageState extends ConsumerState<VisitExecutionPage> {
  final _notesController = TextEditingController();
  final _outcomeController = TextEditingController();
  bool _isCheckedIn = false;
  bool _isLoading = false;
  DateTime? _checkInTime;
  DateTime? _checkOutTime;
  String? _selectedOutcome;
  List<String> _capturedPhotos = [];

  final List<String> _outcomeOptions = [
    'Member Visited Successfully',
    'Member Not Available',
    'Address Not Found',
    'Member Moved',
    'Follow-up Required',
    'New Registration Completed',
    'Issue Resolved',
    'Complaint Logged',
  ];

  @override
  void initState() {
    super.initState();
    _isCheckedIn = widget.visit.status == 'in_progress';
    if (_isCheckedIn) {
      _checkInTime = DateTime.now().subtract(const Duration(minutes: 30)); // Mock check-in time
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _outcomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Execution'),
        actions: [
          if (_isCheckedIn)
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: _navigateToQuickRegistration,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Visit Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visit Details',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(12),
                    _buildInfoRow(
                      Icons.person,
                      '${widget.visit.member?.name ?? 'Unknown'} ${widget.visit.member?.surname ?? 'Member'}',
                    ),
                    const Gap(8),
                    _buildInfoRow(
                      Icons.phone,
                      widget.visit.member?.displayPhone.isNotEmpty == true
                        ? widget.visit.member!.displayPhone
                        : 'No phone number',
                    ),
                    const Gap(8),
                    _buildInfoRow(
                      Icons.location_on,
                      widget.visit.locationAddress ?? 'No address',
                    ),
                    const Gap(8),
                    _buildInfoRow(
                      Icons.category,
                      widget.visit.visitType,
                    ),
                  ],
                ),
              ),
            ),

            const Gap(16),

            // Check-in/Check-out Section
            Card(
              color: _isCheckedIn ? Colors.green.shade50 : Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _isCheckedIn ? Icons.check_circle : Icons.access_time,
                          color: _isCheckedIn ? Colors.green : AppTheme.primaryColor,
                        ),
                        const Gap(8),
                        Text(
                          _isCheckedIn ? 'Checked In' : 'Ready to Check In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _isCheckedIn ? Colors.green.shade800 : AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    if (_checkInTime != null) ...[
                      const Gap(8),
                      Text(
                        'Check-in time: ${_formatTime(_checkInTime!)}',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                    if (_checkOutTime != null) ...[
                      const Gap(4),
                      Text(
                        'Check-out time: ${_formatTime(_checkOutTime!)}',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Duration: ${_calculateDuration()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const Gap(16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : (_isCheckedIn ? _checkOut : _checkIn),
                        icon: _isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(_isCheckedIn ? Icons.logout : Icons.login),
                        label: Text(_isCheckedIn ? 'Check Out' : 'Check In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isCheckedIn ? Colors.orange : AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_isCheckedIn) ...[
              const Gap(16),

              // Quick Actions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionButton(
                              Icons.camera_alt,
                              'Take Photo',
                              _capturePhoto,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: _buildQuickActionButton(
                              Icons.person_add,
                              'New Member',
                              _navigateToQuickRegistration,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionButton(
                              Icons.phone,
                              'Call Member',
                              _callMember,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: _buildQuickActionButton(
                              Icons.location_on,
                              'Get Directions',
                              _getDirections,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(16),

              // Photos Section
              if (_capturedPhotos.isNotEmpty) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Photos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(12),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _capturedPhotos.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.photo,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
              ],

              // Visit Notes
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Visit Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(12),
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          hintText: 'Add notes about this visit...',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(16),

              // Visit Outcome
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Visit Outcome',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(12),
                      DropdownButtonFormField<String>(
                        value: _selectedOutcome,
                        decoration: const InputDecoration(
                          labelText: 'Select outcome',
                          border: OutlineInputBorder(),
                        ),
                        items: _outcomeOptions.map((outcome) {
                          return DropdownMenuItem(
                            value: outcome,
                            child: Text(outcome),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedOutcome = value;
                          });
                        },
                      ),
                      if (_selectedOutcome != null) ...[
                        const Gap(12),
                        TextFormField(
                          controller: _outcomeController,
                          decoration: const InputDecoration(
                            labelText: 'Additional details (optional)',
                            hintText: 'Provide more details about the outcome...',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.textSecondary,
        ),
        const Gap(8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }

  Future<void> _checkIn() async {
    setState(() => _isLoading = true);

    try {
      // Real API call for check-in
      final updatedVisit = await ref.read(visitsProvider.notifier).checkInToVisit(
        widget.visit.id,
        latitude: 0.0, // TODO: Get real GPS coordinates
        longitude: 0.0, // TODO: Get real GPS coordinates
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      setState(() {
        _isCheckedIn = true;
        _checkInTime = DateTime.now();
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully checked in to visit'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check-in failed: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _checkOut() async {
    if (_selectedOutcome == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a visit outcome before checking out'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Real API call for check-out
      final updatedVisit = await ref.read(visitsProvider.notifier).checkOutFromVisit(
        widget.visit.id,
        latitude: 0.0, // TODO: Get real GPS coordinates
        longitude: 0.0, // TODO: Get real GPS coordinates
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        outcome: _selectedOutcome,
        sentimentScore: 7, // Default sentiment score
        memberSatisfaction: 'Satisfied', // Default satisfaction
        issuesIdentified: [], // TODO: Add issues if any
        followUpRequired: _selectedOutcome?.contains('Follow-up') ?? false,
      );

      setState(() {
        _isCheckedIn = false;
        _checkOutTime = DateTime.now();
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully checked out. Visit completed!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context, true);
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check-out failed: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _capturePhoto() {
    // TODO: Implement camera functionality
    setState(() {
      _capturedPhotos.add('photo_${DateTime.now().millisecondsSinceEpoch}');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo captured successfully')),
    );
  }

  void _navigateToQuickRegistration() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QuickRegistrationPage(),
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New member registered during visit'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _callMember() {
    final phoneNumber = widget.visit.member?.displayPhone;
    if (phoneNumber?.isNotEmpty == true) {
      // TODO: Implement phone call functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Calling $phoneNumber...')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No phone number available')),
      );
    }
  }

  void _getDirections() {
    final address = widget.visit.locationAddress;
    if (address != null) {
      // TODO: Implement maps integration
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Getting directions to $address...')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No address available')),
      );
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _calculateDuration() {
    if (_checkInTime != null && _checkOutTime != null) {
      final duration = _checkOutTime!.difference(_checkInTime!);
      final minutes = duration.inMinutes;
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;

      if (hours > 0) {
        return '${hours}h ${remainingMinutes}m';
      } else {
        return '${remainingMinutes}m';
      }
    }
    return '';
  }
}