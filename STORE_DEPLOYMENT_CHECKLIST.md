# NCM Mobile App - Store Deployment Checklist

## ✅ Current Status

### What's Ready:
- ✅ Flutter environment configured (Flutter 3.35.4)
- ✅ FCM (Firebase Cloud Messaging) fully integrated
- ✅ App icons configured for iOS and Android
- ✅ Firebase project connected (google-services.json present)
- ✅ API integration with Laravel backend complete
- ✅ Version set to 1.0.0+1

### What Needs Attention:
- ⚠️ **App signing** - Currently using debug keys
- ⚠️ **Store assets** - Need screenshots, store descriptions
- ⚠️ **Privacy policy & terms** - Required by stores
- ⚠️ **Testing** - Some integration test errors to fix
- ⚠️ **Production API** - Verify endpoint configuration

---

## 🍎 iOS App Store Deployment

### Prerequisites
1. **Apple Developer Account** ($99/year)
   - Enroll at: https://developer.apple.com/programs/

2. **App Store Connect Setup**
   - Create app record at: https://appstoreconnect.apple.com
   - Bundle ID: `com.ncm.mobile` (or update in pubspec.yaml line 99)

### Code Signing
```bash
cd ios
# Open Xcode project
open Runner.xcworkspace

# In Xcode:
# 1. Select Runner target
# 2. Signing & Capabilities tab
# 3. Select your Team
# 4. Choose "Automatically manage signing"
```

### Build & Submit
```bash
# 1. Clean build
flutter clean
flutter pub get

# 2. Build release
flutter build ios --release

# 3. Archive in Xcode
# - Open ios/Runner.xcworkspace
# - Product > Archive
# - Upload to App Store Connect

# OR use command line:
flutter build ipa
```

### Required Store Assets
- **App Icon**: 1024x1024 PNG (Already have: ios/Runner/Assets.xcassets/AppIcon.appiconset/1024.png)
- **Screenshots**:
  - 6.7" (iPhone 15 Pro Max): 1290 x 2796
  - 6.5" (iPhone 11 Pro Max): 1242 x 2688
  - 5.5" (iPhone 8 Plus): 1242 x 2208
  - 12.9" iPad Pro: 2048 x 2732
- **Preview Videos** (Optional but recommended)

### App Store Information
- **App Name**: NCM (max 30 characters)
- **Subtitle**: Municipal Management App
- **Category**: Productivity / Government
- **Keywords**: municipal, government, civic, south africa
- **Support URL**: https://ncm.co.za/support
- **Marketing URL**: https://ncm.co.za
- **Privacy Policy URL**: https://ncm.co.za/privacy-policy

### Privacy Declarations (Required)
Based on app analysis, declare usage of:
- ✅ Location (if used for field visits)
- ✅ Camera (Identity document scanning - line 29-34 Info.plist)
- ✅ Photo Library (ID document selection)
- ✅ Push Notifications
- ✅ Device ID (for FCM tokens)

---

## 🤖 Android Play Store Deployment

### Prerequisites
1. **Google Play Console Account** ($25 one-time fee)
   - Register at: https://play.google.com/console

2. **Create app** in Play Console
   - Package name: `design.motionstack.ncm.ncm_mobile_app`

### App Signing Setup

#### Option 1: Play App Signing (Recommended)
Google manages your signing key - easiest option.

#### Option 2: Manual Signing
```bash
# 1. Create keystore
keytool -genkey -v -keystore ~/ncm-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias ncm-key

# 2. Create key.properties file
# android/key.properties:
storePassword=<your_password>
keyPassword=<your_password>
keyAlias=ncm-key
storeFile=/Users/jacquesvanwyk/ncm-release-key.jks

# 3. Update android/app/build.gradle.kts
# Add before android block:
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

# In android block, update buildTypes:
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
    }
}
```

### Build & Submit
```bash
# 1. Clean build
flutter clean
flutter pub get

# 2. Build release AAB (Android App Bundle)
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab

# 3. Upload to Play Console
# - Go to Play Console
# - Select your app
# - Production > Create new release
# - Upload app-release.aab
```

### Required Store Assets
- **App Icon**: 512x512 PNG (Already have: mipmap icons)
- **Feature Graphic**: 1024 x 500 PNG
- **Screenshots**:
  - Phone: At least 2 (max 8) - 16:9 or 9:16 aspect ratio
  - 7" Tablet: At least 1 (optional)
  - 10" Tablet: At least 1 (optional)
- **Promo Video**: YouTube URL (optional)

### Play Store Listing
- **App Name**: NCM Municipal Management
- **Short Description**: Civic engagement and municipal service management (max 80 chars)
- **Full Description**: (max 4000 chars)
```
NCM Municipal Management is the official mobile application for Northern Cape municipalities,
enabling citizens to:

✓ Report service issues and complaints
✓ Track complaint resolution status
✓ Engage with community leaders
✓ Receive important municipal announcements
✓ Access municipal services on the go

Features:
• Real-time push notifications for updates
• Secure authentication
• Multi-municipality support
• Offline functionality
• User-friendly interface

Download today and stay connected with your municipality!
```

