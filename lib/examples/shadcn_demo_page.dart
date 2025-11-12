import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ShadcnDemoPage extends material.StatefulWidget {
  const ShadcnDemoPage({super.key});

  @override
  material.State<ShadcnDemoPage> createState() => _ShadcnDemoPageState();
}

class _ShadcnDemoPageState extends material.State<ShadcnDemoPage> {
  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(
        title: const material.Text('Shadcn Flutter Demo'),
        backgroundColor: material.Colors.blue,
        foregroundColor: material.Colors.white,
      ),
      body: material.SingleChildScrollView(
        padding: const material.EdgeInsets.all(16),
        child: material.Column(
          crossAxisAlignment: material.CrossAxisAlignment.start,
          children: [
            // Header
            const material.Text(
              'Shadcn Flutter Integration Test',
              style: material.TextStyle(
                fontSize: 24,
                fontWeight: material.FontWeight.bold,
              ),
            ),
            const material.SizedBox(height: 24),

            // Basic Button Test
            const material.Text(
              'Basic Button:',
              style: material.TextStyle(
                fontSize: 18,
                fontWeight: material.FontWeight.w600,
              ),
            ),
            const material.SizedBox(height: 12),

            const material.SizedBox(height: 32),

            // Success Message
            material.Container(
              width: double.infinity,
              padding: const material.EdgeInsets.all(16),
              decoration: material.BoxDecoration(
                color: material.Colors.green,
                borderRadius: material.BorderRadius.circular(8),
              ),
              child: material.Row(
                children: [
                  const material.Icon(
                    material.Icons.check_circle,
                    color: material.Colors.white,
                  ),
                  const material.SizedBox(width: 12),
                  material.Expanded(
                    child: material.Text(
                      '✅ Shadcn Flutter packages installed successfully!\n\n'
                      'Added packages:\n'
                      '• shadcn_flutter: ^0.0.44\n'
                      '• flutter_screenutil: ^5.9.0\n'
                      '• flutter_svg: ^2.0.7\n'
                      '• shimmer: ^3.0.0\n'
                      '• flutter_animate: ^4.2.0+1\n\n'
                      'Ready to enhance your NCM mobile app UI!',
                      style: const material.TextStyle(
                        color: material.Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const material.SizedBox(height: 24),

            // Instructions
            material.Container(
              width: double.infinity,
              padding: const material.EdgeInsets.all(16),
              decoration: material.BoxDecoration(
                color: material.Colors.lightBlue[50],
                border: material.Border.all(color: material.Colors.lightBlue[200]!),
                borderRadius: material.BorderRadius.circular(8),
              ),
              child: material.Column(
                crossAxisAlignment: material.CrossAxisAlignment.start,
                children: [
                  material.Text(
                    'Next Steps:',
                    style: material.TextStyle(
                      fontSize: 16,
                      fontWeight: material.FontWeight.w600,
                      color: material.Colors.lightBlue[800],
                    ),
                  ),
                  const material.SizedBox(height: 8),
                  material.Text(
                    '1. Start replacing Material components with Shadcn components\n'
                    '2. Use Shadcn components in forms (QuickRegistration, QuickAddVisit)\n'
                    '3. Enhance visit cards with Shadcn styling\n'
                    '4. Add animations with flutter_animate\n'
                    '5. Use shimmer for loading states',
                    style: material.TextStyle(
                      color: material.Colors.lightBlue[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}