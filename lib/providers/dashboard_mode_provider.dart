import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DashboardMode { member, leader }

class DashboardModeNotifier extends StateNotifier<DashboardMode> {
  static const String _dashboardModeKey = 'dashboard_mode';

  DashboardModeNotifier() : super(DashboardMode.member) {
    _loadSavedMode();
  }

  Future<void> _loadSavedMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMode = prefs.getString(_dashboardModeKey);
      if (savedMode != null) {
        state = savedMode == 'leader' ? DashboardMode.leader : DashboardMode.member;
      }
    } catch (e) {
      // If loading fails, default to member mode
      state = DashboardMode.member;
    }
  }

  Future<void> _saveMode(DashboardMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_dashboardModeKey, mode == DashboardMode.leader ? 'leader' : 'member');
    } catch (e) {
      // Fail silently, preference won't persist
    }
  }

  void switchToMember() {
    state = DashboardMode.member;
    _saveMode(state);
  }

  void switchToLeader() {
    state = DashboardMode.leader;
    _saveMode(state);
  }

  void setModeForUserType(String? userType) {
    // Force dashboard mode based on user type, ignoring saved preference
    if (userType == 'member') {
      state = DashboardMode.member;
      _saveMode(state);
    } else if (userType == 'leader' || userType == 'field_worker') {
      state = DashboardMode.leader;
      _saveMode(state);
    }
  }

  void toggle() {
    state = state == DashboardMode.member ? DashboardMode.leader : DashboardMode.member;
    _saveMode(state);
  }

  Future<void> reset() async {
    // Reset to member mode and clear saved preference
    state = DashboardMode.member;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_dashboardModeKey);
    } catch (e) {
      // Fail silently
    }
  }

  bool get isMemberMode => state == DashboardMode.member;
  bool get isLeaderMode => state == DashboardMode.leader;
}

final dashboardModeProvider = StateNotifierProvider<DashboardModeNotifier, DashboardMode>((ref) {
  return DashboardModeNotifier();
});
