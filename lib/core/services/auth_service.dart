import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../constants/app_constants.dart';
import '../../data/models/user_model.dart';

class AuthService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token management
  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: AppConstants.tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: AppConstants.tokenKey);
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: AppConstants.tokenKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // User data management
  static Future<void> saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await _prefs?.setString(AppConstants.userKey, userJson);
  }

  static Future<UserModel?> getUser() async {
    final userJson = _prefs?.getString(AppConstants.userKey);
    if (userJson != null) {
      try {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      } catch (e) {
        // Invalid user data, remove it
        await deleteUser();
        return null;
      }
    }
    return null;
  }

  static Future<void> deleteUser() async {
    await _prefs?.remove(AppConstants.userKey);
  }

  // Authentication state
  static Future<bool> isLoggedIn() async {
    final hasTokenValue = await hasToken();
    final user = await getUser();
    return hasTokenValue && user != null;
  }

  static Future<String?> getUserType() async {
    final user = await getUser();
    return user?.userType;
  }

  static Future<bool> isMember() async {
    final userType = await getUserType();
    return userType == 'member';
  }

  static Future<bool> isLeader() async {
    final user = await getUser();
    final userType = user?.userType;
    // Check if userType is 'leader' OR if they have a leader object but NOT a member type
    return (userType == 'leader' || userType == 'field_worker') ||
           (user?.leader != null && userType != 'member');
  }

  static Future<String?> getLeaderLevel() async {
    final user = await getUser();
    // If level exists, use it. Otherwise fall back to leader name for display
    return user?.leader?.level ?? user?.leader?.name;
  }

  static Future<String?> getLeaderName() async {
    final user = await getUser();
    return user?.leader?.name;
  }

  static Future<bool> isLeaderLevel(String level) async {
    final leaderLevel = await getLeaderLevel();
    return leaderLevel == level;
  }

  static Future<bool> isTopLeader() async {
    // Now returns true for all leaders (not just top levels)
    return await isLeader();
  }

  static Future<bool> isAdmin() async {
    final userType = await getUserType();
    return userType == 'super_admin' || userType == 'municipality_admin';
  }

  // Complete logout
  static Future<void> logout() async {
    await deleteToken();
    await deleteUser();
    await _prefs?.remove(AppConstants.refreshTokenKey);
    await _secureStorage.delete(key: 'cached_email');
    await _secureStorage.delete(key: 'cached_password_hash');
  }

  // Offline login support
  static Future<void> cacheCredentials(String email, String password) async {
    // Hash password before storing
    final passwordBytes = utf8.encode(password);
    final passwordHash = sha256.convert(passwordBytes).toString();

    await _secureStorage.write(key: 'cached_email', value: email);
    await _secureStorage.write(key: 'cached_password_hash', value: passwordHash);
  }

  static Future<bool> validateCachedCredentials(String email, String password) async {
    try {
      final cachedEmail = await _secureStorage.read(key: 'cached_email');
      final cachedPasswordHash = await _secureStorage.read(key: 'cached_password_hash');

      if (cachedEmail == null || cachedPasswordHash == null) {
        return false;
      }

      // Hash the provided password and compare
      final passwordBytes = utf8.encode(password);
      final passwordHash = sha256.convert(passwordBytes).toString();

      return cachedEmail == email && cachedPasswordHash == passwordHash;
    } catch (e) {
      return false;
    }
  }

  // App preferences
  static Future<void> setFirstTime(bool isFirstTime) async {
    await _prefs?.setBool(AppConstants.isFirstTimeKey, isFirstTime);
  }

  static Future<bool> isFirstTime() async {
    return _prefs?.getBool(AppConstants.isFirstTimeKey) ?? true;
  }

  static Future<void> setThemeMode(String themeMode) async {
    await _prefs?.setString(AppConstants.themeKey, themeMode);
  }

  static Future<String> getThemeMode() async {
    return _prefs?.getString(AppConstants.themeKey) ?? 'system';
  }

  static Future<void> setLanguage(String languageCode) async {
    await _prefs?.setString(AppConstants.languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    return _prefs?.getString(AppConstants.languageKey) ?? 'en';
  }

  // Utility methods
  static Future<List<MunicipalityModel>> getUserMunicipalities() async {
    final user = await getUser();
    return user?.municipalities ?? [];
  }

  static Future<MemberModel?> getMemberProfile() async {
    final user = await getUser();
    return user?.member;
  }

  static Future<LeaderModel?> getLeaderProfile() async {
    final user = await getUser();
    return user?.leader;
  }

  static Future<int?> getCurrentMunicipalityId() async {
    final user = await getUser();
    // First try municipalities pivot table
    if (user?.municipalities?.isNotEmpty == true) {
      return user!.municipalities!.first.id;
    }
    // Fallback to leader's municipality_id
    if (user?.leader?.municipalityId != null) {
      return user!.leader!.municipalityId;
    }
    // Fallback to member's municipality_id
    if (user?.member?.municipalityId != null) {
      return user!.member!.municipalityId;
    }
    return null;
  }

  // Security helpers
  static Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
    await _prefs?.clear();
  }

  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}