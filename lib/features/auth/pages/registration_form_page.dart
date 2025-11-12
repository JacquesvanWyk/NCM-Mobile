import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/network/api_service_factory.dart';
import '../../../data/models/registration_models.dart';
import 'otp_verification_page.dart';

class RegistrationFormPage extends StatefulWidget {
  final String idNumber;
  final bool isNewMember;
  final MemberData? existingMember;

  const RegistrationFormPage({
    super.key,
    required this.idNumber,
    required this.isNewMember,
    this.existingMember,
  });

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _wardController = TextEditingController();
  final _addressController = TextEditingController();
  final _townController = TextEditingController();

  String _verificationMethod = 'email';
  bool _isLoading = false;
  int? _municipalityId = 1; // Default - should be fetched from API

  @override
  void initState() {
    super.initState();
    if (widget.existingMember != null) {
      _nameController.text = widget.existingMember!.name;
      _surnameController.text = widget.existingMember!.surname;
      _emailController.text = widget.existingMember!.email ?? '';
      _phoneController.text = widget.existingMember!.telNumber ?? '';
      _wardController.text = widget.existingMember!.ward ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _wardController.dispose();
    _addressController.dispose();
    _townController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateContact() {
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (email.isEmpty && phone.isEmpty) {
      return 'Please provide either an email address or phone number';
    }

    if (_verificationMethod == 'email' && email.isEmpty) {
      return 'Email is required for email verification';
    }

    if (_verificationMethod == 'sms' && phone.isEmpty) {
      return 'Phone number is required for SMS verification';
    }

    return null;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final contactError = _validateContact();
    if (contactError != null) {
      _showError(contactError);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiService = ApiServiceFactory.instance;

      final request = RegisterMemberRequest(
        idNumber: widget.idNumber,
        name: _nameController.text.trim(),
        surname: _surnameController.text.trim(),
        email: _emailController.text.trim().isNotEmpty
            ? _emailController.text.trim()
            : null,
        telNumber: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
        ward: _wardController.text.trim().isNotEmpty
            ? _wardController.text.trim()
            : null,
        address: _addressController.text.trim().isNotEmpty
            ? _addressController.text.trim()
            : null,
        town: _townController.text.trim().isNotEmpty
            ? _townController.text.trim()
            : null,
        municipalityId: _municipalityId!,
        verificationMethod: _verificationMethod,
      );

      final response = await apiService.registerMember(request);

      if (!mounted) return;

      if (response.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationPage(
              idNumber: widget.idNumber,
              verificationMethod: _verificationMethod,
              sentTo: response.sentTo ?? _verificationMethod,
              memberId: response.memberId,
            ),
          ),
        );
      } else {
        _showError(response.message);
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewMember
            ? 'New Member Registration'
            : 'Complete Registration'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!widget.isNewMember) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            'Welcome back! We found your membership record. Please review and update your details.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                ],

                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name *',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: _validateName,
                  enabled: !_isLoading && widget.isNewMember,
                  readOnly: !widget.isNewMember,
                ),

                const Gap(16),

                // Surname
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                    labelText: 'Surname *',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: _validateName,
                  enabled: !_isLoading && widget.isNewMember,
                  readOnly: !widget.isNewMember,
                ),

                const Gap(16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'your.email@example.com',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !_isLoading,
                ),

                const Gap(16),

                // Phone Number
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '0821234567',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  keyboardType: TextInputType.phone,
                  enabled: !_isLoading,
                ),

                const Gap(24),

                // Verification Method Selection
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Verification Method',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(12),
                      const Text(
                        'Choose how you want to receive your verification code:',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Gap(12),
                      RadioListTile<String>(
                        title: const Text('Email (Free)'),
                        subtitle: Text(_emailController.text.isNotEmpty
                            ? _emailController.text
                            : 'Please enter email above'),
                        value: 'email',
                        groupValue: _verificationMethod,
                        onChanged: _emailController.text.isNotEmpty && !_isLoading
                            ? (value) => setState(() => _verificationMethod = value!)
                            : null,
                        activeColor: AppTheme.primaryColor,
                      ),
                      RadioListTile<String>(
                        title: const Text('SMS (Uses credits)'),
                        subtitle: Text(_phoneController.text.isNotEmpty
                            ? _phoneController.text
                            : 'Please enter phone number above'),
                        value: 'sms',
                        groupValue: _verificationMethod,
                        onChanged: _phoneController.text.isNotEmpty && !_isLoading
                            ? (value) => setState(() => _verificationMethod = value!)
                            : null,
                        activeColor: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                ),

                const Gap(24),

                // Optional fields
                ExpansionTile(
                  title: const Text('Additional Information (Optional)'),
                  children: [
                    const Gap(16),
                    TextFormField(
                      controller: _wardController,
                      decoration: InputDecoration(
                        labelText: 'Ward',
                        prefixIcon: const Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      enabled: !_isLoading,
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: const Icon(Icons.home),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      maxLines: 2,
                      enabled: !_isLoading,
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _townController,
                      decoration: InputDecoration(
                        labelText: 'Town',
                        prefixIcon: const Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      enabled: !_isLoading,
                    ),
                  ],
                ),

                const Gap(32),

                // Submit Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Send Verification Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
