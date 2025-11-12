import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/visit_model.dart';
import '../../../providers/visits_provider.dart';
import '../../../core/services/api_service.dart';

class VisitNotesPage extends ConsumerStatefulWidget {
  final VisitModel visit;

  const VisitNotesPage({
    super.key,
    required this.visit,
  });

  @override
  ConsumerState<VisitNotesPage> createState() => _VisitNotesPageState();
}

class _VisitNotesPageState extends ConsumerState<VisitNotesPage> {
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedNoteType = 'General';
  String _selectedPriority = 'Medium';
  bool _isPrivateNote = false;
  bool _requiresFollowUp = false;
  DateTime? _followUpDate;
  bool _isLoading = false;

  final List<String> _noteTypes = [
    'General',
    'Member Feedback',
    'Issue Reported',
    'Service Request',
    'Complaint',
    'Follow-up',
    'Registration',
    'Payment',
    'Contact Update',
    'Address Change',
  ];

  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent'];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Visit Note'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveNote,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visit Context Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Visit Context',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                            child: Text(
                              widget.visit.member?.displayFirstName.isNotEmpty == true
                                  ? widget.visit.member!.displayFirstName.substring(0, 1).toUpperCase()
                                  : 'M',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.visit.member?.name ?? 'Unknown'} ${widget.visit.member?.surname ?? 'Member'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  widget.visit.visitType,
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
                      if (widget.visit.locationAddress != null) ...[
                        const Gap(8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppTheme.textSecondary,
                            ),
                            const Gap(4),
                            Expanded(
                              child: Text(
                                widget.visit.locationAddress!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const Gap(16),

              // Note Details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Note Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Gap(16),

                      // Note Type
                      DropdownButtonFormField<String>(
                        value: _selectedNoteType,
                        decoration: const InputDecoration(
                          labelText: 'Note Type',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: _noteTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedNoteType = value!;
                          });
                        },
                      ),

                      const Gap(16),

                      // Priority
                      DropdownButtonFormField<String>(
                        value: _selectedPriority,
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.flag),
                        ),
                        items: _priorities.map((priority) {
                          Color color;
                          switch (priority) {
                            case 'Low':
                              color = Colors.green;
                              break;
                            case 'Medium':
                              color = Colors.orange;
                              break;
                            case 'High':
                              color = Colors.red;
                              break;
                            case 'Urgent':
                              color = Colors.purple;
                              break;
                            default:
                              color = Colors.grey;
                          }
                          return DropdownMenuItem(
                            value: priority,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Gap(8),
                                Text(priority),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPriority = value!;
                          });
                        },
                      ),

                      const Gap(16),

                      // Note Content
                      TextFormField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          labelText: 'Note Content',
                          hintText: 'Enter detailed note about this visit...',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Note content is required';
                          }
                          if (value.trim().length < 10) {
                            return 'Please provide more detailed note (at least 10 characters)';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(16),

              // Note Options
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Note Options',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Gap(16),

                      // Private Note Toggle
                      SwitchListTile(
                        title: const Text('Private Note'),
                        subtitle: const Text('Only visible to you and administrators'),
                        value: _isPrivateNote,
                        onChanged: (value) {
                          setState(() {
                            _isPrivateNote = value;
                          });
                        },
                        secondary: const Icon(Icons.lock_outline),
                      ),

                      // Follow-up Required Toggle
                      SwitchListTile(
                        title: const Text('Requires Follow-up'),
                        subtitle: const Text('Schedule a follow-up task for this note'),
                        value: _requiresFollowUp,
                        onChanged: (value) {
                          setState(() {
                            _requiresFollowUp = value;
                            if (!value) {
                              _followUpDate = null;
                            }
                          });
                        },
                        secondary: const Icon(Icons.schedule),
                      ),

                      // Follow-up Date
                      if (_requiresFollowUp) ...[
                        const Gap(8),
                        InkWell(
                          onTap: _selectFollowUpDate,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 20),
                                const Gap(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Follow-up Date',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _followUpDate != null
                                          ? '${_followUpDate!.day}/${_followUpDate!.month}/${_followUpDate!.year}'
                                          : 'Select date',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _followUpDate != null
                                            ? AppTheme.textPrimary
                                            : AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const Gap(24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveNote,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Save Note',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectFollowUpDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _followUpDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _followUpDate = picked;
      });
    }
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_requiresFollowUp && _followUpDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a follow-up date'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiService = ref.read(apiServiceProvider);

      final request = CreateVisitNoteRequest(
        visitId: widget.visit.id,
        leaderId: widget.visit.leaderId ?? 0,
        noteType: _selectedNoteType,
        content: _noteController.text.trim(),
        isPrivate: _isPrivateNote,
      );

      await apiService.createVisitNote(request);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save note: $error'),
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
}