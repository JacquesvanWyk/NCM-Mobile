class NotificationModel {
  final String id;
  final String type;
  final Map<String, dynamic> data;
  final DateTime? readAt;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.data,
    this.readAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>? ?? {},
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'data': data,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isRead => readAt != null;

  String get title => data['title'] as String? ?? 'Notification';
  String get body => data['body'] as String? ?? '';
  String? get icon => data['icon'] as String?;
  String? get clickAction => data['click_action'] as String?;

  NotificationModel copyWith({
    String? id,
    String? type,
    Map<String, dynamic>? data,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      data: data ?? this.data,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PushNotificationStats {
  final int totalSent;
  final int totalFailed;
  final int recentCount;
  final double successRate;

  PushNotificationStats({
    required this.totalSent,
    required this.totalFailed,
    required this.recentCount,
    required this.successRate,
  });

  factory PushNotificationStats.fromJson(Map<String, dynamic> json) {
    return PushNotificationStats(
      totalSent: json['total_sent'] as int? ?? 0,
      totalFailed: json['total_failed'] as int? ?? 0,
      recentCount: json['recent_count'] as int? ?? 0,
      successRate: (json['success_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
