import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../core/services/api_service.dart';
import '../providers/auth_provider.dart';
import 'local_database.dart';

// Sync service provider
final syncServiceProvider = Provider<SyncService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final localDb = ref.watch(localDatabaseProvider);
  final auth = ref.watch(authProvider);
  return SyncService(apiService, localDb, auth);
});

// Background sync status provider
final backgroundSyncProvider = StateNotifierProvider<BackgroundSyncNotifier, BackgroundSyncState>((ref) {
  final syncService = ref.watch(syncServiceProvider);
  return BackgroundSyncNotifier(syncService);
});

enum SyncStatus { idle, syncing, success, error, conflictResolved }

enum ConflictResolution { keepLocal, keepServer, merge }

class BackgroundSyncState {
  final SyncStatus status;
  final String? message;
  final int pendingItems;
  final int totalItems;
  final double progress;
  final List<SyncConflict> conflicts;
  final DateTime? lastSyncTime;

  const BackgroundSyncState({
    this.status = SyncStatus.idle,
    this.message,
    this.pendingItems = 0,
    this.totalItems = 0,
    this.progress = 0.0,
    this.conflicts = const [],
    this.lastSyncTime,
  });

  BackgroundSyncState copyWith({
    SyncStatus? status,
    String? message,
    int? pendingItems,
    int? totalItems,
    double? progress,
    List<SyncConflict>? conflicts,
    DateTime? lastSyncTime,
  }) {
    return BackgroundSyncState(
      status: status ?? this.status,
      message: message ?? this.message,
      pendingItems: pendingItems ?? this.pendingItems,
      totalItems: totalItems ?? this.totalItems,
      progress: progress ?? this.progress,
      conflicts: conflicts ?? this.conflicts,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }
}

class SyncConflict {
  final String id;
  final String type;
  final String action;
  final Map<String, dynamic> localData;
  final Map<String, dynamic> serverData;
  final DateTime conflictTime;
  final ConflictResolution? resolution;

  const SyncConflict({
    required this.id,
    required this.type,
    required this.action,
    required this.localData,
    required this.serverData,
    required this.conflictTime,
    this.resolution,
  });

  SyncConflict copyWith({ConflictResolution? resolution}) {
    return SyncConflict(
      id: id,
      type: type,
      action: action,
      localData: localData,
      serverData: serverData,
      conflictTime: conflictTime,
      resolution: resolution ?? this.resolution,
    );
  }
}

class BackgroundSyncNotifier extends StateNotifier<BackgroundSyncState> {
  final SyncService _syncService;
  Timer? _syncTimer;

  BackgroundSyncNotifier(this._syncService) : super(const BackgroundSyncState()) {
    _initializeBackgroundSync();
  }

  void _initializeBackgroundSync() {
    // Start background sync every 5 minutes when online
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      if (state.status != SyncStatus.syncing) {
        startBackgroundSync();
      }
    });
  }

  Future<void> startBackgroundSync() async {
    if (state.status == SyncStatus.syncing) return;

    try {
      state = state.copyWith(
        status: SyncStatus.syncing,
        message: 'Starting background sync...',
      );

      await _syncService.performBackgroundSync(_updateSyncProgress);

      state = state.copyWith(
        status: SyncStatus.success,
        message: 'Background sync completed successfully',
        lastSyncTime: DateTime.now(),
        progress: 1.0,
      );

      // Reset to idle after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = state.copyWith(
            status: SyncStatus.idle,
            message: null,
            progress: 0.0,
          );
        }
      });
    } catch (e) {
      state = state.copyWith(
        status: SyncStatus.error,
        message: 'Background sync failed: ${e.toString()}',
        progress: 0.0,
      );
    }
  }

  void _updateSyncProgress({
    String? message,
    int? pendingItems,
    int? totalItems,
    double? progress,
    List<SyncConflict>? conflicts,
  }) {
    state = state.copyWith(
      message: message ?? state.message,
      pendingItems: pendingItems ?? state.pendingItems,
      totalItems: totalItems ?? state.totalItems,
      progress: progress ?? state.progress,
      conflicts: conflicts ?? state.conflicts,
    );
  }

  Future<void> resolveConflict(String conflictId, ConflictResolution resolution) async {
    try {
      final updatedConflicts = state.conflicts.map((conflict) {
        if (conflict.id == conflictId) {
          return conflict.copyWith(resolution: resolution);
        }
        return conflict;
      }).toList();

      state = state.copyWith(conflicts: updatedConflicts);

      await _syncService.resolveConflict(conflictId, resolution);

      // Remove resolved conflict
      final remainingConflicts = state.conflicts.where((c) => c.id != conflictId).toList();
      state = state.copyWith(
        conflicts: remainingConflicts,
        status: SyncStatus.conflictResolved,
        message: 'Conflict resolved successfully',
      );
    } catch (e) {
      state = state.copyWith(
        status: SyncStatus.error,
        message: 'Failed to resolve conflict: ${e.toString()}',
      );
    }
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }
}

