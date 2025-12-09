# NCM Mobile App - Deployment Status

**Date:** November 17, 2025
**Status:** Ready for Store Submission 🚀

---

## ✅ Completed Setup

### Android
- [x] **Production Signing Key** Created
  - Location: `~/ncm-release-key.jks`
  - Password: `NCM2025SecureKey!`
  - Alias: `ncm-key`
  - **IMPORTANT:** Back this up securely - you'll need it for all future updates!

- [x] **Build Configuration**
  - `android/key.properties` configured
  - `android/app/build.gradle.kts` updated with signing config
  - ProGuard rules added
  - Minification enabled

- [x] **Build Status**
  - Building: `app-release.aab`
  - Location (when complete): `build/app/outputs/bundle/release/app-release.aab`

### iOS
- [ ] **Xcode Signing**
  - Xcode is open - configure signing manually
  - See: `IOS_SIGNING_STEPS.md`

### Backend & API
- [x] **Production URL** Configured
  - Production: `https://namakwacivic.org.za`
  - Already set in `lib/main.dart` line 41

- [x] **FCM Integration**
  - Backend FCM service working ✅
  - Firebase configured in mobile app ✅
  - Tested communication successful ✅

### Legal & Compliance
- [x] **Privacy Policy**
  - Created: `resources/views/privacy-policy-app.blade.php`
  - URL: `https://namakwacivic.org.za/privacy-policy-app`
  - POPIA compliant
  - Ready for store listings

---

## 📋 Next Steps

### 1. Finish iOS Signing (5 mins)
Follow steps in `IOS_SIGNING_STEPS.md`:
1. In Xcode (already open):
   - Select Runner target
   - Signing & Capabilities tab
   - Choose your Team
   - Enable "Automatically manage signing"
2. Close Xcode

### 2. Build iOS Release (10 mins)
```bash
cd /Users/jacquesvanwyk/Developer/mobile/ncm_mobile_app
flutter build ipa --release
```
Output will be in: `build/ios/ipa/NCM.ipa`

### 3. Take Screenshots (30 mins)
Use simulators to capture 6-8 screens:
```bash
# iOS Simulator
open -a Simulator
flutter run --release

# Screenshots needed:
# 1. Login/Welcome
# 2. Dashboard
# 3. Announcements
# 4. Complaint form
# 5. Profile
# 6. Notifications
```

Take screenshots:
- iPhone: Cmd + S in Simulator
- Save to a folder for upload

### 4. Upload to Stores

#### Google Play Console
1. Go to: https://play.google.com/console
2. Select/Create app: NCM Municipal Management
3. Production → Create Release
4. Upload: `build/app/outputs/bundle/release/app-release.aab`
5. Fill store listing:
   - App name: **NCM Municipal Management**
   - Short description: **Civic engagement and municipal service management**
   - Category: **Government**
   - Upload screenshots
   - Privacy policy: **https://namakwacivic.org.za/privacy-policy-app**

#### App Store Connect
1. Go to: https://appstoreconnect.apple.com
2. My Apps → Create New App
3. Bundle ID: `com.ncm.mobile` (or your configured one)
4. Use Xcode to upload:
   - Open `ios/Runner.xcworkspace`
   - Product → Archive
   - Distribute App → App Store Connect
5. Fill store listing:
   - App name: **NCM**
   - Subtitle: **Municipal Management**
   - Category: **Productivity/Government**
   - Upload screenshots (different sizes required)
   - Privacy policy: **https://namakwacivic.org.za/privacy-policy-app**

---

## 📝 Store Listing Copy (Pre-Written)

### Short Description (80 chars)
Civic engagement and municipal service management for Northern Cape citizens

### Full Description (Use for both stores)
```
NCM Municipal Management is the official mobile application for Northern Cape municipalities, enabling citizens to:

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

### Keywords (for App Store)
municipal, government, civic, south africa, northern cape, complaints, services

---

## 🔐 Security Checklist

- [x] Production API endpoint configured
- [x] Release signing configured (not debug keys)
- [x] Code minification enabled
- [x] ProGuard rules added
- [x] Sensitive data encrypted (tokens in secure storage)
- [x] HTTPS-only communication
- [ ] Remove any test accounts/passwords before submission

---

## 📱 Testing Before Submission

### Critical Tests
```bash
# 1. Build and install release version locally
flutter build apk --release
flutter install --release

# Test on device:
- [ ] Login works
- [ ] Push notifications received
- [ ] Complaint submission works
- [ ] Camera permissions work
- [ ] Offline mode functions
- [ ] No crashes on rotation
```

---

## 🎯 Deployment Timeline

| Task | Time | Status |
|------|------|--------|
| Android signing setup | 15 min | ✅ Done |
| iOS signing setup | 10 min | ⏳ In Progress |
| Build Android AAB | 5 min | ⏳ Building |
| Build iOS IPA | 10 min | ⏸️ Pending |
| Take screenshots | 30 min | ⏸️ Pending |
| Upload to stores | 30 min | ⏸️ Pending |
| **TOTAL** | **~2 hours** | **50% Complete** |

### Store Review Times
- **Google Play**: Few hours to 7 days
- **Apple App Store**: 24-48 hours typically

---

## 📞 Important URLs

- **App Store Connect:** https://appstoreconnect.apple.com
- **Play Console:** https://play.google.com/console
- **Privacy Policy:** https://namakwacivic.org.za/privacy-policy-app
- **Support Email:** privacy@namakwacivic.org.za

---

## ⚠️ IMPORTANT NOTES

1. **Backup Your Signing Key!**
   - File: `~/ncm-release-key.jks`
   - Password: `NCM2025SecureKey!`
   - **Without this, you cannot update the app!**

2. **Version Management**
   - Current: 1.0.0+1 (in `pubspec.yaml`)
   - For updates, increment build number: 1.0.0+2, 1.0.1+3, etc.

3. **Firebase Project**
   - Ensure production Firebase project is configured
   - Check `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist`

4. **Test with Real Devices**
   - Before final submission, test on at least one real iOS and Android device
   - Verify push notifications work end-to-end

---

**Next Immediate Action:** Complete iOS signing in Xcode, then build iOS IPA! 🚀
