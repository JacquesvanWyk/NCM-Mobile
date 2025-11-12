import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/services/api_service.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/visits_provider.dart';

class DigitalMembershipCardPage extends ConsumerStatefulWidget {
  const DigitalMembershipCardPage({super.key});

  @override
  ConsumerState<DigitalMembershipCardPage> createState() =>
      _DigitalMembershipCardPageState();
}

class _DigitalMembershipCardPageState
    extends ConsumerState<DigitalMembershipCardPage> {
  String? qrData;
  String? qrImage;
  bool isLoading = false;
  String? error;
  DateTime? expiresAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateQrCode();
    });
  }

  Future<void> _generateQrCode() async {
    if (isLoading) return;

    final userAsync = ref.read(authProvider);
    final user = userAsync.valueOrNull;
    if (user?.member == null) {
      setState(() {
        error = 'Member information not found';
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.generateMemberQrCode(user!.member!.id);

      setState(() {
        qrData = response.qrData;
        qrImage = response.qrImage;
        expiresAt = DateTime.parse(response.expiresAt);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to generate QR code: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  void _refreshQrCode() {
    setState(() {
      qrData = null;
      qrImage = null;
      expiresAt = null;
    });
    _generateQrCode();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authProvider);
    final user = userAsync.valueOrNull;
    final member = user?.member;

    if (member == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Digital Membership Card'),
        ),
        body: const Center(
          child: Text('Member information not found'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Digital Membership Card'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: _refreshQrCode,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Membership Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Member Avatar/Photo
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30.r),
                          image: member.displayPicture.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(member.displayPicture),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: member.displayPicture.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 30.sp,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Gap(16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NCM MEMBERSHIP',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              member.displayFullName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),

                  // Member Details
                  _buildInfoRow('Member ID', member.displayMembershipNumber),
                  Gap(8.h),
                  _buildInfoRow('ID Number', member.displayIdNumber),
                  Gap(8.h),
                  _buildInfoRow('Municipality', member.displayMunicipality),
                  Gap(8.h),
                  _buildInfoRow('Ward', member.displayWard),

                  Gap(20.h),

                  // Status
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      member.isActive ? 'ACTIVE MEMBER' : 'INACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(24.h),

            // QR Code Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Text(
                    'Digital Membership QR Code',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Show this QR code to field workers for visit verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  Gap(24.h),

                  // QR Code Display
                  if (isLoading)
                    Container(
                      width: 200.w,
                      height: 200.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (error != null)
                    Container(
                      width: 200.w,
                      height: 200.w,
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red[600],
                            size: 48.sp,
                          ),
                          Gap(8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              error!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (qrData != null)
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: QrImageView(
                        data: qrData!,
                        version: QrVersions.auto,
                        size: 200.w,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),

                  if (expiresAt != null) ...[
                    Gap(16.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16.sp,
                            color: Colors.orange[700],
                          ),
                          Gap(6.w),
                          Text(
                            'Expires: ${_formatExpiryTime(expiresAt!)}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  Gap(24.h),

                  // Refresh Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: isLoading ? null : _refreshQrCode,
                      icon: Icon(
                        Icons.refresh,
                        size: 18.sp,
                      ),
                      label: const Text('Refresh QR Code'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(24.h),

            // Usage Instructions
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue[200]!),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue[600],
                        size: 20.sp,
                      ),
                      Gap(8.w),
                      Text(
                        'How to use',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Text(
                    '• Show this QR code to field workers for visit verification\n'
                    '• QR codes expire after 24 hours for security\n'
                    '• Refresh the code if it has expired\n'
                    '• Keep your phone screen bright for easier scanning',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.blue[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatExpiryTime(DateTime expiry) {
    final now = DateTime.now();
    final difference = expiry.difference(now);

    if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Expired';
    }
  }
}