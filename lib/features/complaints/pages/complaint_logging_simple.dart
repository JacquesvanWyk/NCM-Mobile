import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';

class ComplaintLoggingPage extends ConsumerStatefulWidget {
  final String? membershipNumber;

  const ComplaintLoggingPage({super.key, this.membershipNumber});

  @override
  ConsumerState<ComplaintLoggingPage> createState() => _ComplaintLoggingPageState();
}

class _ComplaintLoggingPageState extends ConsumerState<ComplaintLoggingPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isSubmitting = false;

  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedCategory = 'Service Delivery';
  bool _isAnonymous = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Service Delivery',
      'icon': Icons.build,
      'color': Colors.blue,
      'description': 'Issues with municipal services'
    },
    {
      'name': 'Infrastructure',
      'icon': Icons.engineering,
      'color': Colors.orange,
      'description': 'Roads, water, electricity problems'
    },
    {
      'name': 'Waste Management',
      'icon': Icons.delete,
      'color': Colors.green,
      'description': 'Garbage collection issues'
    },
    {
      'name': 'Public Safety',
      'icon': Icons.security,
      'color': Colors.red,
      'description': 'Safety and security concerns'
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Complaint'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
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
                _buildStepIndicator(0, 'Category', _currentStep >= 0),
                Expanded(child: Divider(color: _currentStep >= 1 ? AppTheme.primaryColor : Colors.grey)),
                _buildStepIndicator(1, 'Details', _currentStep >= 1),
                Expanded(child: Divider(color: _currentStep >= 2 ? AppTheme.primaryColor : Colors.grey)),
                _buildStepIndicator(2, 'Contact', _currentStep >= 2),
                Expanded(child: Divider(color: _currentStep >= 3 ? AppTheme.primaryColor : Colors.grey)),
                _buildStepIndicator(3, 'Submit', _currentStep >= 3),
              ],
            ),
          ),

          // Page Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryStep(),
                _buildDetailsStep(),
                _buildContactStep(),
                _buildSubmitStep(),
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
          radius: 12,
          backgroundColor: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
          child: Text(
            '${step + 1}',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isActive ? AppTheme.primaryColor : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Complaint Category',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Choose the category that best describes your complaint.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),

          ..._categories.map((category) {
            final isSelected = _selectedCategory == category['name'];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = category['name'];
                  });
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
                        ? AppTheme.primaryColor.withOpacity(0.05)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: category['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          category['icon'],
                          color: category['color'],
                          size: 24,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              category['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: AppTheme.primaryColor,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const Gap(24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Next: Add Details',
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

  Widget _buildDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complaint Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Provide detailed information about your complaint.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),

          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Complaint Title *',
              hintText: 'Brief summary of the issue',
              border: OutlineInputBorder(),
            ),
          ),

          const Gap(16),

          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Detailed Description *',
              hintText: 'Describe the issue in detail...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
          ),

          const Gap(24),

          // Photo Attachment (Demo)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attach Photos (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Add photos to help illustrate the issue.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const Gap(12),
                  OutlinedButton.icon(
                    onPressed: _showCameraInfo,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo (Demo)'),
                  ),
                ],
              ),
            ),
          ),

          const Gap(24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  child: const Text('Back'),
                ),
              ),
              const Gap(16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Next: Contact Info'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Provide your contact details for follow-up.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),

          SwitchListTile(
            title: const Text('Submit Anonymously'),
            subtitle: const Text('Hide your contact information'),
            value: _isAnonymous,
            onChanged: (value) {
              setState(() {
                _isAnonymous = value;
              });
            },
          ),

          if (!_isAnonymous) ...[
            const Gap(16),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                border: OutlineInputBorder(),
              ),
            ),

            const Gap(16),

            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number *',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],

          const Gap(24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  child: const Text('Back'),
                ),
              ),
              const Gap(16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Review & Submit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review & Submit',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(8),
          Text(
            'Please review your complaint before submitting.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReviewItem('Category', _selectedCategory),
                  const Gap(12),
                  _buildReviewItem('Title', _titleController.text.isEmpty ? 'Not provided' : _titleController.text),
                  const Gap(12),
                  _buildReviewItem('Description', _descriptionController.text.isEmpty ? 'Not provided' : _descriptionController.text),
                  const Gap(12),
                  _buildReviewItem('Submission Type', _isAnonymous ? 'Anonymous' : 'With Contact Info'),
                  if (!_isAnonymous && _firstNameController.text.isNotEmpty) ...[
                    const Gap(12),
                    _buildReviewItem('Contact', '${_firstNameController.text} - ${_phoneController.text}'),
                  ],
                ],
              ),
            ),
          ),

          const Gap(24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitComplaint,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Submit Complaint',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const Gap(16),

          OutlinedButton(
            onPressed: _previousStep,
            child: const Text('Back to Edit'),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitComplaint() async {
    setState(() => _isSubmitting = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Complaint submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting complaint: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showCameraInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera functionality requires additional dependencies'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}