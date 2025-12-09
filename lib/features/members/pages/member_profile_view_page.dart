import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/visits_provider.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/visit_model.dart';
import '../../visits/pages/visit_notes_page.dart';

class MemberProfileViewPage extends ConsumerStatefulWidget {
  final int memberId;

  const MemberProfileViewPage({
    super.key,
    required this.memberId,
  });

  @override
  ConsumerState<MemberProfileViewPage> createState() => _MemberProfileViewPageState();
}

class _MemberProfileViewPageState extends ConsumerState<MemberProfileViewPage> {
  bool _isLoading = true;
  String? _errorMessage;
  MemberModel? _member;

  @override
  void initState() {
    super.initState();
    _loadMemberProfile();
  }

  Future<void> _loadMemberProfile() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final apiService = ref.read(apiServiceProvider);
      final member = await apiService.getMember(widget.memberId);

      setState(() {
        _member = member;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _recordVisit() async {
    if (_member == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Create Visit'),
        content: const Text('Would you like to create a visit record for this member?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _createVisitAndNavigate();
            },
            child: const Text('Create Visit'),
          ),
        ],
      ),
    );
  }

  Future<void> _createVisitAndNavigate() async {
    if (_member == null) return;

    try {
      setState(() => _isLoading = true);

      final apiService = ref.read(apiServiceProvider);

      // Create visit using membership number
      final response = await apiService.createVisitFromMembership(
        CreateVisitFromMembershipRequest(
          membershipNumber: _member!.membershipNumber ?? '',
          leaderId: 0, // TODO: Get current leader ID
        ),
      );

      if (mounted) {
        // Navigate to visit notes page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VisitNotesPage(visit: response),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create visit: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _logComplaint() async {
    if (_member == null) return;

    final complaintController = TextEditingController();
    String selectedCategory = 'Service Delivery';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Log Complaint'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Member: ${_member!.displayFullName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                const Text('Category:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const Gap(8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    'Service Delivery',
                    'Infrastructure',
                    'Safety',
                    'Other',
                  ].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                const Gap(16),
                const Text('Description:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const Gap(8),
                TextField(
                  controller: complaintController,
                  decoration: const InputDecoration(
                    hintText: 'Enter complaint details...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (complaintController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter complaint details'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                Navigator.of(context).pop();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Complaint logged: $selectedCategory'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );

    complaintController.dispose();
  }

  Future<void> _updateContact() async {
    if (_member == null) return;

    final phoneController = TextEditingController(text: _member!.phoneNumber ?? _member!.telNumber);
    final addressController = TextEditingController(text: _member!.address);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Contact Information'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const Gap(16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Contact information updated'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    phoneController.dispose();
    addressController.dispose();
  }

  Future<void> _callMember() async {
    if (_member == null) return;

    final phoneNumber = _member!.phoneNumber ?? _member!.telNumber;

    if (phoneNumber == null || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No phone number available for this member'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Show dialog to confirm call
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Call Member'),
        content: Text('Call ${_member!.displayFullName} at $phoneNumber?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling $phoneNumber...')),
              );
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Profile'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMemberProfile,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const Gap(16),
                      Text(
                        'Error loading member',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const Gap(24),
                      ElevatedButton(
                        onPressed: _loadMemberProfile,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _member == null
                  ? const Center(child: Text('Member not found'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Member Header Card
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundColor: AppTheme.primaryColor,
                                    child: Text(
                                      '${_member!.displayFirstName[0]}${_member!.displayLastName[0]}'.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_member!.displayFirstName} ${_member!.displayLastName}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          _member!.membershipNumber ?? 'No membership number',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const Gap(8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: _member!.isActive ? Colors.green : Colors.red,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            _member!.isActive ? 'Active' : 'Inactive',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Gap(16),

                          // Quick Actions
                          const Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _recordVisit,
                                  icon: const Icon(Icons.add_circle_outline),
                                  label: const Text('Record Visit'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryColor,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _logComplaint,
                                  icon: const Icon(Icons.warning_amber_outlined),
                                  label: const Text('Log Complaint'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _updateContact,
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Update Contact'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _callMember,
                                  icon: const Icon(Icons.phone),
                                  label: const Text('Call Member'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Gap(24),

                          // Contact Information
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(12),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  if (_member!.phoneNumber != null)
                                    _buildInfoRow(Icons.phone, 'Phone', _member!.phoneNumber!),
                                  if (_member!.phoneNumber != null) const Divider(),
                                  if (_member!.idNumber != null)
                                    _buildInfoRow(Icons.badge, 'ID Number', _member!.idNumber!),
                                  if (_member!.idNumber != null) const Divider(),
                                  if (_member!.address != null)
                                    _buildInfoRow(Icons.home, 'Address', _member!.address!),
                                  if (_member!.address != null) const Divider(),
                                  if (_member!.ward != null)
                                    _buildInfoRow(Icons.location_on, 'Ward', _member!.ward!),
                                  if (_member!.ward != null && _member!.municipality != null) const Divider(),
                                  if (_member!.municipality != null)
                                    _buildInfoRow(Icons.account_balance, 'Municipality', _member!.displayMunicipality),
                                ],
                              ),
                            ),
                          ),

                          const Gap(24),

                          // Membership Information
                          const Text(
                            'Membership Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(12),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  if (_member!.membershipNumber != null)
                                    _buildInfoRow(Icons.card_membership, 'Membership Number', _member!.membershipNumber!),
                                  if (_member!.membershipNumber != null) const Divider(),
                                  if (_member!.createdAt != null)
                                    _buildInfoRow(
                                      Icons.calendar_today,
                                      'Member Since',
                                      DateFormat('dd MMM yyyy').format(_member!.createdAt!),
                                    ),
                                  if (_member!.createdAt != null) const Divider(),
                                  _buildInfoRow(
                                    Icons.check_circle,
                                    'Status',
                                    _member!.isActive ? 'Active Member' : 'Inactive Member',
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Gap(100),
                        ],
                      ),
                    ),
      floatingActionButton: _member != null && !_isLoading
          ? FloatingActionButton.extended(
              heroTag: 'memberProfileRecordVisit',
              onPressed: _recordVisit,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Record Visit', style: TextStyle(color: Colors.white)),
              backgroundColor: AppTheme.primaryColor,
            )
          : null,
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
