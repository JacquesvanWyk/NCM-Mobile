import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/api_provider.dart';
import 'member_profile_view_page.dart';

class QrScannerCameraPage extends ConsumerStatefulWidget {
  const QrScannerCameraPage({super.key});

  @override
  ConsumerState<QrScannerCameraPage> createState() => _QrScannerCameraPageState();
}

class _QrScannerCameraPageState extends ConsumerState<QrScannerCameraPage> {
  final MobileScannerController controller = MobileScannerController();
  bool _isProcessing = false;
  String? _lastScannedCode;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _processMemberQrCode(String qrCode) async {
    // Prevent duplicate scans
    if (_lastScannedCode == qrCode && _isProcessing) {
      return;
    }

    _lastScannedCode = qrCode;

    try {
      setState(() => _isProcessing = true);

      // Expected format: NCM-MEMBER-{membershipNumber} or just {membershipNumber}
      String membershipNumber;

      if (qrCode.startsWith('NCM-MEMBER-')) {
        final parts = qrCode.split('-');
        if (parts.length < 3) {
          _showError('Invalid member QR code format');
          setState(() => _isProcessing = false);
          return;
        }
        membershipNumber = parts[2];
      } else if (qrCode.startsWith('NCM')) {
        // Direct membership number like NCM3075
        membershipNumber = qrCode;
      } else {
        _showError('Invalid QR code - must be NCM membership number');
        setState(() => _isProcessing = false);
        return;
      }

      // Fetch member by membership number
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.findMemberByMembershipNumber(membershipNumber);

      if (response.member == null) {
        _showError('Member not found: $membershipNumber');
        setState(() => _isProcessing = false);
        return;
      }

      setState(() => _isProcessing = false);

      if (mounted) {
        // Navigate to member profile
        Navigator.of(context).pushReplacement(
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
          duration: const Duration(seconds: 3),
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
          await _processMemberQrCode(membershipNumber);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Member QR Code'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
            tooltip: 'Toggle Flash',
          ),
          IconButton(
            icon: const Icon(Icons.keyboard),
            onPressed: _manualEntry,
            tooltip: 'Manual Entry',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera preview
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null && !_isProcessing) {
                  _processMemberQrCode(barcode.rawValue!);
                  break;
                }
              }
            },
          ),

          // Scanning overlay
          if (!_isProcessing)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.primaryColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

          // Processing overlay
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        Gap(16),
                        Text(
                          'Processing QR Code...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Instructions at bottom
          if (!_isProcessing)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Position the QR code within the frame',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(8),
                    Text(
                      'Or use Manual Entry button above',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
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
              'Enter the member\'s NCM membership number:',
              style: TextStyle(fontSize: 14),
            ),
            const Gap(16),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Membership Number',
                hintText: 'e.g., NCM3075',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.card_membership),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a membership number';
                }
                if (!value.trim().toUpperCase().startsWith('NCM')) {
                  return 'Membership number must start with NCM';
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
              widget.onSubmit(_controller.text.trim().toUpperCase());
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
