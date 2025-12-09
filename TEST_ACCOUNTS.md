# NCM Mobile App - Test Accounts

All passwords have been reset to: **`password123`**

---

## 👤 MEMBER TEST ACCOUNTS

### 1. Gustav Matthew Shannon Bock (Primary Member)
- **Email**: `gbock14@gmail.com`
- **Password**: `password123`
- **Name**: Gustav Matthew Shannon Bock
- **Membership #**: NCM1
- **Use For**: Primary member testing

### 2. Test Member (Secondary)
- **Email**: `test@member.com`
- **Password**: `password123`
- **Name**: Test Member
- **Membership #**: NCM1965
- **Use For**: Secondary member testing

### 3. Sarah Johnson
- **Email**: `sarah.johnson@example.com`
- **Password**: `password123`
- **Name**: Sarah Johnson
- **Membership #**: NK2024001
- **Use For**: Alternative member testing

---

## 👨‍💼 LEADER TEST ACCOUNTS

### 1. Gustav Matthew Shannon (Admin - Top Leader)
- **Email**: `chairperson@namakwacivic.org.za`
- **Password**: `password123`
- **Name**: Gustav Matthew Shannon
- **Level**: **Admin** (Highest level)
- **Use For**:
  - Full leader functionality testing
  - Push notification sending
  - SMS sending
  - All admin features
  - Member registration
  - Visit management
  - Analytics access

### 2. Jacques (Admin)
- **Email**: `jvw679@gmail.com`
- **Password**: `password123`
- **Name**: Jacques
- **Level**: **Admin**
- **Use For**:
  - Admin-level testing
  - All leader features
  - Alternative admin account

### 3. Malcolm (Leader)
- **Email**: `mallyg30@gmail.com`
- **Password**: `password123`
- **Name**: Malcolm
- **Level**: **Leader**
- **Use For**:
  - Mid-level leader testing
  - Testing leader permissions (not admin)
  - May have limited access compared to Admin

### 4. Estelanie (Secretary)
- **Email**: `vanzylesty@gmail.com`
- **Password**: `password123`
- **Name**: Estelanie
- **Level**: **Secretary**
- **Use For**:
  - Testing specific role permissions
  - Secretary-level access
  - Different permission set from Admin/Leader

---

## 🎯 Recommended Testing Accounts

### For Member Testing
**Use**: `member@test.com` / `password123`
- Clean, simple test account
- Membership #: NCM1
- Best for general member feature testing

### For Leader Testing (Full Access)
**Use**: `chairperson@namakwacivic.org.za` / `password123`
- Admin level (highest permissions)
- Can send push notifications
- Can send SMS
- Full access to all features

### For Leader Testing (Mid-Level)
**Use**: `mallyg30@gmail.com` / `password123`
- Leader level (not admin)
- Test permission differences

### For Leader Testing (Secretary Role)
**Use**: `vanzylesty@gmail.com` / `password123`
- Secretary level
- Different permission set

---

## 📋 Testing Scenarios by Account

### Member Account Testing (member@test.com)

**Login & Profile**
- [ ] Login successfully
- [ ] View digital membership card
- [ ] See QR code
- [ ] View profile information

**Content Viewing**
- [ ] View 3 announcements
- [ ] View 11 events
- [ ] View 5 polls
- [ ] Vote on polls

**Interactions**
- [ ] Register for events
- [ ] Submit complaints
- [ ] View payment status
- [ ] Update profile

### Admin Leader Testing (chairperson@namakwacivic.org.za)

**Member Management**
- [ ] Register new members
- [ ] Search members
- [ ] Scan QR codes
- [ ] View member profiles

**Visit Management**
- [ ] Create visits
- [ ] Check-in to visits
- [ ] Add visit notes
- [ ] Complete visits

**Supporter Management**
- [ ] View 1,523 supporters
- [ ] Add new supporters
- [ ] Filter by ward/voter status

**Admin Features**
- [ ] Send push notifications to all members
- [ ] Send SMS to members
- [ ] View notification history
- [ ] View SMS statistics

**Analytics**
- [ ] View performance metrics
- [ ] Check registration stats
- [ ] View sentiment analysis

### Mid-Level Leader Testing (mallyg30@gmail.com)

**Test Permission Differences**
- [ ] Can still register members?
- [ ] Can create visits?
- [ ] Can send notifications? (probably no)
- [ ] Can send SMS? (probably no)
- [ ] What features are restricted?

### Secretary Testing (vanzylesty@gmail.com)

**Test Role-Specific Permissions**
- [ ] What can secretary do?
- [ ] What features are available?
- [ ] Any special secretary-only features?

---

## 🔐 Security Note

These passwords are for **LOCAL TESTING ONLY**.

**Never**:
- Use these passwords in production
- Commit passwords to git
- Share these accounts outside development team

---

## 💡 Testing Tips

### Quick Login Test
1. Open mobile app
2. Enter: `member@test.com`
3. Password: `password123`
4. Should see member dashboard

### Switch Between Roles
To test both member and leader:
1. Login as member → Test member features → Logout
2. Login as leader → Test leader features → Logout
3. Compare experiences

### Test Multiple Leaders
Test with different leader levels to see permission differences:
- Admin (chairperson@namakwacivic.org.za) - Full access
- Leader (mallyg30@gmail.com) - Mid-level
- Secretary (vanzylesty@gmail.com) - Role-specific

### Password Reset (if needed)
If you need to reset passwords again:
```bash
cd /Users/jacquesvanwyk/Developer/motionstack/ncm2025
php reset_test_passwords.php
```

---

## 📊 Additional Test Accounts Available

### More Members (10 total available)
If you need additional member accounts:
- `7912195031876@ncm.member` - Jacques Van Wyk
- `sarah.johnson@ncm.co.za` - Sarah Johnson (NCM2024001)
- And 4 more test accounts

### More Leaders (67 total available)
Additional leader accounts (passwords NOT reset):
- `hilloxnel@gmail.com` - Hilton (Admin)
- `29adamsrf@gmail.com` - Rodville Franklin (Admin)
- `calvinowatt@gmail.com` - Calvino (Admin)
- And 60+ more leaders at various levels

To reset passwords for these accounts, add them to `reset_test_passwords.php` and run again.

---

## ✅ Quick Reference

**All Passwords**: `password123`

**Member**: `member@test.com`
**Admin Leader**: `chairperson@namakwacivic.org.za`
**Mid Leader**: `mallyg30@gmail.com`
**Secretary**: `vanzylesty@gmail.com`

**API URL**: `http://127.0.0.1:8000`
**App Environment**: Development

---

**Last Updated**: 2025-11-20
**Passwords Set**: ✓ Done
**Ready to Test**: YES ✓
