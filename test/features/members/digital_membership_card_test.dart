import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:ncm_mobile_app/core/services/api_service.dart';
import 'package:ncm_mobile_app/data/models/user_model.dart';
import 'package:ncm_mobile_app/features/members/pages/digital_membership_card_page.dart';
import 'package:ncm_mobile_app/providers/auth_provider.dart';
import 'package:ncm_mobile_app/providers/visits_provider.dart';

import 'digital_membership_card_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Digital Membership Card Tests', () {
    late MockApiService mockApiService;
    late UserModel mockUser;
    late MemberModel mockMember;

    setUp(() {
      mockApiService = MockApiService();

      mockMember = MemberModel(
        id: 1,
        userId: 1,
        municipalityId: 1,
        membershipNumber: 'NCM001',
        idNumber: '9001010001080',
        firstName: 'Sophia',
        lastName: 'Carter',
        dateOfBirth: DateTime.parse("1990-01-01"),
        gender: 'Female',
        phoneNumber: '+27123456789',
        address: '123 Test Street',
        suburb: 'Test Suburb',
        city: 'Cape Town',
        postalCode: '8000',
        ward: '12',
        isActive: true,
        createdAt: null,
        updatedAt: null,
      );

      mockUser = UserModel(
        id: 1,
        name: 'Sophia Carter',
        email: 'sophia@example.com',
        userType: 'member',
        member: mockMember,
        leader: null,
        municipalities: null,
      );
    });

    testWidgets('should display member information when user has member data', (WidgetTester tester) async {
      // Arrange
      when(mockApiService.generateMemberQrCode(any)).thenAnswer(
        (_) async => QrCodeResponse(
          qrData: 'test-qr-data',
          qrImage: 'data:image/png;base64,test-image-data',
          expiresAt: DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
        ),
      );

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(mockUser)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Sophia Carter'), findsOneWidget);
      expect(find.text('NCM001'), findsOneWidget);
      expect(find.text('Cape Town'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('ACTIVE MEMBER'), findsOneWidget);
    });

    testWidgets('should show member information not found when user has no member data', (WidgetTester tester) async {
      // Arrange
      final userWithoutMember = mockUser.copyWith(member: null);

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(userWithoutMember)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Member information not found'), findsOneWidget);
    });

    testWidgets('should generate and display QR code when member data is available', (WidgetTester tester) async {
      // Arrange
      final qrResponse = QrCodeResponse(
        qrData: 'test-qr-data-encoded',
        qrImage: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==',
        expiresAt: DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
      );

      when(mockApiService.generateMemberQrCode(1)).thenAnswer((_) async => qrResponse);

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(mockUser)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      // Wait for initial load and QR generation
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Digital Membership QR Code'), findsOneWidget);
      expect(find.text('Show this QR code to field workers for visit verification'), findsOneWidget);
      expect(find.text('Refresh QR Code'), findsOneWidget);

      // Verify API was called
      verify(mockApiService.generateMemberQrCode(1)).called(1);
    });

    testWidgets('should show loading state while generating QR code', (WidgetTester tester) async {
      // Arrange - Add delay to API response
      when(mockApiService.generateMemberQrCode(1)).thenAnswer(
        (_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return QrCodeResponse(
            qrData: 'test-qr-data',
            qrImage: 'data:image/png;base64,test-data',
            expiresAt: DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
          );
        },
      );

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(mockUser)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      // Pump once to build widget
      await tester.pump();

      // Assert loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle QR generation error gracefully', (WidgetTester tester) async {
      // Arrange
      when(mockApiService.generateMemberQrCode(1)).thenThrow(
        Exception('Network error'),
      );

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(mockUser)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Failed to generate QR code: Exception: Network error'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should refresh QR code when refresh button is tapped', (WidgetTester tester) async {
      // Arrange
      when(mockApiService.generateMemberQrCode(1)).thenAnswer(
        (_) async => QrCodeResponse(
          qrData: 'refreshed-qr-data',
          qrImage: 'data:image/png;base64,refreshed-data',
          expiresAt: DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
        ),
      );

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(mockUser)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap refresh button
      await tester.tap(find.text('Refresh QR Code'));
      await tester.pumpAndSettle();

      // Assert
      verify(mockApiService.generateMemberQrCode(1)).called(2); // Initial + refresh
    });

    testWidgets('should display usage instructions', (WidgetTester tester) async {
      // Arrange
      when(mockApiService.generateMemberQrCode(1)).thenAnswer(
        (_) async => QrCodeResponse(
          qrData: 'test-data',
          qrImage: 'data:image/png;base64,test',
          expiresAt: DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
        ),
      );

      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()..state = AsyncValue.data(mockUser)),
            apiServiceProvider.overrideWithValue(mockApiService),
          ],
          child: const MaterialApp(
            home: DigitalMembershipCardPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('How to use'), findsOneWidget);
      expect(find.text('• Show this QR code to field workers for visit verification'), findsOneWidget);
      expect(find.text('• QR codes expire after 24 hours for security'), findsOneWidget);
      expect(find.text('• Refresh the code if it has expired'), findsOneWidget);
      expect(find.text('• Keep your phone screen bright for easier scanning'), findsOneWidget);
    });
  });
}