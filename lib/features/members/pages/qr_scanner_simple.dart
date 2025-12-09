import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/api_provider.dart';
import 'member_profile_view_page.dart';

class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({super.key});

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  bool _isProcessing = false;
  String? _lastScannedCode;

  Future<void> _processMemberQrCode(String qrCode) async {
    try {
      setState(() => _isProcessing = true);

      if (!qrCode.startsWith('NCM-MEMBER-')) {
        _showError('Invalid QR code format');
        setState(() => _isProcessing = false);
        return;
      }

      final parts = qrCode.split('-');
      if (parts.length < 3) {
        _showError('Invalid member QR code');
        setState(() => _isProcessing = false);
        return;
      }

      final membershipNumber = parts[2];

      // Fetch member by membership number to get the ID
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.findMemberByMembershipNumber(membershipNumber);

      if (response.member == null) {
        _showError('Member not found');
        setState(() => _isProcessing = false);
        return;
      }

      setState(() => _isProcessing = false);

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MemberProfileViewPage(
              memberId: response.member!.id,
            ),
          ),
        );
      }
    } catch (error) {
      setState(() => _isProcessing = false);
      _showError('Failed to process QR code: $error');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _manualEntry() {
    showDialog(
      context: context,
      builder: (context) => _ManualEntryDialog(
        onSubmit: (membershipNumber) async {
          Navigator.of(context).pop();
          await _processMemberQrCode('NCM-MEMBER-$membershipNumber-manual-entry');
        },
      ),
    );
  }

  void _simulateQRScan() {
    setState(() => _isProcessing = true);

    // Simulate QR scan with real membership number from database
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        _processMemberQrCode('NCM-MEMBER-NK2024001-${DateTime.now().millisecondsSinceEpoch}-abc123');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Member QR Code'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'QR Code Scanner',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const Gap(8),
            Text(
              'Scan a member\'s QR code to view their profile and perform field worker actions.',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
            const Gap(24),

            // Camera Preview Area (Mock)
            Expanded(
              child: Card(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: _isProcessing
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Gap(16),
                            Text(
                              'Scanning QR Code...',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              size: 64,
                              color: Colors.grey.shade600,
                            ),
                            const Gap(16),
                            Text(
                              'QR Code Scanner',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Camera functionality requires additional permissions',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(24),
                            ElevatedButton.icon(
                              onPressed: _simulateQRScan,
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Simulate QR Scan'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const Gap(16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _manualEntry,
                    icon: const Icon(Icons.keyboard),
                    label: const Text('Manual Entry'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : _simulateQRScan,
                    icon: _isProcessing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.qr_code),
                    label: const Text('Demo Scan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const Gap(16),

            // Tips Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.blue.shade700),
                        const Gap(8),
                        Text(
                          'Demo Mode',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      '• Use "Demo Scan" to simulate scanning a member QR code\n• Use "Manual Entry" to enter membership number directly\n• Real camera functionality requires mobile_scanner package',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManualEntryDialog extends StatefulWidget {
  final Function(String) onSubmit;

  const _ManualEntryDialog({
    required this.onSubmit,
  });

  @override
  State<_ManualEntryDialog> createState() => _ManualEntryDialogState();
}

class _ManualEntryDialogState extends State<_ManualEntryDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Membership Number'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter the member\'s NCM membership number manually:',
              style: TextStyle(fontSize: 14),
            ),
            const Gap(16),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Membership Number',
                hintText: 'e.g., NCM001234',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.card_membership),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a membership number';
                }
                if (value.trim().length < 6) {
                  return 'Membership number must be at least 6 characters';
                }
                return null;
              },
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
            if (_formKey.currentState!.validate()) {
              widget.onSubmit(_controller.text.trim());
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}