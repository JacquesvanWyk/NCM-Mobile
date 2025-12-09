# NCM Mobile App - Local Testing Guide

## ✅ Setup Complete!

Your mobile app is now configured to test with the local database:
- **Environment**: Development
- **API URL**: http://127.0.0.1:8000
- **Laravel Server**: Running ✓
- **Test Data**: 3 announcements created ✓

---

## 🔐 Test User Credentials

### Member Account
- **Email**: `member@test.com`
- **Password**: You need to set/verify this (see below)
- **Name**: Gustav Matthew Shannon Bock
- **Membership Number**: NCM1
- **Role**: Standard Member

### Leader Account
- **Email**: `chairperson@namakwacivic.org.za`
- **Password**: You need to set/verify this (see below)
- **Name**: Gustav Matthew Shannon Bock
- **Level**: Admin (Top Leader)
- **Permissions**: Full access

### Reset Passwords (if needed)

If you don't know the passwords, run this in the backend directory:

```bash
cd /Users/jacquesvanwyk/Developer/motionstack/ncm2025
php artisan tinker
```

Then execute:
```php
// Set member password
$member = User::where('email', 'member@test.com')->first();
$member->password = Hash::make('password');
$member->save();

// Set leader password
$leader = User::where('email', 'chairperson@namakwacivic.org.za')->first();
$leader->password = Hash::make('password');
$leader->save();

echo "Passwords reset to: password\n";
```

---

## 🚀 Start Testing

### 1. Restart the Mobile App

**Important**: You MUST restart the app for environment changes to take effect!

If running in VS Code or Android Studio:
- Stop the app completely
- Run: `flutter run`

Or in terminal:
```bash
cd /Users/jacquesvanwyk/Developer/mobile/ncm_mobile_app
flutter run
```

The app should now show **"NCM Mobile (Dev)"** as the title, confirming development mode.

---

## 📋 Member Testing Checklist

### Login as Member
1. **Login** with member@test.com
2. Check if dashboard loads
3. Verify you see "Member" role

### Test Member Features

#### 🎴 Digital Membership Card
- [ ] View membership card
- [ ] QR code displays correctly
- [ ] Member details show (name, number, municipality)

#### 📢 Announcements (3 test announcements available)
- [ ] Open Announcements page
- [ ] See 3 announcements:
  - "Community Meeting This Saturday" (High priority)
  - "New Membership Benefits" (Medium priority)
  - "System Maintenance Notice" (Low priority)
- [ ] Tap to read full announcement
- [ ] Mark as read

#### 📅 Events (11 events available)
- [ ] View events list
- [ ] See event details
- [ ] Register for an event
- [ ] Cancel registration

#### 🗳️ Polls & Surveys (5 polls available)
- [ ] View active polls
- [ ] Vote on a poll
- [ ] See poll results

#### 📝 Report Issues/Complaints
- [ ] Open complaint form
- [ ] Fill in complaint details
- [ ] Upload a photo (optional)
- [ ] Submit complaint
- [ ] View complaint status

#### 💳 Membership & Payments
- [ ] View membership status
- [ ] Check payment due status
- [ ] View payment history

#### 👤 Profile & Settings
- [ ] View profile information
- [ ] Update contact details
- [ ] Logout

---

## 📋 Leader Testing Checklist

### Login as Leader
1. **Logout** from member account
2. **Login** with chairperson@namakwacivic.org.za
3. Check if leader dashboard loads
4. Verify you see "Leader" role with level displayed

### Test Leader Features

#### 👥 Member Management

##### Member Registration
- [ ] Open member registration form
- [ ] Fill in member details
- [ ] Validate ID number (should check if exists)
- [ ] Complete registration
- [ ] Verify new member created

##### QR Code Scanning
- [ ] Open QR scanner
- [ ] Scan a member's QR code
- [ ] View member details after scan
- [ ] Create visit from QR scan

##### Member Search
- [ ] Search by name
- [ ] Search by membership number
- [ ] View member profile from search results

#### 🏠 Visit Management (6 existing visits)

- [ ] View visits list
- [ ] See visits with different statuses:
  - Scheduled
  - In Progress
  - Completed
- [ ] Filter by status

##### Create New Visit
- [ ] Tap "Create Visit"
- [ ] Select member to visit
- [ ] Add visit details
- [ ] Schedule visit date/time
- [ ] Save visit

##### Execute Visit
- [ ] Select a scheduled visit
- [ ] Check-in to visit
- [ ] Add visit notes during visit
- [ ] Add private leader notes
- [ ] Check-out from visit
- [ ] View completed visit

#### 🤝 Supporter Management (1,523 supporters available)

- [ ] View supporters list
- [ ] See supporter count
- [ ] Filter by ward
- [ ] Filter by registered voter status
- [ ] View supporter stats (total, registered voters, will vote, special vote)

##### Add New Supporter
- [ ] Open supporter registration
- [ ] Capture supporter details
- [ ] Add voter information
- [ ] Save supporter
- [ ] Verify in supporters list

#### 📊 Analytics & Reports

- [ ] View performance analytics
- [ ] Check registration metrics
- [ ] View visit statistics
- [ ] See sentiment analysis (if available)

#### 📝 Complaints Management

- [ ] View all complaints
- [ ] Filter by status (open/in-progress/resolved)
- [ ] Filter by priority
- [ ] View complaint details

##### Log Simple Complaint
- [ ] Quick complaint logging
- [ ] Add description
- [ ] Assign priority
- [ ] Submit

#### 📲 Push Notifications (Top Leader Only)

- [ ] Open notifications section
- [ ] Send notification to all members
- [ ] Send notification to specific group
- [ ] View notification history
- [ ] Check notification statistics

#### 💬 SMS Features (Top Leader Only)

