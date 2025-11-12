import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Services'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[700], size: 24),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'In case of life-threatening emergency, call 112 immediately',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Emergency Contacts
            const Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),

            const Gap(16),

            _buildEmergencyCard(
              context,
              'Police Emergency',
              '10111',
              Icons.local_police,
              Colors.blue[700]!,
              'Report crimes, accidents, or request police assistance',
            ),

            const Gap(12),

            _buildEmergencyCard(
              context,
              'Fire Department',
              '10177',
              Icons.local_fire_department,
              Colors.red[700]!,
              'Fire emergencies, rescue operations',
            ),

            const Gap(12),

            _buildEmergencyCard(
              context,
              'Medical Emergency',
              '10177',
              Icons.local_hospital,
              Colors.green[700]!,
              'Ambulance services and medical emergencies',
            ),

            const Gap(12),

            _buildEmergencyCard(
              context,
              'Municipal Emergency',
              '0800 428 837',
              Icons.location_city,
              AppTheme.primaryColor,
              'Water leaks, power outages, municipal issues',
            ),

            const Gap(32),

            // Emergency Services
            const Text(
              'Emergency Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),

            const Gap(16),

            _buildServiceButton(
              context,
              'Report Emergency',
              Icons.emergency,
              Colors.red[700]!,
              () => _showEmergencyReport(context),
            ),

            const Gap(12),

            _buildServiceButton(
              context,
              'Request Emergency Service',
              Icons.medical_services,
              Colors.orange[700]!,
              () => _showEmergencyRequest(context),
            ),

            const Gap(12),

            _buildServiceButton(
              context,
              'Emergency Alerts',
              Icons.notifications_active,
              Colors.purple[700]!,
              () => _showEmergencyAlerts(context),
            ),

            const Gap(32),

            // Safety Tips
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue[700], size: 20),
                      const Gap(8),
                      Text(
                        'Safety Tips',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  const Text(
                    '• Stay calm and speak clearly\n'
                    '• Provide your exact location\n'
                    '• Describe the emergency clearly\n'
                    '• Follow dispatcher instructions\n'
                    '• Stay on the line until told otherwise',
                    style: TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(
    BuildContext context,
    String title,
    String number,
    IconData icon,
    Color color,
    String description,
  ) {
    return Card(
      child: InkWell(
        onTap: () => _makePhoneCall(context, number),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      number,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.phone, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Gap(16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _makePhoneCall(BuildContext context, String phoneNumber) {
    // Demo mode: Copy number to clipboard and show dialog
    Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emergency number $phoneNumber copied to clipboard'),
        backgroundColor: Colors.red[700],
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showEmergencyReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Emergency'),
        content: const Text(
          'This would open an emergency reporting form where users can:\n\n'
          '• Select emergency type\n'
          '• Add location details\n'
          '• Upload photos\n'
          '• Submit to emergency services\n\n'
          'Implementation requires backend integration.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Emergency Service'),
        content: const Text(
          'This would open a service request form for:\n\n'
          '• Emergency repairs\n'
          '• Urgent municipal services\n'
          '• Priority response requests\n'
          '• Contact details and location\n\n'
          'Implementation requires API integration.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyAlerts(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency Alerts'),
        content: const Text(
          'This would show:\n\n'
          '• Active emergency alerts in your area\n'
          '• Weather warnings\n'
          '• Municipal emergency notices\n'
          '• Safety advisories\n'
          '• Evacuation notices\n\n'
          'Requires push notification service.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}