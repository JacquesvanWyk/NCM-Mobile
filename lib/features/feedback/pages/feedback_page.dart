import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage({super.key});

  @override
  ConsumerState<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedCategory = 'service';
  String _selectedPriority = 'medium';
  bool _isSubmitting = false;
  List<File> _attachments = [];

  final List<Map<String, String>> _categories = [
    {'value': 'service', 'label': 'Service Delivery', 'icon': 'build'},
    {'value': 'infrastructure', 'label': 'Infrastructure', 'icon': 'construction'},
    {'value': 'safety', 'label': 'Public Safety', 'icon': 'security'},
    {'value': 'environment', 'label': 'Environment', 'icon': 'eco'},
    {'value': 'governance', 'label': 'Governance', 'icon': 'account_balance'},
    {'value': 'other', 'label': 'Other', 'icon': 'help_outline'},
  ];

  final List<Map<String, String>> _priorities = [
    {'value': 'low', 'label': 'Low', 'color': 'blue'},
    {'value': 'medium', 'label': 'Medium', 'color': 'orange'},
    {'value': 'high', 'label': 'High', 'color': 'red'},
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      // TODO: Get actual API service instance
      // final request = FeedbackRequest(
      //   category: _selectedCategory,
      //   subject: _subjectController.text.trim(),
      //   message: _messageController.text.trim(),
      //   priority: _selectedPriority,
      //   attachments: _attachments.map((file) => file.path).toList(),
      // );
      // final response = await ApiService().submitFeedback(request);

      // Mock delay for now
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isSubmitting = false);

      if (mounted) {
        // Show success dialog
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            title: const Text('Feedback Submitted!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Thank you for your feedback. We have received your submission and will review it promptly.',
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Reference Number',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'FB${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Return to dashboard
                },
                child: const Text('Done'),
              ),
            ],
          ),
        );

        // Clear form
        _subjectController.clear();
        _messageController.clear();
        setState(() {
          _selectedCategory = 'service';
          _selectedPriority = 'medium';
          _attachments.clear();
        });
      }
    } catch (error) {
      setState(() => _isSubmitting = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit feedback: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _addAttachment() {
    // TODO: Implement file picker for attachments
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File attachment feature coming soon'),
      ),
    );
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'build':
        return Icons.build;
      case 'construction':
        return Icons.construction;
      case 'security':
        return Icons.security;
      case 'eco':
        return Icons.eco;
      case 'account_balance':
        return Icons.account_balance;
      case 'help_outline':
        return Icons.help_outline;
      default:
        return Icons.help_outline;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'low':
        return Colors.blue;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Feedback'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction text
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.feedback,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                          const Gap(8),
                          const Text(
                            'Your Voice Matters',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Text(
                        'We value your feedback and suggestions. Help us improve our services and address community concerns.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(24),

              // Category selection
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category['value'];
                  return FilterChip(
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category['value']!;
                      });
                    },
                    avatar: Icon(
                      _getCategoryIcon(category['icon']!),
                      size: 18,
                      color: isSelected ? Colors.white : AppTheme.primaryColor,
                    ),
                    label: Text(category['label']!),
                    selectedColor: AppTheme.primaryColor,
                    checkmarkColor: Colors.white,
                  );
                }).toList(),
              ),

              const Gap(24),

              // Priority selection
              const Text(
                'Priority Level',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(8),
              Row(
                children: _priorities.map((priority) {
                  final isSelected = _selectedPriority == priority['value'];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedPriority = priority['value']!;
                          });
                        },
                        label: Text(priority['label']!),
                        selectedColor: _getPriorityColor(priority['value']!),
                        checkmarkColor: Colors.white,
                        backgroundColor: Colors.grey.shade100,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Gap(24),

              // Subject field
              const Text(
                'Subject',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(8),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  hintText: 'Brief description of your feedback',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject';
                  }
                  if (value.trim().length < 5) {
                    return 'Subject must be at least 5 characters';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),

              const Gap(24),

              // Message field
              const Text(
                'Detailed Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(8),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Please provide detailed information about your feedback, suggestions, or concerns...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your message';
                  }
                  if (value.trim().length < 20) {
                    return 'Message must be at least 20 characters';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),

              const Gap(24),

              // Attachments section
              Row(
                children: [
                  const Text(
                    'Attachments (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _attachments.length < 3 ? _addAttachment : null,
                    icon: const Icon(Icons.add),
                    label: const Text('Add File'),
                  ),
                ],
              ),
              const Gap(8),
              if (_attachments.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 32,
                        color: Colors.grey.shade400,
                      ),
                      const Gap(8),
                      Text(
                        'No attachments added',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'You can attach up to 3 files (photos, documents)',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: _attachments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final file = entry.value;
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.attachment),
                        title: Text(file.path.split('/').last),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => _removeAttachment(index),
                          color: Colors.red,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const Gap(32),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Submit Feedback'),
                ),
              ),

              const Gap(16),

              // Disclaimer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Your feedback will be reviewed by the appropriate department. We aim to respond within 5 business days.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}