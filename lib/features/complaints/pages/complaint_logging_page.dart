import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';

class ComplaintLoggingPage extends ConsumerStatefulWidget {
  final String? membershipNumber;

  const ComplaintLoggingPage({
    super.key,
    this.membershipNumber,
  });

  @override
  ConsumerState<ComplaintLoggingPage> createState() => _ComplaintLoggingPageState();
}

class _ComplaintLoggingPageState extends ConsumerState<ComplaintLoggingPage> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  // Form controllers
  final _complainantNameController = TextEditingController();
  final _complainantPhoneController = TextEditingController();
  final _complainantAddressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  // Form state
  int _currentStep = 0;
  String _selectedCategory = 'Water Services';
  String _selectedPriority = 'Medium';
  String _selectedImpact = 'Individual';
  bool _isAnonymous = false;
  bool _allowCallback = true;
  bool _isSubmitting = false;

  List<File> _photos = [];
  List<File> _documents = [];

  final List<Map<String, dynamic>> _categories = [
    {'value': 'Water Services', 'icon': Icons.water_drop, 'color': Colors.blue},
    {'value': 'Electricity', 'icon': Icons.electrical_services, 'color': Colors.orange},
    {'value': 'Roads & Infrastructure', 'icon': Icons.construction, 'color': Colors.grey},
    {'value': 'Waste Management', 'icon': Icons.delete, 'color': Colors.green},
    {'value': 'Public Safety', 'icon': Icons.security, 'color': Colors.red},
    {'value': 'Health Services', 'icon': Icons.local_hospital, 'color': Colors.pink},
    {'value': 'Housing', 'icon': Icons.home, 'color': Colors.brown},
    {'value': 'Education', 'icon': Icons.school, 'color': Colors.indigo},
    {'value': 'Social Services', 'icon': Icons.people, 'color': Colors.purple},
    {'value': 'Other', 'icon': Icons.help_outline, 'color': Colors.teal},
  ];

  final List<String> _priorities = ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _impacts = ['Individual', 'Household', 'Community', 'Ward'];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _complainantNameController.dispose();
    _complainantPhoneController.dispose();
    _complainantAddressController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    // TODO: Implement GPS location capture
    _locationController.text = 'Current location (GPS coordinates will be captured)';
  }

  Future<void> _takePicture() async {
    final permission = await Permission.camera.request();
    if (!permission.isGranted) {
      _showSnackBar('Camera permission required', Colors.red);
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _photos.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _pickDocument() async {
    // TODO: Implement document picker
    _showSnackBar('Document picker coming soon', Colors.blue);
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // TODO: Submit to actual API
      // Create complaint request
      final complaintData = {
        'category': _selectedCategory,
        'priority': _selectedPriority,
        'impact': _selectedImpact,
        'description': _descriptionController.text.trim(),
        'location': _locationController.text.trim(),
        'is_anonymous': _isAnonymous,
        'allow_callback': _allowCallback,
        'complainant_name': _isAnonymous ? null : _complainantNameController.text.trim(),
        'complainant_phone': _isAnonymous ? null : _complainantPhoneController.text.trim(),
        'complainant_address': _isAnonymous ? null : _complainantAddressController.text.trim(),
        'membership_number': widget.membershipNumber,
        'photos': _photos.map((photo) => photo.path).toList(),
        'documents': _documents.map((doc) => doc.path).toList(),
      };

      // Mock API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isSubmitting = false);

      if (mounted) {
        // Show success dialog
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            title: const Text('Complaint Logged Successfully!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Your complaint has been recorded and will be forwarded to the appropriate department.',
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Reference Number',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'CMP${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true); // Return to previous screen
                },
                child: const Text('Done'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      setState(() => _isSubmitting = false);
      _showSnackBar('Failed to submit complaint: $error', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? AppTheme.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Step content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryStep(),
                _buildDetailsStep(),
                _buildContactStep(),
                _buildReviewStep(),
              ],
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      child: const Text('Previous'),
                    ),
                  ),
                if (_currentStep > 0) const Gap(16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : (_currentStep < 3 ? _nextStep : _submitComplaint),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(_currentStep < 3 ? 'Next' : 'Submit Complaint'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Step 1: Issue Category',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Select the category that best describes the issue',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category['value'];

                return Card(
                  child: InkWell(
                    onTap: () {
                      setState(() => _selectedCategory = category['value']);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: AppTheme.primaryColor, width: 2)
                            : null,
                        color: isSelected
                            ? AppTheme.primaryColor.withOpacity(0.1)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            size: 32,
                            color: isSelected
                                ? AppTheme.primaryColor
                                : category['color'],
                          ),
                          const Gap(8),
                          Text(
                            category['value'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Step 2: Issue Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const Gap(8),
            Text(
              'Provide detailed information about the issue',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const Gap(24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedPriority,
                            decoration: const InputDecoration(
                              labelText: 'Priority Level',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.priority_high),
                            ),
                            items: _priorities.map((priority) {
                              return DropdownMenuItem(
                                value: priority,
                                child: Text(priority),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedPriority = value!);
                            },
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedImpact,
                            decoration: const InputDecoration(
                              labelText: 'Impact Level',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.groups),
                            ),
                            items: _impacts.map((impact) {
                              return DropdownMenuItem(
                                value: impact,
                                child: Text(impact),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedImpact = value!);
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Detailed Description',
                        hintText: 'Describe the issue in detail...',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please describe the issue';
                        }
                        if (value.trim().length < 20) {
                          return 'Please provide more details (minimum 20 characters)';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        hintText: 'Where is this issue located?',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please specify the location';
                        }
                        return null;
                      },
                    ),
                    const Gap(24),
                    // Evidence section
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _takePicture,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Take Photo'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _pickDocument,
                            icon: const Icon(Icons.attach_file),
                            label: const Text('Add Document'),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    if (_photos.isNotEmpty) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Photos:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _photos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 80,
                              margin: const EdgeInsets.only(right: 8),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _photos[index],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => _removePhoto(index),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Step 3: Contact Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Provide contact details for follow-up (optional)',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Submit Anonymously'),
                    subtitle: const Text('No contact information will be recorded'),
                    value: _isAnonymous,
                    onChanged: (value) {
                      setState(() => _isAnonymous = value);
                    },
                  ),
                  const Gap(16),
                  if (!_isAnonymous) ...[
                    TextFormField(
                      controller: _complainantNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: _isAnonymous ? null : (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _complainantPhoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: _isAnonymous ? null : (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _complainantAddressController,
                      decoration: const InputDecoration(
                        labelText: 'Address (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const Gap(16),
                    SwitchListTile(
                      title: const Text('Allow Callback'),
                      subtitle: const Text('Municipality may contact you for updates'),
                      value: _allowCallback,
                      onChanged: (value) {
                        setState(() => _allowCallback = value);
                      },
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

  Widget _buildReviewStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Step 4: Review & Submit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Review your complaint details before submitting',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ReviewItem(
                        label: 'Category',
                        value: _selectedCategory,
                        icon: Icons.category,
                      ),
                      const Gap(16),
                      _ReviewItem(
                        label: 'Priority',
                        value: _selectedPriority,
                        icon: Icons.priority_high,
                      ),
                      const Gap(16),
                      _ReviewItem(
                        label: 'Impact',
                        value: _selectedImpact,
                        icon: Icons.groups,
                      ),
                      const Gap(16),
                      _ReviewItem(
                        label: 'Description',
                        value: _descriptionController.text,
                        icon: Icons.description,
                        maxLines: 3,
                      ),
                      const Gap(16),
                      _ReviewItem(
                        label: 'Location',
                        value: _locationController.text,
                        icon: Icons.location_on,
                      ),
                      if (!_isAnonymous) ...[
                        const Gap(16),
                        _ReviewItem(
                          label: 'Complainant',
                          value: _complainantNameController.text,
                          icon: Icons.person,
                        ),
                        const Gap(16),
                        _ReviewItem(
                          label: 'Phone',
                          value: _complainantPhoneController.text,
                          icon: Icons.phone,
                        ),
                      ],
                      const Gap(16),
                      _ReviewItem(
                        label: 'Photos',
                        value: '${_photos.length} photo${_photos.length == 1 ? '' : 's'} attached',
                        icon: Icons.photo,
                      ),
                      const Gap(16),
                      _ReviewItem(
                        label: 'Contact Preference',
                        value: _isAnonymous
                            ? 'Anonymous submission'
                            : _allowCallback
                                ? 'Allow callback'
                                : 'No callback',
                        icon: Icons.contact_phone,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final int? maxLines;

  const _ReviewItem({
    required this.label,
    required this.value,
    required this.icon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.textSecondary,
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
                maxLines: maxLines,
                overflow: maxLines != null ? TextOverflow.ellipsis : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}