- **Category**: Government
- **Content Rating**: Everyone
- **Target Audience**: 18+

### Privacy & Compliance
Required declarations based on code analysis:
- ✅ Location permissions (if used)
- ✅ Camera permissions
- ✅ Storage permissions
- ✅ Internet access
- ✅ Push notifications
- ✅ Collects: Device identifiers, User credentials

**Data Safety Section** (New requirement):
- Declare what data is collected
- How it's used (service functionality, authentication)
- If it's shared with third parties (API server)
- Data encryption (in transit via HTTPS)
- User can request deletion

---

## 🔐 Pre-Submission Checklist

### Code Quality
- [ ] Run `flutter analyze` and fix critical issues
- [ ] Remove all `print()` statements from production code
- [ ] Run `flutter test` - ensure tests pass
- [ ] Test on multiple device sizes
- [ ] Test on both iOS and Android

### Configuration
- [x] App icons configured (both platforms)
- [ ] Update version in `pubspec.yaml` if needed
- [ ] Set correct API endpoint for production
  - Check: `lib/config/` or `.env` file
  - Production: `https://api.ncm.co.za/api`
- [ ] Firebase production project configured
- [ ] Remove any test/debug code
- [ ] Check `android:debuggable="false"` in release

### Backend Integration
- [x] FCM service configured in backend ✅
- [x] Firebase credentials on server ✅
- [ ] Test notification sending end-to-end with real device
- [ ] Verify all API endpoints are production-ready
- [ ] Test login/authentication flow
- [ ] Test complaint submission
- [ ] Test push notifications

### Legal & Privacy
- [ ] Privacy Policy page created (required)
- [ ] Terms of Service page created
- [ ] Add links in app settings
- [ ] Update URLs in store listings
- [ ] Content rating completed

### Testing with Real Devices
```bash
# iOS
flutter run --release -d <ios_device_id>

# Android
flutter run --release -d <android_device_id>

# Test checklist:
- [ ] Login with real account
- [ ] Receive push notification
- [ ] Submit complaint
- [ ] View announcements
- [ ] Camera/photo permissions work
- [ ] App doesn't crash on rotation
- [ ] Offline mode works
- [ ] Log out and log back in
```

---

## 📸 Creating Screenshots

### Quick Method
1. Run app on simulators:
```bash
# iOS
open -a Simulator
flutter run

# Android
flutter run
```

2. Take screenshots:
   - iOS: Cmd + S in Simulator
   - Android: Screenshot button in Android Studio

3. Use online tools to add device frames:
   - https://mockuphone.com
   - https://screenshots.pro
   - https://www.screely.com

### What to Screenshot
1. Login/Welcome screen
2. Dashboard (main screen)
3. Announcements list
4. Complaint submission form
5. User profile
6. Notifications

---

## 🚀 First Submission Timeline

### iOS App Store
- **Review time**: 24-48 hours typically
- **Resubmission**: If rejected, fix and resubmit
- **Phased Release**: Optional - roll out to 1%, 10%, 25%, 50%, 100%

### Android Play Store
- **Review time**: Few hours to 7 days
- **Internal testing**: Test with up to 100 testers first
- **Closed testing**: Invite-only beta testing
- **Open testing**: Public beta
- **Production**: Full release

---

## 🔄 Update Process

After initial approval, for updates:

```bash
# 1. Update version in pubspec.yaml
version: 1.0.1+2  # version+build_number

# 2. Build new release
flutter build ios --release
flutter build appbundle --release

# 3. Submit to stores
# - What's new description
# - Upload new build
# - Submit for review
```

---

## ⚡ Quick Start Commands

```bash
# Check environment
flutter doctor

# Build iOS
flutter build ios --release

# Build Android
flutter build appbundle --release

# Test release build locally
flutter run --release

# Generate app signing
keytool -genkey -v -keystore ~/ncm-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias ncm-key
```

---

## 📞 Support Resources

- **Flutter Deployment Docs**: https://docs.flutter.dev/deployment
- **iOS Guidelines**: https://developer.apple.com/app-store/review/guidelines/
- **Android Guidelines**: https://play.google.com/console/about/guides/
- **App Store Connect**: https://appstoreconnect.apple.com
- **Play Console**: https://play.google.com/console

---

## 🎯 Priority Next Steps

1. **Create Production Signing Keys** (iOS & Android)
2. **Set up App Store Connect & Play Console accounts**
3. **Take Screenshots** of app on various devices
4. **Write Store Descriptions** (copy provided above)
5. **Create Privacy Policy** page
6. **Test with Real Device** + verify FCM notifications work
7. **Submit for Review** (start with internal testing on Android)

**Estimated time to first submission**: 1-2 days if accounts are ready

---

Generated: November 17, 2025
