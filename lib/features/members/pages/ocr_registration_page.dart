import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/sa_id_parser.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/members_provider.dart';
import '../../../providers/municipalities_provider.dart';
import '../../../providers/visits_provider.dart';

class OcrRegistrationPage extends ConsumerStatefulWidget {
  const OcrRegistrationPage({super.key});

  @override
  ConsumerState<OcrRegistrationPage> createState() => _OcrRegistrationPageState();
}

class _OcrRegistrationPageState extends ConsumerState<OcrRegistrationPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isProcessing = false;
  bool _isScanning = false;

  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _suburbController = TextEditingController();
  final _wardController = TextEditingController();

  // OCR Results
  Map<String, dynamic>? _ocrResults;
  String? _capturedImagePath;
  File? _capturedImageFile;
  String? _extractedText;
  String? _selectedGender;
  int? _selectedMunicipalityId;

  // Image picker
  final _imagePicker = ImagePicker();

  final List<String> _documentTypes = [
    'South African ID',
    'Passport',
    'Driving License',
    'Other Government ID',
  ];

  String _selectedDocumentType = 'South African ID';

  @override
  void dispose() {
    _pageController.dispose();
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
        title: const Text('OCR Registration'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _currentStep == 2 && !_isProcessing ? _completeRegistration : null,
              child: const Text(
                'Complete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                _buildStepIndicator(0, 'Scan', _currentStep >= 0),
                Expanded(child: Divider(color: _currentStep >= 1 ? AppTheme.primaryColor : Colors.grey)),
                _buildStepIndicator(1, 'Extract', _currentStep >= 1),
                Expanded(child: Divider(color: _currentStep >= 2 ? AppTheme.primaryColor : Colors.grey)),
                _buildStepIndicator(2, 'Verify', _currentStep >= 2),
              ],
            ),
          ),

          // Page Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildScanStep(),
                _buildExtractionStep(),
                _buildVerificationStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
          child: Text(
            '${step + 1}',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? AppTheme.primaryColor : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildScanStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scan Identity Document',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Take a clear photo of the member\'s identity document to automatically extract their information.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),

          // Document Type Selection
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Document Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(12),
                  DropdownButtonFormField<String>(
                    value: _selectedDocumentType,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: _documentTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDocumentType = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Camera Preview Area
          Card(
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: _capturedImageFile != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _capturedImageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check, color: Colors.white, size: 16),
                                Gap(4),
                                Text(
                                  'Captured',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : _isScanning
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Gap(16),
                              Text(
                                'Initializing camera...',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 64,
                              color: Colors.grey.shade600,
                            ),
                            const Gap(16),
                            Text(
                              'Tap to capture document',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
            ),
          ),

          const Gap(24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _captureFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isScanning ? null : _captureFromCamera,
                  icon: _isScanning
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.camera_alt),
                  label: Text(_capturedImageFile != null ? 'Retake' : 'Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),

          const Gap(16),

          // Next Button
          if (_capturedImageFile != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _proceedToExtraction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Process Document',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                        'Tips for better scanning',
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
                    '• Ensure good lighting\n• Keep document flat and straight\n• Avoid shadows and reflections\n• Fill the entire frame with the document',
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
    );
  }

  Widget _buildExtractionStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Processing Document',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Extracting information from the document using OCR technology.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(32),

          Expanded(
            child: Center(
              child: _isProcessing
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                        Gap(24),
                        Text(
                          'Analyzing document...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(8),
                        Text(
                          'This may take a few seconds',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            size: 64,
                            color: Colors.green.shade600,
                          ),
                        ),
                        const Gap(24),
                        const Text(
                          'Extraction Complete!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          'Member information has been extracted successfully.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const Gap(32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _proceedToVerification,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Review Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify & Complete',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Review and confirm the extracted information before completing the registration.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),

          // Personal Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _idNumberController,
                    decoration: const InputDecoration(
                      labelText: 'ID Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Contact Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _suburbController,
                    decoration: const InputDecoration(
                      labelText: 'Suburb',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: _wardController,
                    decoration: const InputDecoration(
                      labelText: 'Ward',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Municipality Dropdown
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Municipality',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  // Hardcoded municipalities for offline support
                  DropdownButtonFormField<int>(
                    value: _selectedMunicipalityId,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          // Complete Registration Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _completeRegistration,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Complete Registration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _captureFromCamera() async {
    setState(() => _isScanning = true);

    try {
      // Request camera permission
      final cameraStatus = await Permission.camera.request();

      if (cameraStatus.isDenied) {
        throw Exception('Camera permission denied');
      }

      // Capture image from camera
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _capturedImagePath = image.path;
          _capturedImageFile = File(image.path);
          _isScanning = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document captured successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        setState(() => _isScanning = false);
      }
    } catch (e) {
      setState(() => _isScanning = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _captureFromGallery() async {
    try {
      // Request photo library permission
      final photosStatus = await Permission.photos.request();

      if (photosStatus.isDenied) {
        throw Exception('Photo library permission denied');
      }

      // Pick image from gallery
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _capturedImagePath = image.path;
          _capturedImageFile = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document selected successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gallery error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _proceedToExtraction() async {
    if (_capturedImagePath == null) return;

    setState(() {
      _currentStep = 1;
      _isProcessing = true;
    });

    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    try {
      // Upload image to server for OCR processing
      final dio = ref.read(dioProvider);
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          _capturedImagePath!,
          filename: 'id_document.jpg',
        ),
      });

      final response = await dio.post(
        '/api/ocr/process-id',
        data: formData,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        _extractedText = response.data['extracted_text'];

        _ocrResults = {
          'id_number': data['id_number'],
          'date_of_birth': data['date_of_birth'],
          'gender': data['gender'],
          'first_name': data['first_name'] ?? '',
          'last_name': data['last_name'] ?? '',
          'citizenship_status': data['citizenship_status'],
        };

        // Populate form fields
        _idNumberController.text = data['id_number'] ?? '';
        _firstNameController.text = data['first_name'] ?? '';
        _lastNameController.text = data['last_name'] ?? '';
        _selectedGender = data['gender'];

        setState(() => _isProcessing = false);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document processed successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        // Server returned error
        setState(() => _isProcessing = false);
        _ocrResults = {
          'error': response.data['message'] ?? 'Could not process document',
        };

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message'] ?? 'OCR processing failed'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _isProcessing = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to process document: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }


  void _proceedToVerification() {
    setState(() => _currentStep = 2);
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeRegistration() async {
    // Validate required fields
    if (_idNumberController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _suburbController.text.isEmpty ||
        _wardController.text.isEmpty ||
        _selectedMunicipalityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // Parse date of birth from ID number
      final idParser = SaIdParser(_idNumberController.text);
      final dateOfBirth = idParser.getDateOfBirth();

      if (dateOfBirth == null) {
        throw Exception('Could not extract date of birth from ID number');
      }

      // Get gender from ID or use selected gender
      final gender = _selectedGender ?? idParser.getGender() ?? 'Male';

      // Create member via API
      final member = await ref.read(membersProvider.notifier).createMember(
        idNumber: _idNumberController.text.trim(),
        name: _firstNameController.text.trim(),
        surname: _lastNameController.text.trim(),
        dateOfBirth: dateOfBirth,
        gender: gender,
        phoneNumber: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        suburb: _suburbController.text.trim(),
        city: _suburbController.text.trim(),
        postalCode: '0000',
        ward: _wardController.text.trim(),
        municipalityId: _selectedMunicipalityId!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Member ${member.name} ${member.surname} registered successfully via OCR!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }
}