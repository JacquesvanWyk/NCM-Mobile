import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/supporters_provider.dart';
import 'supporter_registration_success_page.dart';

class SupporterRegistrationPage extends ConsumerStatefulWidget {
  const SupporterRegistrationPage({super.key});

  @override
  ConsumerState<SupporterRegistrationPage> createState() => _SupporterRegistrationPageState();
}

class _SupporterRegistrationPageState extends ConsumerState<SupporterRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _wardController = TextEditingController();

  bool _isRegisteredVoter = false;
  bool _willVote = false;
  bool _needsSpecialVote = false;
  bool _isLoading = false;

  File? _supporterPhotoFile;
  final _imagePicker = ImagePicker();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _wardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Register Supporter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                          'Register supporters to track voter sentiment and build community support. Quick and easy process.',
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
                  hintText: 'e.g. supporter@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  }
                  return null;
                },
              ),

              const Gap(16),

              // Address (Optional)
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Street Address (Optional)',
                  hintText: 'Enter street address',
                ),
                textCapitalization: TextCapitalization.words,
                maxLines: 2,
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

              // Voter Information Section
              Text(
                'Voter Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(16),

              // Registered Voter Toggle
              Card(
                child: SwitchListTile(
                  value: _isRegisteredVoter,
                  onChanged: (value) {
                    setState(() {
                      _isRegisteredVoter = value;
                      if (!value) {
                        _willVote = false;
                        _needsSpecialVote = false;
                      }
                    });
                  },
                  title: const Text(
                    'Registered Voter',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: const Text(
                    'Is this person registered to vote?',
                    style: TextStyle(fontSize: 12),
                  ),
                  activeColor: AppTheme.primaryColor,
                ),
              ),

              const Gap(8),

              // Will Vote Toggle
              Card(
                child: SwitchListTile(
                  value: _willVote,
                  onChanged: _isRegisteredVoter ? (value) {
                    setState(() {
                      _willVote = value;
                    });
                  } : null,
                  title: const Text(
                    'Will Vote',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: const Text(
                    'Plans to vote in upcoming elections',
                    style: TextStyle(fontSize: 12),
                  ),
                  activeColor: AppTheme.primaryColor,
                ),
              ),

              const Gap(8),

              // Special Vote Toggle
              Card(
                child: SwitchListTile(
                  value: _needsSpecialVote,
                  onChanged: _isRegisteredVoter ? (value) {
                    setState(() {
                      _needsSpecialVote = value;
                    });
                  } : null,
                  title: const Text(
                    'Needs Special Vote',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: const Text(
                    'Requires special voting arrangements',
                    style: TextStyle(fontSize: 12),
                  ),
                  activeColor: AppTheme.primaryColor,
                ),
              ),

              const Gap(24),

              // Photo Capture Section
              Text(
                'Photo (Optional)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(16),

              // Photo capture
              if (_supporterPhotoFile != null) ...[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      _supporterPhotoFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const Gap(12),
              ],

              OutlinedButton.icon(
                onPressed: _capturePhoto,
                icon: Icon(_supporterPhotoFile != null ? Icons.refresh : Icons.camera_alt),
                label: Text(_supporterPhotoFile != null ? 'Retake Photo' : 'Capture Photo'),
                style: _supporterPhotoFile != null
                    ? OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                      )
                    : null,
              ),

              const Gap(32),

              // Register Button
              ElevatedButton(
                onPressed: _isLoading ? null : _registerSupporter,
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
                        'Register Supporter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),

              const Gap(16),

              // Info text
              Text(
                '* Required fields',
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

  Future<void> _capturePhoto() async {
    try {
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Capture Supporter Photo'),
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
          _supporterPhotoFile = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Supporter photo captured successfully'),
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

  Future<void> _registerSupporter() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Convert photo to base64 if needed
      String? photoBase64;
      if (_supporterPhotoFile != null) {
        // Convert file to base64 string
        final bytes = await _supporterPhotoFile!.readAsBytes();
        photoBase64 = 'data:image/jpeg;base64,${bytes.toString()}';
      }

      final supporter = await ref.read(supportersProvider.notifier).createSupporter(
        name: _firstNameController.text.trim(),
        surname: _lastNameController.text.trim(),
        telephone: _phoneController.text.trim(),
        ward: _wardController.text.trim(),
        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        registeredVoter: _isRegisteredVoter ? 'yes' : 'no',
        voter: _willVote ? 'yes' : 'no',
        specialVote: _needsSpecialVote ? 'yes' : 'no',
        picture: photoBase64,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SupporterRegistrationSuccessPage(supporter: supporter),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Registration failed';

        if (e.toString().contains('DioException')) {
          final errorStr = e.toString();
          if (errorStr.contains('telephone') && errorStr.contains('already')) {
            errorMessage = 'This phone number is already registered';
          } else if (errorStr.contains('422')) {
            errorMessage = 'Validation failed. Please check all fields and try again';
          } else {
            errorMessage = 'Registration failed: ${e.toString().split('\n').first}';
          }
        } else {
          errorMessage = 'Registration failed: ${e.toString()}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
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
