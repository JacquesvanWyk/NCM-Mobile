import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/notification_provider.dart';

class SendNotificationPage extends ConsumerStatefulWidget {
  const SendNotificationPage({super.key});

  @override
  ConsumerState<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends ConsumerState<SendNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String _recipientType = 'all';
  bool _isSending = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Push Notification'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter notification title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                maxLength: 255,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const Gap(16),

              // Body field
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter notification message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.message),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                maxLength: 1000,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const Gap(16),

              // Recipient type
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Send to',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(12),
                      RadioListTile<String>(
                        title: const Text('All Users'),
                        subtitle: const Text('Send to all app users'),
                        value: 'all',
                        groupValue: _recipientType,
                        onChanged: (value) {
                          setState(() {
                            _recipientType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Members Only'),
                        subtitle: const Text('Send to members only'),
                        value: 'members',
                        groupValue: _recipientType,
                        onChanged: (value) {
                          setState(() {
                            _recipientType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Leaders Only'),
                        subtitle: const Text('Send to leaders only'),
                        value: 'leaders',
                        groupValue: _recipientType,
                        onChanged: (value) {
                          setState(() {
                            _recipientType = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(24),

              // Preview card
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.preview, size: 20),
                          const Gap(8),
                          const Text(
                            'Preview',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Gap(12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _titleController.text.isEmpty
                                        ? 'Notification Title'
                                        : _titleController.text,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    _bodyController.text.isEmpty
                                        ? 'Notification message will appear here'
                                        : _bodyController.text,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textSecondary,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(24),

              // Send button
              ElevatedButton(
                onPressed: _isSending ? null : _sendNotification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSending
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          Gap(12),
                          Text('Sending...'),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send),
                          Gap(8),
                          Text(
                            'Send Notification',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendNotification() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      final service = ref.read(sendPushNotificationProvider);
      final result = await service.send(
        title: _titleController.text,
        body: _bodyController.text,
        recipientType: _recipientType,
      );

      if (mounted) {
        final notification = result['notification'] as Map<String, dynamic>;
        final sentCount = notification['sent_count'] as int;
        final failedCount = notification['failed_count'] as int;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Gap(8),
                Text('Notification Sent'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Successfully sent: $sentCount'),
                Text('Failed: $failedCount'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to hub
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );

        // Clear form
        _titleController.clear();
        _bodyController.clear();
        setState(() {
          _recipientType = 'all';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send notification: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }
}
