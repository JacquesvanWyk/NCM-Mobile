import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
// import 'package:mobile_scanner/mobile_scanner.dart'; // Temporarily commented
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/visits_provider.dart';
import 'member_profile_view_page.dart';

class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({super.key});

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  MobileScannerController? _controller;
  bool _isProcessing = false;
  String? _lastScannedCode;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _onBarcodeDetected(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? code = barcode.rawValue;

      if (code != null && code != _lastScannedCode) {
        setState(() {
          _isProcessing = true;
          _lastScannedCode = code;
        });

        await _processMemberQrCode(code);

        // Reset processing state after a short delay
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }

        break;
      }
    }
  }

  Future<void> _processMemberQrCode(String qrCode) async {
    try {
      // Verify QR code format and extract member data
      // Expected format: "NCM-MEMBER-{membershipNumber}-{timestamp}-{hash}"

      if (!qrCode.startsWith('NCM-MEMBER-')) {
        _showError('Invalid QR code format');
        return;
      }

      final parts = qrCode.split('-');
      if (parts.length < 3) {
        _showError('Invalid member QR code');
        return;
      }

      final membershipNumber = parts[2];

      // Call API service to get member details
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.findMemberByMembershipNumber(membershipNumber);

      if (response.member == null) {
        _showError('Member not found');
        return;
      }

      if (mounted) {
        // Navigate to member profile view
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MemberProfileViewPage(
              memberId: response.member!.id,
            ),
          ),
        );
      }
    } catch (error) {
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

  void _toggleTorch() {
    _controller?.toggleTorch();
  }

  void _switchCamera() {
    _controller?.switchCamera();
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
            icon: const Icon(Icons.flashlight_on),
            onPressed: _toggleTorch,
            tooltip: 'Toggle flashlight',
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: _switchCamera,
            tooltip: 'Switch camera',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera preview
          if (_controller != null)
            MobileScanner(
              controller: _controller,
              onDetect: _onBarcodeDetected,
              errorBuilder: (context, error, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const Gap(16),
                      Text(
                        'Camera Error: ${error.errorDetails?.message ?? 'Unknown error'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: _manualEntry,
                        child: const Text('Enter Manually'),
                      ),
                    ],
                  ),
                );
              },
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),

          // Scanning overlay
          Container(
            decoration: ShapeDecoration(
              shape: QrScannerOverlayShape(
                borderColor: AppTheme.primaryColor,
                borderRadius: 12,
                borderLength: 40,
                borderWidth: 4,
                cutOutSize: 250,
              ),
            ),
          ),

          // Instructions overlay
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: 32,
                  ),
                  Gap(8),
                  Text(
                    'Position QR code within the frame',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(4),
                  Text(
                    'Scanner will automatically detect the code',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Processing overlay
          if (_isProcessing)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    Gap(16),
                    Text(
                      'Processing QR code...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom action bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.keyboard,
                    label: 'Manual Entry',
                    onPressed: _manualEntry,
                  ),
                  _ActionButton(
                    icon: Icons.flashlight_on,
                    label: 'Flashlight',
                    onPressed: _toggleTorch,
                  ),
                  _ActionButton(
                    icon: Icons.flip_camera_ios,
                    label: 'Switch Camera',
                    onPressed: _switchCamera,
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: onPressed,
          iconSize: 28,
        ),
        const Gap(4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
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

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();

    // Calculate the cutout position
    final cutOutRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutSize,
      height: cutOutSize,
    );

    // Create the overlay with cutout
    path.addRect(rect);
    path.addRRect(RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)));
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final cutOutRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutSize,
      height: cutOutSize,
    );

    // Paint the overlay
    final overlayPaint = Paint()..color = overlayColor;
    final outerPath = Path()..addRect(rect);
    final innerPath = Path()..addRRect(RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)));
    final overlayPath = Path.combine(PathOperation.difference, outerPath, innerPath);
    canvas.drawPath(overlayPath, overlayPaint);

    // Paint the border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Draw corner borders
    final borderRadius = this.borderRadius;
    final borderLength = this.borderLength;

    // Top-left corner
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.left, cutOutRect.top + borderRadius)
        ..quadraticBezierTo(cutOutRect.left, cutOutRect.top, cutOutRect.left + borderRadius, cutOutRect.top)
        ..lineTo(cutOutRect.left + borderLength, cutOutRect.top),
      borderPaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.left, cutOutRect.top + borderRadius)
        ..lineTo(cutOutRect.left, cutOutRect.top + borderLength),
      borderPaint,
    );

    // Top-right corner
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.right - borderLength, cutOutRect.top)
        ..lineTo(cutOutRect.right - borderRadius, cutOutRect.top)
        ..quadraticBezierTo(cutOutRect.right, cutOutRect.top, cutOutRect.right, cutOutRect.top + borderRadius)
        ..lineTo(cutOutRect.right, cutOutRect.top + borderLength),
      borderPaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.right - borderLength, cutOutRect.top)
        ..lineTo(cutOutRect.right, cutOutRect.top),
      borderPaint,
    );

    // Bottom-left corner
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.left, cutOutRect.bottom - borderLength)
        ..lineTo(cutOutRect.left, cutOutRect.bottom - borderRadius)
        ..quadraticBezierTo(cutOutRect.left, cutOutRect.bottom, cutOutRect.left + borderRadius, cutOutRect.bottom)
        ..lineTo(cutOutRect.left + borderLength, cutOutRect.bottom),
      borderPaint,
    );

    // Bottom-right corner
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.right - borderLength, cutOutRect.bottom)
        ..lineTo(cutOutRect.right - borderRadius, cutOutRect.bottom)
        ..quadraticBezierTo(cutOutRect.right, cutOutRect.bottom, cutOutRect.right, cutOutRect.bottom - borderRadius)
        ..lineTo(cutOutRect.right, cutOutRect.bottom - borderLength),
      borderPaint,
    );
  }

  @override
  ShapeBorder scale(double t) => QrScannerOverlayShape(
        borderColor: borderColor,
        borderWidth: borderWidth,
        overlayColor: overlayColor,
      );
}