import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/services/api_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/visit_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/visits_provider.dart';
import 'visit_notes_page.dart';

class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({super.key});

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isProcessing = false;
  String? error;
  bool hasCameraPermission = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      hasCameraPermission = status.isGranted;
    });

    if (!status.isGranted) {
      setState(() {
        error = 'Camera permission is required to scan QR codes';
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _handleQrCodeScanned(BarcodeCapture capture) async {
    if (isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? qrData = barcodes.first.rawValue;
    if (qrData == null) return;

    setState(() {
      isProcessing = true;
      error = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);

      // First verify the QR code
      final verifyResponse = await apiService.post(
        '/qr-code/verify',
        {'qr_data': qrData},
      );

      if (verifyResponse.statusCode == 200) {
        final memberData = verifyResponse.data['member'];

        // Show member info and ask for confirmation
        _showMemberConfirmation(memberData, qrData);
      } else {
        throw Exception(verifyResponse.data['message'] ?? 'Invalid QR code');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isProcessing = false;
      });

      // Show error dialog
      _showErrorDialog(e.toString());
    }
  }

  void _showMemberConfirmation(Map<String, dynamic> memberData, String qrData) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24.sp,
            ),
            Gap(8.w),
            const Text('Member Verified'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMemberInfoRow('Name', '${memberData['first_name']} ${memberData['last_name']}'),
            Gap(8.h),
            _buildMemberInfoRow('Member ID', memberData['membership_number']),
            Gap(8.h),
            _buildMemberInfoRow('Municipality', memberData['municipality'] ?? 'N/A'),
            Gap(8.h),
            _buildMemberInfoRow('Phone', memberData['phone_number']),
            Gap(16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: memberData['is_active'] ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: memberData['is_active'] ? Colors.green[200]! : Colors.red[200]!,
                ),
              ),
              child: Text(
                memberData['is_active'] ? 'Active Member' : 'Inactive Member',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: memberData['is_active'] ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Gap(16.h),
            const Text(
              'Would you like to create a visit record for this member?',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isProcessing = false;
              });
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _createVisitFromQr(qrData, memberData);
            },
            child: const Text('Create Visit'),
          ),
        ],
      ),
    );
  }

  Future<void> _createVisitFromQr(String qrData, Map<String, dynamic> memberData) async {
    try {
      final apiService = ref.read(apiServiceProvider);

      final response = await apiService.post(
        '/qr-code/create-visit',
        {
          'qr_data': qrData,
          'visit_type': 'qr_scan',
          'purpose': 'QR code verification visit',
        },
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(memberData, response.data['visit']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to create visit');
      }
    } catch (e) {
      _showErrorDialog('Failed to create visit: ${e.toString()}');
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void _showSuccessDialog(Map<String, dynamic> memberData, Map<String, dynamic> visitData) {
    // Parse the visit data into VisitModel
    final visit = VisitModel.fromJson(visitData);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24.sp,
            ),
            Gap(8.w),
            const Text('Visit Created'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Visit successfully created for ${memberData['first_name']} ${memberData['last_name']}'),
            Gap(16.h),
            const Text(
              'Would you like to add notes for this visit?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to dashboard
            },
            child: const Text('Skip'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close scanner

              // Navigate to visit notes page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => VisitNotesPage(visit: visit),
                ),
              );
            },
            child: const Text('Add Notes'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 24.sp,
            ),
            Gap(8.w),
            const Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isProcessing = false;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);

    // Check if user is a field worker
    if (user?.fieldWorker == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanner'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: const Center(
          child: Text('Only field workers can scan QR codes'),
        ),
      );
    }

    if (!hasCameraPermission) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanner'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 64.sp,
                color: Colors.grey[400],
              ),
              Gap(16.h),
              Text(
                'Camera Permission Required',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Gap(8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  'This app needs camera permission to scan QR codes. Please grant permission in your device settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Gap(24.h),
              ElevatedButton(
                onPressed: _requestCameraPermission,
                child: const Text('Request Permission'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan Member QR Code'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => cameraController.toggleTorch(),
            icon: const Icon(Icons.flash_on),
          ),
          IconButton(
            onPressed: () => cameraController.switchCamera(),
            icon: const Icon(Icons.flip_camera_ios),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: cameraController,
            onDetect: _handleQrCodeScanned,
          ),

          // Overlay with scanning frame
          CustomPaint(
            painter: ScannerOverlayPainter(),
            size: Size.infinite,
          ),

          // Instructions
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Text(
                    'Point your camera at a member\'s QR code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (isProcessing) ...[
                    Gap(12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        Gap(12.w),
                        const Text(
                          'Processing...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                  if (error != null) ...[
                    Gap(12.h),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Text(
                        error!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red[100],
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double scanAreaSize = size.width * 0.7;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;

    // Draw dark overlay
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize),
              const Radius.circular(12),
            ),
          ),
      ),
      paint,
    );

    // Draw corner borders
    final double cornerLength = 30;
    final double cornerOffset = 12;

    // Top-left corner
    canvas.drawPath(
      Path()
        ..moveTo(left - cornerOffset, top + cornerLength)
        ..lineTo(left - cornerOffset, top - cornerOffset)
        ..lineTo(left + cornerLength, top - cornerOffset),
      borderPaint,
    );

    // Top-right corner
    canvas.drawPath(
      Path()
        ..moveTo(left + scanAreaSize - cornerLength, top - cornerOffset)
        ..lineTo(left + scanAreaSize + cornerOffset, top - cornerOffset)
        ..lineTo(left + scanAreaSize + cornerOffset, top + cornerLength),
      borderPaint,
    );

    // Bottom-left corner
    canvas.drawPath(
      Path()
        ..moveTo(left - cornerOffset, top + scanAreaSize - cornerLength)
        ..lineTo(left - cornerOffset, top + scanAreaSize + cornerOffset)
        ..lineTo(left + cornerLength, top + scanAreaSize + cornerOffset),
      borderPaint,
    );

    // Bottom-right corner
    canvas.drawPath(
      Path()
        ..moveTo(left + scanAreaSize - cornerLength, top + scanAreaSize + cornerOffset)
        ..lineTo(left + scanAreaSize + cornerOffset, top + scanAreaSize + cornerOffset)
        ..lineTo(left + scanAreaSize + cornerOffset, top + scanAreaSize - cornerLength),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}