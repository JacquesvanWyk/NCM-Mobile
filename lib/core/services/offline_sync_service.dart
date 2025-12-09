import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Offline sync service provider
final offlineSyncServiceProvider = Provider<OfflineSyncService>((ref) {
  return OfflineSyncService();
});

// Connectivity provider
final connectivityProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

// Sync status provider
final syncStatusProvider = StateNotifierProvider<SyncStatusNotifier, SyncStatus>((ref) {
  return SyncStatusNotifier();
});

enum SyncStatus { idle, syncing, success, error }

class SyncStatusNotifier extends StateNotifier<SyncStatus> {
  SyncStatusNotifier() : super(SyncStatus.idle);

  void setSyncing() => state = SyncStatus.syncing;
  void setSuccess() => state = SyncStatus.success;
  void setError() => state = SyncStatus.error;
  void setIdle() => state = SyncStatus.idle;
}

class OfflineData {
  final String id;
  final String type; // 'complaint', 'feedback', 'visit', etc.
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final String action; // 'create', 'update', 'delete'
  final bool synced;

  OfflineData({
    required this.id,
    required this.type,
    required this.data,
    required this.timestamp,
    required this.action,
    this.synced = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'data': data,
    'timestamp': timestamp.toIso8601String(),
    'action': action,
    'synced': synced,
  };

  factory OfflineData.fromJson(Map<String, dynamic> json) => OfflineData(
    id: json['id'],
    type: json['type'],
    data: Map<String, dynamic>.from(json['data']),
    timestamp: DateTime.parse(json['timestamp']),
    action: json['action'],
    synced: json['synced'] ?? false,
  );
}

class OfflineSyncService {
  static const String _syncQueueFileName = 'offline_sync_queue.json';
  List<OfflineData> _syncQueue = [];
  bool _isOnline = false;

  // Initialize the service
  Future<void> initialize() async {
    await _loadSyncQueue();
    await _checkConnectivity();
  }

  // Check if device is online
  Future<void> _checkConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      _isOnline = connectivityResult != ConnectivityResult.none;

      if (_isOnline) {
        await syncPendingData();
      }
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      _isOnline = false;
    }
  }

  // Get local storage path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Get sync queue file
  Future<File> get _syncQueueFile async {
    final path = await _localPath;
    return File('$path/$_syncQueueFileName');
  }

  // Load sync queue from local storage
  Future<void> _loadSyncQueue() async {
    try {
      final file = await _syncQueueFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        _syncQueue = jsonData.map((item) => OfflineData.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint('Error loading sync queue: $e');
      _syncQueue = [];
    }
  }

  // Save sync queue to local storage
  Future<void> _saveSyncQueue() async {
    try {
      final file = await _syncQueueFile;
      final jsonData = _syncQueue.map((item) => item.toJson()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      debugPrint('Error saving sync queue: $e');
    }
  }

  // Add data to sync queue for offline processing
  Future<void> addToSyncQueue({
    required String type,
    required Map<String, dynamic> data,
    required String action,
  }) async {
    final offlineData = OfflineData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      data: data,
      timestamp: DateTime.now(),
      action: action,
    );

    _syncQueue.add(offlineData);
    await _saveSyncQueue();

    // Try to sync immediately if online
    if (_isOnline) {
      await syncPendingData();
    }
  }

  // Sync pending data when online
  Future<void> syncPendingData() async {
    if (_syncQueue.isEmpty) return;

    try {
      // Get unsynced items
      final unsyncedItems = _syncQueue.where((item) => !item.synced).toList();

      if (unsyncedItems.isEmpty) return;

      debugPrint('Syncing ${unsyncedItems.length} offline items...');

      // Process each unsynced item
      for (final item in unsyncedItems) {
        try {
          await _syncItem(item);

          // Mark as synced
          final index = _syncQueue.indexWhere((q) => q.id == item.id);
          if (index >= 0) {
            _syncQueue[index] = OfflineData(
              id: item.id,
              type: item.type,
              data: item.data,
              timestamp: item.timestamp,
              action: item.action,
              synced: true,
            );
          }
        } catch (e) {
          debugPrint('Error syncing item ${item.id}: $e');
          // Continue with next item
        }
      }

      // Clean up synced items older than 7 days
      final cutoffDate = DateTime.now().subtract(const Duration(days: 7));
      _syncQueue.removeWhere((item) =>
        item.synced && item.timestamp.isBefore(cutoffDate));

      await _saveSyncQueue();
      debugPrint('Sync completed successfully');

    } catch (e) {
      debugPrint('Error during sync: $e');
      rethrow;
    }
  }

  // Sync individual item - call actual API
  Future<void> _syncItem(OfflineData item) async {
    debugPrint('Syncing ${item.type} ${item.action}...');

    // Route to appropriate API endpoint based on type
    switch (item.type.toLowerCase()) {
      case 'member':
        await _syncMember(item);
        break;
      case 'supporter':
        await _syncSupporter(item);
        break;
      case 'complaint':
      case 'feedback':
      case 'visit':
        // TODO: Implement other types
        debugPrint('Sync not implemented for type: ${item.type}');
        break;
      default:
        debugPrint('Unknown sync type: ${item.type}');
    }
  }

  // Sync member to API
  Future<void> _syncMember(OfflineData item) async {
    // TODO: Import ApiServiceFactory and call the actual API
    // For now, just log that we would sync
    debugPrint('Would sync member: ${item.data}');

    // This needs to call:
    // final apiService = ApiServiceFactory.instance;
    // await apiService.createMember(item.data);

    throw UnimplementedError('Member API sync not yet implemented');
  }

  // Sync supporter to API
  Future<void> _syncSupporter(OfflineData item) async {
    debugPrint('Would sync supporter: ${item.data}');
    throw UnimplementedError('Supporter API sync not yet implemented');
  }

  // Get sync queue status
  Map<String, dynamic> getSyncStatus() {
    final unsynced = _syncQueue.where((item) => !item.synced).length;
    final total = _syncQueue.length;

    return {
      'isOnline': _isOnline,
      'pendingSync': unsynced,
      'totalQueued': total,
      'lastSync': _syncQueue.isNotEmpty
        ? _syncQueue.where((item) => item.synced).isNotEmpty
          ? _syncQueue.where((item) => item.synced).map((e) => e.timestamp).reduce((a, b) => a.isAfter(b) ? a : b)
          : null
        : null,
    };
  }

  // Get pending sync items
  List<OfflineData> getPendingItems() {
    return _syncQueue.where((item) => !item.synced).toList();
  }

  // Clear sync queue (for testing/debug)
  Future<void> clearSyncQueue() async {
    _syncQueue.clear();
    await _saveSyncQueue();
  }

  // Manual sync trigger
  Future<void> forcSync() async {
    await _checkConnectivity();
    if (_isOnline) {
      await syncPendingData();
    } else {
      throw Exception('Device is offline');
    }
  }

  // Update connectivity status
  void updateConnectivity(bool isOnline) {
    final wasOnline = _isOnline;
    _isOnline = isOnline;

    // If we just came online, try to sync
    if (!wasOnline && isOnline) {
      syncPendingData();
    }
  }
}