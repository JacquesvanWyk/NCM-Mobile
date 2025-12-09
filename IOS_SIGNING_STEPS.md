# iOS Signing Configuration

Xcode should now be open. Follow these steps:

## 1. Select Runner Target
- In the left sidebar, click **Runner** (top blue icon)
- Make sure **Runner** target is selected in the center panel

## 2. Configure Signing
- Click on **Signing & Capabilities** tab
- Under **Team**: Select your Apple Developer account
  - If not listed, click "Add Account" and sign in
- ✅ Check **"Automatically manage signing"**
- **Bundle Identifier**: Should be `com.ncm.mobile` (or keep as is)
  - Note: If changing, also update in `pubspec.yaml` line 99

## 3. Set Deployment Target
- In **General** tab
- **Minimum Deployments**: iOS 13.0 or higher

## 4. Verify Provisioning Profile
- Should automatically show: **"Xcode Managed Profile"**
- If you see errors, make sure:
  - Your Apple Developer account is active
  - You're connected to internet
  - Bundle ID is unique

## 5. Close Xcode
Once signing is configured, you can close Xcode.
The signing configuration is now saved!

---

## Quick Check
After closing Xcode, run:
```bash
flutter build ios --release --no-codesign
```

If no errors, iOS signing is ready! ✅
