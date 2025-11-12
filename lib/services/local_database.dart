import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// Local database service provider
final localDatabaseProvider = Provider<LocalDatabaseService>((ref) {
  return LocalDatabaseService();
});

class LocalDatabaseService {
  static Database? _database;
  static const String _databaseName = 'ncm_local.db';
  static const int _databaseVersion = 1;

  // T073: SQLite local database setup
  // Constitutional requirement: Offline capability (FR-024)

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables for offline caching
    await _createPollsTables(db);
    await _createAnnouncementsTables(db);
    await _createEventsTables(db);
    await _createFeedbackTables(db);
    await _createPaymentsTables(db);
    await _createSyncTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades
    if (oldVersion < newVersion) {
      // Add migration logic here when needed
    }
  }

  // Create polls-related tables
  Future<void> _createPollsTables(Database db) async {
    await db.execute('''
      CREATE TABLE cached_polls (
        id INTEGER PRIMARY KEY,
        municipality_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        poll_type TEXT NOT NULL,
        options TEXT, -- JSON string
        status TEXT NOT NULL,
        starts_at TEXT NOT NULL,
        ends_at TEXT NOT NULL,
        created_at TEXT NOT NULL,
        user_has_voted INTEGER DEFAULT 0,
        cached_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cached_poll_responses (
        id INTEGER PRIMARY KEY,
        poll_id INTEGER NOT NULL,
        response TEXT NOT NULL, -- JSON string
        submitted_at TEXT NOT NULL,
        synced INTEGER DEFAULT 0,
        FOREIGN KEY (poll_id) REFERENCES cached_polls (id)
      )
    ''');
  }

  // Create announcements table
  Future<void> _createAnnouncementsTables(Database db) async {
    await db.execute('''
      CREATE TABLE cached_announcements (
        id INTEGER PRIMARY KEY,
        municipality_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        priority TEXT NOT NULL,
        status TEXT NOT NULL,
        published_at TEXT NOT NULL,
        expires_at TEXT,
        created_at TEXT NOT NULL,
        cached_at TEXT NOT NULL
      )
    ''');
  }

  // Create events tables
  Future<void> _createEventsTables(Database db) async {
    await db.execute('''
      CREATE TABLE cached_events (
        id INTEGER PRIMARY KEY,
        municipality_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        location TEXT NOT NULL,
        starts_at TEXT NOT NULL,
        ends_at TEXT,
        max_attendees INTEGER,
        requires_rsvp INTEGER DEFAULT 0,
        status TEXT NOT NULL,
        created_at TEXT NOT NULL,
        user_rsvp_status TEXT,
        user_guests_count INTEGER DEFAULT 0,
        total_attending INTEGER DEFAULT 0,
        total_not_attending INTEGER DEFAULT 0,
        total_maybe INTEGER DEFAULT 0,
        cached_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cached_event_rsvps (
        id INTEGER PRIMARY KEY,
        event_id INTEGER NOT NULL,
        status TEXT NOT NULL,
        guests_count INTEGER DEFAULT 0,
        rsvp_at TEXT NOT NULL,
        synced INTEGER DEFAULT 0,
        FOREIGN KEY (event_id) REFERENCES cached_events (id)
      )
    ''');
  }

  // Create feedback tables
  Future<void> _createFeedbackTables(Database db) async {
    await db.execute('''
      CREATE TABLE cached_feedback (
        id INTEGER PRIMARY KEY,
        municipality_id INTEGER NOT NULL,
        category TEXT NOT NULL,
        message TEXT NOT NULL,
        photo_path TEXT,
        status TEXT NOT NULL DEFAULT 'pending',
        created_at TEXT NOT NULL,
        synced INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE feedback_history (
        id INTEGER PRIMARY KEY,
        category TEXT NOT NULL,
        message TEXT NOT NULL,
        status TEXT NOT NULL,
        submitted_at TEXT NOT NULL,
        response_at TEXT,
        response_message TEXT,
        cached_at TEXT NOT NULL
      )
    ''');
  }

  // Create payments tables
  Future<void> _createPaymentsTables(Database db) async {
    await db.execute('''
      CREATE TABLE cached_payments (
        id INTEGER PRIMARY KEY,
        amount REAL NOT NULL,
        years_covered INTEGER NOT NULL,
        payment_method TEXT NOT NULL,
        status TEXT NOT NULL,
        covers_period_start TEXT NOT NULL,
        covers_period_end TEXT NOT NULL,
        paid_at TEXT,
        created_at TEXT NOT NULL,
        cached_at TEXT NOT NULL
      )
    ''');
  }

  // Create sync management tables
  Future<void> _createSyncTables(Database db) async {
    await db.execute('''
      CREATE TABLE sync_queue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sync_id TEXT UNIQUE NOT NULL,
        type TEXT NOT NULL,
        action TEXT NOT NULL,
        data TEXT NOT NULL, -- JSON string
        created_at TEXT NOT NULL,
        synced INTEGER DEFAULT 0,
        sync_attempts INTEGER DEFAULT 0,
        last_sync_attempt TEXT,
        error_message TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sync_metadata (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  // CRUD operations for cached data

  // Polls
  Future<List<Map<String, dynamic>>> getCachedPolls(int municipalityId) async {
    final db = await database;
    return await db.query(
      'cached_polls',
      where: 'municipality_id = ? AND status = ?',
      whereArgs: [municipalityId, 'active'],
      orderBy: 'created_at DESC',
    );
  }

  Future<void> cachePoll(Map<String, dynamic> poll) async {
    final db = await database;
    final pollData = Map<String, dynamic>.from(poll);
    pollData['cached_at'] = DateTime.now().toIso8601String();

    await db.insert(
      'cached_polls',
      pollData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> cachePollResponse(int pollId, Map<String, dynamic> response) async {
    final db = await database;
    await db.insert(
      'cached_poll_responses',
      {
        'poll_id': pollId,
        'response': response.toString(),
        'submitted_at': DateTime.now().toIso8601String(),
        'synced': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Announcements
  Future<List<Map<String, dynamic>>> getCachedAnnouncements(int municipalityId) async {
    final db = await database;
    return await db.query(
      'cached_announcements',
      where: 'municipality_id = ? AND status = ?',
      whereArgs: [municipalityId, 'published'],
      orderBy: 'priority DESC, published_at DESC',
    );
  }

  Future<void> cacheAnnouncement(Map<String, dynamic> announcement) async {
    final db = await database;
    final announcementData = Map<String, dynamic>.from(announcement);
    announcementData['cached_at'] = DateTime.now().toIso8601String();

    await db.insert(
      'cached_announcements',
      announcementData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Events
  Future<List<Map<String, dynamic>>> getCachedEvents(int municipalityId) async {
    final db = await database;
    return await db.query(
      'cached_events',
      where: 'municipality_id = ? AND status = ?',
      whereArgs: [municipalityId, 'published'],
      orderBy: 'starts_at ASC',
    );
  }

  Future<void> cacheEvent(Map<String, dynamic> event) async {
    final db = await database;
    final eventData = Map<String, dynamic>.from(event);
    eventData['cached_at'] = DateTime.now().toIso8601String();

    await db.insert(
      'cached_events',
      eventData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> cacheEventRsvp(int eventId, Map<String, dynamic> rsvp) async {
    final db = await database;
    await db.insert(
      'cached_event_rsvps',
      {
        'event_id': eventId,
        'status': rsvp['status'],
        'guests_count': rsvp['guests_count'] ?? 0,
        'rsvp_at': DateTime.now().toIso8601String(),
        'synced': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Feedback
  Future<void> cacheFeedback(Map<String, dynamic> feedback) async {
    final db = await database;
    await db.insert(
      'cached_feedback',
      {
        'municipality_id': feedback['municipality_id'],
        'category': feedback['category'],
        'message': feedback['message'],
        'photo_path': feedback['photo_path'],
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
        'synced': 0,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getFeedbackHistory() async {
    final db = await database;
    return await db.query(
      'feedback_history',
      orderBy: 'submitted_at DESC',
    );
  }

  // Payments
  Future<List<Map<String, dynamic>>> getCachedPayments() async {
    final db = await database;
    return await db.query(
      'cached_payments',
      orderBy: 'created_at DESC',
    );
  }

  Future<void> cachePayment(Map<String, dynamic> payment) async {
    final db = await database;
    final paymentData = Map<String, dynamic>.from(payment);
    paymentData['cached_at'] = DateTime.now().toIso8601String();

    await db.insert(
      'cached_payments',
      paymentData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Sync queue management
  Future<void> addToSyncQueue(String type, String action, Map<String, dynamic> data) async {
    final db = await database;
    final syncId = '${type}_${action}_${DateTime.now().millisecondsSinceEpoch}';

    await db.insert(
      'sync_queue',
      {
        'sync_id': syncId,
        'type': type,
        'action': action,
        'data': data.toString(),
        'created_at': DateTime.now().toIso8601String(),
        'synced': 0,
        'sync_attempts': 0,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getPendingSyncItems() async {
    final db = await database;
    return await db.query(
      'sync_queue',
      where: 'synced = ?',
      whereArgs: [0],
      orderBy: 'created_at ASC',
    );
  }

  Future<void> markSyncItemAsCompleted(String syncId) async {
    final db = await database;
    await db.update(
      'sync_queue',
      {
        'synced': 1,
        'last_sync_attempt': DateTime.now().toIso8601String(),
      },
      where: 'sync_id = ?',
      whereArgs: [syncId],
    );
  }

  Future<void> updateSyncItemError(String syncId, String error) async {
    final db = await database;
    await db.update(
      'sync_queue',
      {
        'sync_attempts': 'sync_attempts + 1',
        'last_sync_attempt': DateTime.now().toIso8601String(),
        'error_message': error,
      },
      where: 'sync_id = ?',
      whereArgs: [syncId],
    );
  }

  // Cache management
  Future<void> clearExpiredCache() async {
    final db = await database;
    final expireTime = DateTime.now().subtract(const Duration(hours: 24));
    final expireTimeString = expireTime.toIso8601String();

    await db.delete(
      'cached_polls',
      where: 'cached_at < ?',
      whereArgs: [expireTimeString],
    );

    await db.delete(
      'cached_announcements',
      where: 'cached_at < ?',
      whereArgs: [expireTimeString],
    );

    await db.delete(
      'cached_events',
      where: 'cached_at < ?',
      whereArgs: [expireTimeString],
    );

    await db.delete(
      'cached_payments',
      where: 'cached_at < ?',
      whereArgs: [expireTimeString],
    );
  }

  Future<void> clearAllCache() async {
    final db = await database;

    await db.delete('cached_polls');
    await db.delete('cached_announcements');
    await db.delete('cached_events');
    await db.delete('cached_payments');
    await db.delete('cached_feedback');
    await db.delete('sync_queue');
  }

  Future<Map<String, int>> getCacheStats() async {
    final db = await database;

    final pollsCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM cached_polls')) ?? 0;
    final announcementsCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM cached_announcements')) ?? 0;
    final eventsCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM cached_events')) ?? 0;
    final paymentsCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM cached_payments')) ?? 0;
    final pendingSyncCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM sync_queue WHERE synced = 0')) ?? 0;

    return {
      'polls': pollsCount,
      'announcements': announcementsCount,
      'events': eventsCount,
      'payments': paymentsCount,
      'pending_sync': pendingSyncCount,
    };
  }

  // Close database
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}