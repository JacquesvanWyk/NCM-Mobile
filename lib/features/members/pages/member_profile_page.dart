import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/profile_provider.dart';
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
  bool _isSaving = false;
  File? _newPhotoFile;
  final _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // Controllers for editable fields
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternativePhoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _townController = TextEditingController();
  final _wardController = TextEditingController();
  final _dobController = TextEditingController();
  final _nationalityController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateControllers();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _alternativePhoneController.dispose();
    _addressController.dispose();
    _townController.dispose();
    _wardController.dispose();
    _dobController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  void _populateControllers() {
    final user = ref.read(authProvider).valueOrNull;
    final member = user?.member;
    if (member != null) {
      _nameController.text = member.name ?? '';
      _surnameController.text = member.surname ?? '';
      _emailController.text = member.email ?? '';
      _phoneController.text = member.phoneNumber ?? member.telNumber ?? '';
      _alternativePhoneController.text = member.alternativePhone ?? '';
      _addressController.text = member.address ?? '';
      _townController.text = member.town ?? '';
      _wardController.text = member.ward ?? '';
      _dobController.text = member.dateOfBirth ?? '';
      _nationalityController.text = member.nationality ?? '';
      _selectedGender = member.gender;
    }
  }

  Future<void> _pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Profile Photo'),
        content: const Text('Choose a source:'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Camera'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            icon: const Icon(Icons.photo_library),
            label: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (source == null) return;

    final XFile? image = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _newPhotoFile = File(image.path);
      });
    }
  }

  Future<void> _selectDateOfBirth() async {
    final initialDate = _dobController.text.isNotEmpty
        ? DateTime.tryParse(_dobController.text) ?? DateTime.now().subtract(const Duration(days: 6570))
        : DateTime.now().subtract(const Duration(days: 6570));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      // Upload new photo first if selected
      if (_newPhotoFile != null) {
        await ref.read(profileProvider.notifier).uploadPhoto(_newPhotoFile!);
      }

      // Update profile data
      final request = UpdateProfileRequest(
        name: _nameController.text.trim(),
        surname: _surnameController.text.trim(),
        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        alternativePhone: _alternativePhoneController.text.trim().isEmpty ? null : _alternativePhoneController.text.trim(),
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        town: _townController.text.trim().isEmpty ? null : _townController.text.trim(),
        ward: _wardController.text.trim().isEmpty ? null : _wardController.text.trim(),
        dateOfBirth: _dobController.text.trim().isEmpty ? null : _dobController.text.trim(),
        nationality: _nationalityController.text.trim().isEmpty ? null : _nationalityController.text.trim(),
        gender: _selectedGender,
      );

      await ref.read(profileProvider.notifier).updateProfile(request);

      if (mounted) {
        setState(() {
          _isEditing = false;
          _isSaving = false;
          _newPhotoFile = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        String errorMessage = 'Failed to update profile';
        if (e is DioException) {
          final responseData = e.response?.data;
          if (responseData is Map && responseData['message'] != null) {
            errorMessage = responseData['message'];
          } else {
            errorMessage = 'Error ${e.response?.statusCode}: ${e.message}';
          }
        } else {
          errorMessage = e.toString();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _newPhotoFile = null;
    });
    _populateControllers();
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

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return null;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
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
              if (!_isEditing)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => setState(() => _isEditing = true),
                  tooltip: 'Edit Profile',
                )
              else ...[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _isSaving ? null : _cancelEditing,
                  tooltip: 'Cancel',
                ),
                IconButton(
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check),
                  onPressed: _isSaving ? null : _saveProfile,
                  tooltip: 'Save',
                ),
              ],
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _handleLogout,
                tooltip: 'Logout',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
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
                              backgroundImage: _newPhotoFile != null
                                  ? FileImage(_newPhotoFile!)
                                  : (member.displayPicture.isNotEmpty
                                      ? NetworkImage(member.displayPicture)
                                      : null) as ImageProvider?,
                              child: (_newPhotoFile == null && member.displayPicture.isEmpty)
                                  ? Text(
                                      member.displayFirstName.isNotEmpty
                                          ? member.displayFirstName[0].toUpperCase()
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
                                  onTap: _isSaving ? null : _pickImage,
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
                        if (!_isEditing) ...[
                          Text(
                            member.displayFullName.isNotEmpty ? member.displayFullName : 'Unknown Member',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            'Membership: ${member.displayMembershipNumber.isNotEmpty ? member.displayMembershipNumber : 'N/A'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const Gap(32),

                  if (_isEditing) ...[
                    // Editable Form Fields
                    _buildSection('Personal Information', [
                      _buildTextField(
                        controller: _nameController,
                        label: 'First Name',
                        validator: (v) => _validateRequired(v, 'First name'),
                      ),
                      _buildTextField(
                        controller: _surnameController,
                        label: 'Last Name',
                        validator: (v) => _validateRequired(v, 'Last name'),
                      ),
                      _buildDisabledField('ID Number', member.displayIdNumber),
                      GestureDetector(
                        onTap: _isSaving ? null : _selectDateOfBirth,
                        child: AbsorbPointer(
                          child: _buildTextField(
                            controller: _dobController,
                            label: 'Date of Birth',
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      _buildTextField(
                        controller: _nationalityController,
                        label: 'Nationality',
                      ),
                      _buildGenderDropdown(),
                    ]),
                    const Gap(24),
                    _buildSection('Contact Information', [
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),
                      _buildTextField(
                        controller: _alternativePhoneController,
                        label: 'Alternative Phone',
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),
                    ]),
                    const Gap(24),
                    _buildSection('Address Information', [
                      _buildTextField(
                        controller: _addressController,
                        label: 'Street Address',
                        maxLines: 2,
                      ),
                      _buildTextField(
                        controller: _townController,
                        label: 'Town/Suburb',
                      ),
                      _buildTextField(
                        controller: _wardController,
                        label: 'Ward',
                      ),
                    ]),
                    const Gap(24),
                    _buildSection('Membership Information', [
                      _buildDisabledField('Membership Number', member.displayMembershipNumber),
                      _buildDisabledField('Status', member.isActive ? 'Active' : 'Inactive'),
                      _buildDisabledField('Municipality', member.displayMunicipality),
                      _buildDisabledField('Member Since', member.createdAt != null
                          ? '${member.createdAt!.year}-${member.createdAt!.month.toString().padLeft(2, '0')}-${member.createdAt!.day.toString().padLeft(2, '0')}'
                          : 'N/A'),
                    ]),
                  ] else ...[
                    // View Mode
                    _buildInfoSection('Personal Information', [
                      _buildInfoItem('First Name', member.displayFirstName),
                      _buildInfoItem('Last Name', member.displayLastName),
                      _buildInfoItem('ID Number', member.displayIdNumber),
                      _buildInfoItem('Date of Birth', member.dateOfBirth ?? 'N/A'),
                      _buildInfoItem('Nationality', member.nationality ?? 'N/A'),
                      _buildInfoItem('Gender', _formatGender(member.gender)),
                    ]),

                    const Gap(24),

                    _buildInfoSection('Contact Information', [
                      _buildInfoItem('Email', member.email ?? 'N/A'),
                      _buildInfoItem('Phone Number', member.displayPhone),
                      _buildInfoItem('Alternative Phone', member.alternativePhone ?? 'N/A'),
                    ]),

                    const Gap(24),

                    _buildInfoSection('Address Information', [
                      _buildInfoItem('Street Address', member.displayAddress),
                      _buildInfoItem('Town/Suburb', member.town ?? 'N/A'),
                      _buildInfoItem('Ward', member.displayWard),
                    ]),

                    const Gap(24),

                    _buildInfoSection('Membership Information', [
                      _buildInfoItem('Membership Number', member.displayMembershipNumber),
                      _buildInfoItem('Status', member.isActive ? 'Active' : 'Inactive'),
                      _buildInfoItem('Municipality', member.displayMunicipality),
                      _buildInfoItem('Member Since',
                          member.createdAt != null
                              ? '${member.createdAt!.year}-${member.createdAt!.month.toString().padLeft(2, '0')}-${member.createdAt!.day.toString().padLeft(2, '0')}'
                              : 'N/A'),
                    ]),
                  ],
                ],
              ),
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

  String _formatGender(String? gender) {
    if (gender == null || gender.isEmpty) return 'N/A';
    return gender[0].toUpperCase() + gender.substring(1).toLowerCase();
  }

  Widget _buildSection(String title, List<Widget> children) {
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
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: !_isSaving,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value.isNotEmpty ? value : 'N/A',
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedGender,
        decoration: InputDecoration(
          labelText: 'Gender',
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.primaryColor),
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'male', child: Text('Male')),
          DropdownMenuItem(value: 'female', child: Text('Female')),
          DropdownMenuItem(value: 'other', child: Text('Other')),
        ],
        onChanged: _isSaving ? null : (value) => setState(() => _selectedGender = value),
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
