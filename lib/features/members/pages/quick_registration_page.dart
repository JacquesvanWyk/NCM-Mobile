import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/offline_sync_service.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/members_provider.dart';
import '../../../providers/municipalities_provider.dart';
import 'registration_success_page.dart';

class QuickRegistrationPage extends ConsumerStatefulWidget {
  const QuickRegistrationPage({super.key});

  @override
  ConsumerState<QuickRegistrationPage> createState() => _QuickRegistrationPageState();
}

class _QuickRegistrationPageState extends ConsumerState<QuickRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _suburbController = TextEditingController();
  final _wardController = TextEditingController();

  String _selectedGender = 'Male';
  int? _selectedMunicipalityId;
  bool _isLoading = false;

  // Photo capture
  File? _idPhotoFile;
  File? _memberPhotoFile;
  final _imagePicker = ImagePicker();

  final List<String> _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _idNumberController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _suburbController.dispose();
    _wardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quick Registration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _showOfflineHelp(),
            child: const Text('Offline Mode'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryColor,
                      ),
                      const Gap(12),
                      Expanded(
                        child: Text(
                          'Quick registration for new members during field visits. Data will sync when connected.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(24),

              // Personal Information Section
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(16),

              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name *',
                  hintText: 'Enter first name',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name *',
                  hintText: 'Enter last name',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // ID Number
              TextFormField(
                controller: _idNumberController,
                decoration: const InputDecoration(
                  labelText: 'ID Number *',
                  hintText: 'Enter 13-digit ID number',
                ),
                keyboardType: TextInputType.number,
                maxLength: 13,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID number';
                  }
                  if (value.length != 13) {
                    return 'ID number must be 13 digits';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender *',
                ),
                items: _genderOptions.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),

              const Gap(24),

              // Contact Information Section
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(16),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: 'e.g. 0821234567',
                  prefixText: '+27 ',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (value.length < 10) {
                    return 'Phone number must be at least 10 digits';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Email (Optional)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email (Optional)',
                  hintText: 'e.g. member@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Basic email validation
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Street Address *',
                  hintText: 'Enter street address',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Suburb
              TextFormField(
                controller: _suburbController,
                decoration: const InputDecoration(
                  labelText: 'Suburb *',
                  hintText: 'Enter suburb',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter suburb';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Municipality Dropdown - Hardcoded for offline support
              DropdownButtonFormField<int>(
                value: _selectedMunicipalityId,
                decoration: const InputDecoration(
                  labelText: 'Municipality *',
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Nama Khoi Municipality')),
                  DropdownMenuItem(value: 2, child: Text('Khai-Ma Municipality')),
                  DropdownMenuItem(value: 3, child: Text('Karoo Hoogland Municipality')),
                  DropdownMenuItem(value: 4, child: Text('Kamiesberg Municipality')),
                  DropdownMenuItem(value: 5, child: Text('Hantam Municipality')),
                  DropdownMenuItem(value: 6, child: Text('Richtersveld Municipality')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedMunicipalityId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a municipality';
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Ward
              TextFormField(
                controller: _wardController,
                decoration: const InputDecoration(
                  labelText: 'Ward *',
                  hintText: 'Enter ward number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ward number';
                  }
                  return null;
                },
              ),

              const Gap(24),

              // Photo Capture Section
              Text(
                'Documentation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(16),

              // Photo capture buttons
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (_idPhotoFile != null) ...[
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                _idPhotoFile!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const Gap(8),
                        ],
                        OutlinedButton.icon(
                          onPressed: () => _capturePhoto('id'),
                          icon: Icon(_idPhotoFile != null ? Icons.refresh : Icons.credit_card),
                          label: Text(_idPhotoFile != null ? 'Retake ID' : 'Capture ID'),
                          style: _idPhotoFile != null
                              ? OutlinedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  side: const BorderSide(color: Colors.green),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      children: [
                        if (_memberPhotoFile != null) ...[
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                _memberPhotoFile!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const Gap(8),
                        ],
                        OutlinedButton.icon(
                          onPressed: () => _capturePhoto('member'),
                          icon: Icon(_memberPhotoFile != null ? Icons.refresh : Icons.camera_alt),
                          label: Text(_memberPhotoFile != null ? 'Retake Photo' : 'Member Photo'),
                          style: _memberPhotoFile != null
                              ? OutlinedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  side: const BorderSide(color: Colors.green),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Gap(32),

              // Register Button
              ElevatedButton(
                onPressed: _isLoading ? null : _registerMember,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Register Member',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),

              const Gap(16),

              // Info text
              Text(
                '* Required fields. Registration will be saved offline and synchronized when internet connection is available.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _capturePhoto(String type) async {
    try {
      // Show options: Camera or Gallery
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Capture ${type == 'id' ? 'ID' : 'Member'} Photo'),
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
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          if (type == 'id') {
            _idPhotoFile = File(image.path);
          } else {
            _memberPhotoFile = File(image.path);
          }
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${type == 'id' ? 'ID' : 'Member'} photo captured successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error capturing photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showOfflineHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Offline Mode'),
        content: const Text(
          'You can register new members even without internet connection. '
          'All data will be safely stored on your device and automatically '
          'synchronized when you reconnect to the internet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Future<void> _registerMember() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Extract birthdate from ID number (basic SA ID format: YYMMDD...)
      final idNumber = _idNumberController.text;
      final year = int.parse(idNumber.substring(0, 2));
      final month = int.parse(idNumber.substring(2, 4));
      final day = int.parse(idNumber.substring(4, 6));

      // Assume 20xx for years < 30, 19xx for years >= 30
      final fullYear = year < 30 ? 2000 + year : 1900 + year;
      final dateOfBirth = DateTime(fullYear, month, day);

      if (_selectedMunicipalityId == null) {
        throw Exception('Please select a municipality');
      }

      // Prepare member data
      final memberData = {
        'id_number': idNumber,
        'name': _firstNameController.text.trim(),
        'surname': _lastNameController.text.trim(),
        'date_of_birth': dateOfBirth.toIso8601String(),
        'gender': _selectedGender,
        'tel_number': _phoneController.text.trim(),
        'email': _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        'address': _addressController.text.trim(),
        'town': _suburbController.text.trim(),
        'ward': _wardController.text.trim(),
        'municipality_id': _selectedMunicipalityId!,
      };

      // Add to offline sync queue (will sync immediately if online)
      final offlineSyncService = ref.read(offlineSyncServiceProvider);
      await offlineSyncService.addToSyncQueue(
        type: 'member',
        data: memberData,
        action: 'create',
      );

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              offlineSyncService.getSyncStatus()['isOnline']
                  ? 'Member registered successfully!'
                  : 'Member saved offline. Will sync when connected.',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        // Navigate back or to success page
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}