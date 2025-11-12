import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/network/api_service_factory.dart';
import '../../../data/models/registration_models.dart';
import 'registration_form_page.dart';
import 'login_page.dart';

class IdEntryPage extends StatefulWidget {
  const IdEntryPage({super.key});

  @override
  State<IdEntryPage> createState() => _IdEntryPageState();
}

class _IdEntryPageState extends State<IdEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  String? _validateIdNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your ID number';
    }

    if (value.length != 13) {
      return 'ID number must be 13 digits';
    }

    if (!RegExp(r'^[0-9]{13}$').hasMatch(value)) {
      return 'ID number must contain only numbers';
    }

    return null;
  }

  Future<void> _handleNext() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiService = ApiServiceFactory.instance;
      final idNumber = _idNumberController.text.trim();

      final response = await apiService.checkIdNumber(
        CheckIdNumberRequest(idNumber: idNumber),
      );

      if (!mounted) return;

      if (response.error != null) {
        _showError(response.error!);
        return;
      }

      if (!response.exists) {
        // New member - navigate to full registration form
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationFormPage(
              idNumber: idNumber,
              isNewMember: true,
            ),
          ),
        );
      } else if (response.hasAccount == true) {
        // Member already has account - redirect to login
        _showAccountExistsDialog();
      } else {
        // Existing member without account - pre-fill registration form
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationFormPage(
              idNumber: idNumber,
              isNewMember: false,
              existingMember: response.member,
            ),
          ),
        );
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

  void _showAccountExistsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Already Exists'),
        content: const Text(
          'This member is already registered. Please login instead.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Registration'),
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
                const Gap(24),

                // Logo or Icon
                Icon(
                  Icons.person_add,
                  size: 80,
                  color: AppTheme.primaryColor,
                ),
                const Gap(32),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                        size: 24,
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Enter Your ID Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Enter your South African ID number to check if you\'re already registered or to start a new registration.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(32),

                // ID Number Input
                TextFormField(
                  controller: _idNumberController,
                  decoration: InputDecoration(
                    labelText: 'ID Number',
                    hintText: 'Enter your 13-digit ID number',
                    prefixIcon: const Icon(Icons.badge),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                  validator: _validateIdNumber,
                  enabled: !_isLoading,
                ),

                const Gap(32),

                // Next Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleNext,
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
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),

                const Gap(24),

                // Already have account link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text('Already have an account? Login'),
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