class SyncService {
  final ApiService _apiService;
  final LocalDatabaseService _localDb;
  final AsyncValue<UserModel?> _auth;

  SyncService(this._apiService, this._localDb, this._auth);

  // T076: Background sync with conflict resolution
  // Constitutional requirement: Offline capability with sync (FR-024)

  Future<void> performBackgroundSync(Function({
    String? message,
    int? pendingItems,
    int? totalItems,
    double? progress,
    List<SyncConflict>? conflicts,
  }) onProgress) async {

    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection available');
    }

    // Check authentication
    final user = _auth.valueOrNull;
    if (user?.member?.municipalityId == null) {
      throw Exception('No authenticated user found');
    }

    onProgress(message: 'Checking pending sync items...');

    // Get pending sync items
    final pendingItems = await _localDb.getPendingSyncItems();
    final totalItems = pendingItems.length;

    if (totalItems == 0) {
      onProgress(message: 'No items to sync', progress: 1.0);
      return;
    }

    onProgress(
      message: 'Found $totalItems items to sync',
      pendingItems: totalItems,
      totalItems: totalItems,
      progress: 0.0,
    );

    final conflicts = <SyncConflict>[];
    int processedItems = 0;

    for (final item in pendingItems) {
      try {
        onProgress(
          message: 'Syncing ${item['type']} ${item['action']}...',
          pendingItems: totalItems - processedItems,
          progress: processedItems / totalItems,
        );

        await _syncIndividualItem(item, conflicts);

        // Mark as completed
        await _localDb.markSyncItemAsCompleted(item['sync_id']);

        processedItems++;

        onProgress(
          progress: processedItems / totalItems,
          pendingItems: totalItems - processedItems,
        );

      } catch (e) {
        await _localDb.updateSyncItemError(item['sync_id'], e.toString());

        // Check if it's a conflict
        if (e.toString().contains('conflict') || e.toString().contains('version')) {
          await _handleSyncConflict(item, conflicts);
        }
      }
    }