- [ ] Send individual SMS
- [ ] Send bulk SMS
- [ ] View SMS history
- [ ] Filter SMS by status (sent/delivered/failed)
- [ ] Check SMS statistics

---

## 🧪 Integration Testing

### Member-Leader Interaction
1. **Leader** creates a visit for a member
2. **Member** receives notification about visit
3. **Member** views visit details
4. **Leader** completes visit
5. **Member** can see visit history

### Complaint Flow
1. **Member** submits a complaint
2. **Leader** sees complaint in complaints list
3. **Leader** updates complaint status
4. **Member** sees updated status

---

## 📊 Available Test Data

| Data Type | Count | Notes |
|-----------|-------|-------|
| **Members** | 1,794 | 10 have user accounts |
| **Leaders** | 67 | All have user accounts |
| **Events** | 11 | Various dates and statuses |
| **Announcements** | 3 | Just created (high/medium/low priority) |
| **Polls** | 5 | Available for voting |
| **Visits** | 6 | Different statuses |
| **Supporters** | 1,523 | Can filter by ward/voter status |
| **Complaints** | 0 | Will be created during testing |

---

## 🐛 Bug Tracking

As you test, document any issues:

| Feature | Issue Description | Severity | Screen/Page | Notes |
|---------|------------------|----------|-------------|-------|
| | | High/Med/Low | | |

**Severity Levels:**
- **High**: Feature doesn't work, crashes app, blocks testing
- **Medium**: Feature works but has issues, workarounds possible
- **Low**: UI/UX issues, minor bugs, cosmetic issues

---

## ✅ Success Criteria

### Must Work
- ✓ Login for both member and leader
- ✓ Dashboard loads with correct role
- ✓ API communication (data loads from local Laravel)
- ✓ Core features functional for each role

### Should Work
- Member can view and interact with content
- Leader can manage members and visits
- Notifications display correctly
- Forms submit successfully

### Nice to Have
- Smooth animations and transitions
- Fast loading times
- Offline functionality (if implemented)
- Error messages are clear and helpful

---

## 🔧 Troubleshooting

### App Not Connecting to Laravel

**Symptoms**: "Network error", empty lists, can't login

**Solutions**:
1. Verify Laravel server is running:
   ```bash
   lsof -i:8000
   ```
   Should show a process on port 8000

2. Test Laravel directly:
   ```bash
   curl http://127.0.0.1:8000
   ```
   Should return HTML

3. Check app shows "NCM Mobile (Dev)" in title
   - If not, environment didn't change - restart app

4. Check mobile app logs for API errors

### Can't Login

**Symptoms**: "Invalid credentials" error

**Solutions**:
1. Reset password using Tinker (see above)
2. Verify user exists in database:
   ```php
   php artisan tinker
   User::where('email', 'member@test.com')->first();
   ```
3. Check Laravel logs: `storage/logs/laravel.log`

### Empty Lists (No Data)

**Symptoms**: Announcements/events/polls show empty

**Solutions**:
1. Verify test data was created:
   ```bash
   php artisan tinker
   echo Announcement::count();
   echo Event::count();
   echo Poll::count();
   ```

2. Check API endpoint manually:
   ```bash
   curl http://127.0.0.1:8000/api/announcements
   ```

3. Check if user has correct municipality/permissions

### App Crashes

**Symptoms**: App closes unexpectedly

**Solutions**:
1. Check Flutter console for error messages
2. Look for null reference errors
3. Verify API responses have expected data structure
4. Check Laravel logs for 500 errors

---

## 📝 Testing Notes Template

Use this template to document your testing session:

```markdown
## Testing Session - [Date]

### Environment
- Laravel Server: Running ✓ / Not Running ✗
- Mobile App Environment: Development ✓ / Production ✗
- Device/Emulator: [Device name]

### Member Testing
**Login**: ✓ Success / ✗ Failed
**Features Tested**:
- Digital Card: ✓ / ✗ - [notes]
- Announcements: ✓ / ✗ - [notes]
- Events: ✓ / ✗ - [notes]
- Polls: ✓ / ✗ - [notes]
- Complaints: ✓ / ✗ - [notes]
- Payments: ✓ / ✗ - [notes]

### Leader Testing
**Login**: ✓ Success / ✗ Failed
**Features Tested**:
- Member Registration: ✓ / ✗ - [notes]
- QR Scanning: ✓ / ✗ - [notes]
- Member Search: ✓ / ✗ - [notes]
- Visits: ✓ / ✗ - [notes]
- Supporters: ✓ / ✗ - [notes]
- Analytics: ✓ / ✗ - [notes]
- Notifications: ✓ / ✗ - [notes]

### Issues Found
1. [Description] - Severity: [High/Med/Low]
2. [Description] - Severity: [High/Med/Low]

### Overall Assessment
[Summary of testing session, what works, what needs fixing]
```

---

## 🎯 Next Steps After Testing

1. **Document all bugs** found during testing
2. **Prioritize fixes** (High → Medium → Low)
3. **Test fixes** with same checklist
4. **Performance check** - note any slow loading
5. **User experience** - note confusing UI or flows
6. **Missing features** - list any gaps in functionality

---

## 📞 Quick Reference

**Laravel Server**: http://127.0.0.1:8000
**API Base**: http://127.0.0.1:8000/api

**Test Accounts**:
- Member: member@test.com
- Leader: chairperson@namakwacivic.org.za

**Backend Directory**: `/Users/jacquesvanwyk/Developer/motionstack/ncm2025`
**Mobile App Directory**: `/Users/jacquesvanwyk/Developer/mobile/ncm_mobile_app`

---

**Happy Testing! 🎉**

Remember: The goal is to find issues NOW so they don't appear in production. Test thoroughly and document everything!
