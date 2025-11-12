import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../../providers/auth_provider.dart';
import '../../auth/pages/login_page.dart';

class MemberProfilePage extends ConsumerStatefulWidget {
  final String? membershipNumber;
  final VoidCallback? onBackToHome;

  const MemberProfilePage({super.key, this.membershipNumber, this.onBackToHome});

  @override
  ConsumerState<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends ConsumerState<MemberProfilePage> {
  bool _isEditing = false;

  void _showImagePickerDemo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image picker functionality requires additional dependencies'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleLogout() async {
    await AuthService.logout();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('Not logged in')),
          );
        }

        final member = user.member;

        if (member == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            body: const Center(child: Text('Member information not available')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            leading: widget.onBackToHome != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: widget.onBackToHome,
                  )
                : (Navigator.of(context).canPop()
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    : null),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _handleLogout,
                tooltip: 'Logout',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppTheme.primaryColor,
                            backgroundImage: member?.displayPicture.isNotEmpty == true
                                ? NetworkImage(member!.displayPicture)
                                : null,
                            child: member?.displayPicture.isEmpty == true
                                ? Text(
                                    member?.displayFirstName.isNotEmpty == true
                                        ? member!.displayFirstName[0].toUpperCase()
                                        : 'M',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                          if (_isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePickerDemo,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const Gap(16),
                      Text(
                        member?.displayFullName ?? 'Unknown Member',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Membership: ${member?.displayMembershipNumber ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(32),

                // Profile Information
                _buildInfoSection('Personal Information', [
                  _buildInfoItem('First Name', member?.displayFirstName ?? 'N/A'),
                  _buildInfoItem('Last Name', member?.displayLastName ?? 'N/A'),
                  _buildInfoItem('ID Number', member?.displayIdNumber ?? 'N/A'),
                  _buildInfoItem('Phone Number', member?.displayPhone ?? 'N/A'),
                  _buildInfoItem('Alternative Phone', member?.alternativePhone ?? 'N/A'),
                ]),

                const Gap(24),

                _buildInfoSection('Address Information', [
                  _buildInfoItem('Street Address', member?.displayAddress ?? 'N/A'),
                  _buildInfoItem('Suburb', member?.town ?? 'N/A'),
                  _buildInfoItem('City', member?.town ?? 'N/A'),
                  _buildInfoItem('Postal Code', 'N/A'),
                ]),

                const Gap(24),

                _buildInfoSection('Membership Information', [
                  _buildInfoItem('Status', (member?.isActive ?? false) ? 'Active' : 'Inactive'),
                  _buildInfoItem('Member Since',
                    member?.createdAt != null
                      ? '${member!.createdAt!.year}-${member.createdAt!.month.toString().padLeft(2, '0')}-${member.createdAt!.day.toString().padLeft(2, '0')}'
                      : 'N/A'
                  ),
                  _buildInfoItem('Municipality', member?.displayMunicipality ?? 'N/A'),
                  _buildInfoItem('Ward', member?.displayWard ?? 'N/A'),
                ]),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const Gap(16),
              Text('Error loading profile: $error'),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(authProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const Gap(12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: TextStyle(
                fontSize: 14,
                color: value.isNotEmpty ? AppTheme.textPrimary : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}