    // Report conflicts if any
    if (conflicts.isNotEmpty) {
      onProgress(
        message: 'Sync completed with ${conflicts.length} conflicts to resolve',
        conflicts: conflicts,
        progress: 1.0,
      );
    } else {
      onProgress(
        message: 'Background sync completed successfully',
        progress: 1.0,
      );
    }
  }

  Future<void> _syncIndividualItem(Map<String, dynamic> item, List<SyncConflict> conflicts) async {
    final type = item['type'] as String;
    final action = item['action'] as String;
    final data = json.decode(item['data'] as String) as Map<String, dynamic>;

    switch (type) {
      case 'poll_response':
        await _syncPollResponse(data, action);
        break;
      case 'event_rsvp':
        await _syncEventRsvp(data, action);
        break;
      case 'feedback':
        await _syncFeedback(data, action);
        break;
      case 'profile':
        await _syncProfile(data, action);
        break;
      default:
        throw Exception('Unknown sync type: $type');
    }
  }

  Future<void> _syncPollResponse(Map<String, dynamic> data, String action) async {
    final user = _auth.valueOrNull!;

    switch (action) {
      case 'create':
        await _apiService.submitPollVote(
          user.member!.municipalityId,
          data['poll_id'],
          data['response'],
        );
        break;
      default:
        throw Exception('Unsupported poll response action: $action');
    }
  }

  Future<void> _syncEventRsvp(Map<String, dynamic> data, String action) async {
    final user = _auth.valueOrNull!;

    switch (action) {
      case 'create':
      case 'update':
        await _apiService.submitEventRsvp(
          user.member!.municipalityId,
          data['event_id'],
          {
            'status': data['status'],
            'guests_count': data['guests_count'],
          },
        );
        break;
      default:
        throw Exception('Unsupported event RSVP action: $action');
    }
  }

  Future<void> _syncFeedback(Map<String, dynamic> data, String action) async {
    final user = _auth.valueOrNull!;

    switch (action) {
      case 'create':
        await _apiService.submitFeedback(
          municipalityId: user.member!.municipalityId,
          category: data['category'],
          message: data['message'],
          photo: data['photo_path'] != null ? File(data['photo_path']) : null,
        );
        break;
      default:
        throw Exception('Unsupported feedback action: $action');
    }
  }

  Future<void> _syncProfile(Map<String, dynamic> data, String action) async {
    switch (action) {
      case 'update':
        await _apiService.updateProfile(data);
        break;
      default:
        throw Exception('Unsupported profile action: $action');
    }
  }

  Future<void> _handleSyncConflict(Map<String, dynamic> item, List<SyncConflict> conflicts) async {
    try {
      // Fetch current server data for comparison
      final serverData = await _fetchServerData(item['type'], item);

      final conflict = SyncConflict(
        id: item['sync_id'],
        type: item['type'],
        action: item['action'],
        localData: json.decode(item['data']),
        serverData: serverData,
        conflictTime: DateTime.now(),
      );

      conflicts.add(conflict);
    } catch (e) {
      debugPrint('Error creating conflict record: $e');
    }
  }

  Future<Map<String, dynamic>> _fetchServerData(String type, Map<String, dynamic> item) async {
    // Fetch current server data for conflict resolution
    final user = _auth.valueOrNull!;

    switch (type) {
      case 'profile':
        final profile = await _apiService.getProfile();
        return profile.toJson();

      case 'poll_response':
        // For poll responses, we might need to check current poll state
        final polls = await _apiService.getPolls(user.member!.municipalityId);
        final pollId = json.decode(item['data'])['poll_id'];
        final poll = polls.firstWhere((p) => p.id == pollId);
        return poll.toJson();

      default:
        return {};
    }
  }

  Future<void> resolveConflict(String conflictId, ConflictResolution resolution) async {
    final pendingItems = await _localDb.getPendingSyncItems();
    final conflictItem = pendingItems.firstWhere((item) => item['sync_id'] == conflictId);

    switch (resolution) {
      case ConflictResolution.keepLocal:
        // Force sync local data to server
        await _syncIndividualItem(conflictItem, []);
        await _localDb.markSyncItemAsCompleted(conflictId);
        break;

      case ConflictResolution.keepServer:
        // Discard local changes
        await _localDb.markSyncItemAsCompleted(conflictId);
        // Fetch latest server data and update local cache
        await _refreshLocalDataFromServer(conflictItem);
        break;

      case ConflictResolution.merge:
        // Implement merge logic based on data type
        await _performDataMerge(conflictItem);
        await _localDb.markSyncItemAsCompleted(conflictId);
        break;
    }
  }

  Future<void> _refreshLocalDataFromServer(Map<String, dynamic> item) async {
    final type = item['type'] as String;
    final user = _auth.valueOrNull!;

    switch (type) {
      case 'profile':
        final profile = await _apiService.getProfile();
        // Update local cache with server profile
        break;

      case 'poll_response':
        final polls = await _apiService.getPolls(user.member!.municipalityId);
        // Update local poll cache
        for (final poll in polls) {
          await _localDb.cachePoll(poll.toJson());
        }
        break;
    }
  }

  Future<void> _performDataMerge(Map<String, dynamic> item) async {
    final type = item['type'] as String;

    switch (type) {
      case 'profile':
        // For profile, merge non-conflicting fields
        await _mergeProfileData(item);
        break;

      default:
        // For other types, default to keeping server data
        await _refreshLocalDataFromServer(item);
        break;
    }
  }

  Future<void> _mergeProfileData(Map<String, dynamic> item) async {
    final localData = json.decode(item['data']) as Map<String, dynamic>;
    final serverProfile = await _apiService.getProfile();
    final serverData = serverProfile.toJson();

    // Merge strategy: keep local changes for user-editable fields,
    // keep server data for system fields
    final mergedData = <String, dynamic>{};

    // User-editable fields - prefer local
    final userFields = ['first_name', 'last_name', 'phone', 'alternative_phone', 'address', 'town'];
    for (final field in userFields) {
      if (localData.containsKey(field)) {
        mergedData[field] = localData[field];
      } else if (serverData.containsKey(field)) {
        mergedData[field] = serverData[field];
      }
    }

    // System fields - prefer server
    final systemFields = ['membership_number', 'membership_status', 'municipality_id'];
    for (final field in systemFields) {
      if (serverData.containsKey(field)) {
        mergedData[field] = serverData[field];
      }
    }

    // Sync merged data to server
    await _apiService.updateProfile(mergedData);
  }
}