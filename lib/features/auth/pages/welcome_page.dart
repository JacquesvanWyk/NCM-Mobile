import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import 'login_page.dart';
import 'id_entry_page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  String? selectedRole;
  String? selectedMunicipality;
  String? selectedLanguage = 'English';
  bool agreedToTerms = false;

  final List<String> municipalities = [
    'City of Cape Town',
    'City of Johannesburg',
    'City of Tshwane',
    'eThekwini Municipality',
    'Nelson Mandela Bay',
    'Buffalo City',
    'Mangaung Metropolitan',
    'Msunduzi Municipality',
  ];

  final List<String> languages = [
    'English',
    'Afrikaans',
    'isiZulu',
    'isiXhosa',
    'Setswana',
    'Sesotho',
    'Sepedi',
    'Xitsonga',
    'SiSwati',
    'Tshivenda',
    'isiNdebele',
  ];

  void _handleContinue() {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your role')),
      );
      return;
    }

    if (selectedMunicipality == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your municipality')),
      );
      return;
    }

    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms of Service and Privacy Policy')),
      );
      return;
    }

    // Save selections and navigate to login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginPage(
          preSelectedRole: selectedRole,
          preSelectedMunicipality: selectedMunicipality,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(20),

              // Hero Image Section
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/municipal_workers.jpg'),
                    fit: BoxFit.cover,
                    onError: _ImageErrorWidget.new,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),

              const Gap(32),

              // Welcome Text
              const Text(
                'Welcome to NCM',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap(8),

              Text(
                'Choose your role to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap(32),

              // Role Selection
              Row(
                children: [
                  Expanded(
                    child: _RoleCard(
                      title: 'Field Worker',
                      isSelected: selectedRole == 'field_worker',
                      onTap: () => setState(() => selectedRole = 'field_worker'),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: _RoleCard(
                      title: 'Member',
                      isSelected: selectedRole == 'member',
                      onTap: () => setState(() => selectedRole = 'member'),
                    ),
                  ),
                ],
              ),

              const Gap(32),

              // Municipality Selection
              _DropdownSection(
                title: 'Select Municipality',
                value: selectedMunicipality,
                items: municipalities,
                onChanged: (value) => setState(() => selectedMunicipality = value),
              ),

              const Gap(24),

              // Language Selection
              _DropdownSection(
                title: 'Select Language',
                value: selectedLanguage,
                items: languages,
                onChanged: (value) => setState(() => selectedLanguage = value),
              ),

              const Gap(32),

              // Terms & Conditions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agreedToTerms,
                    onChanged: (value) => setState(() => agreedToTerms = value ?? false),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => agreedToTerms = !agreedToTerms),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Gap(32),

              // Continue Button
              ElevatedButton(
                onPressed: _handleContinue,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Gap(16),

              // New Member Registration Button
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const IdEntryPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text(
                  'Register as New Member',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(
                    color: AppTheme.primaryColor,
                    width: 2,
                  ),
                ),
              ),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _DropdownSection extends StatelessWidget {
  final String title;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownSection({
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        const Gap(8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: 'Select $title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _ImageErrorWidget extends StatelessWidget {
  final Object exception;
  final StackTrace? stackTrace;

  const _ImageErrorWidget(this.exception, this.stackTrace);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city,
              size: 48,
              color: AppTheme.primaryColor,
            ),
            Gap(8),
            Text(
              'Municipal Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}