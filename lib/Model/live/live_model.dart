import 'package:flutter/material.dart';

class SessionResponse with ChangeNotifier {
  List<Session> sessions;

  SessionResponse({required this.sessions});

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    var sessionList = json['sessions'] as List;
    List<Session> sessions =
        sessionList.map((session) => Session.fromJson(session)).toList();

    return SessionResponse(sessions: sessions);
  }
}

class Session {
  int? id;
  int? sessionId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  SessionData session;

  Session({
    required this.id,
    required this.sessionId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.session,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      sessionId: json['session_id'],
      userId: json['user_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      session: SessionData.fromJson(json['session']),
    );
  }
}

class SessionData {
  int? id;
  String? name;
  DateTime? date;
  String? link;
  String? materialLink;
  String? from;
  String? to;
  int? duration;
  int? lessonId;
  int? teacherId;
  int? groupId;
  String? type;
  int? price;
  int? accessDays;
  String? repeat;
  DateTime? createdAt;
  DateTime? updatedAt;

  SessionData({
    this.id,
    this.name,
    this.date,
    this.link,
    this.materialLink,
    this.from,
    this.to,
    this.duration,
    this.lessonId,
    this.teacherId,
    this.groupId,
    this.type,
    this.price,
    this.accessDays,
    this.repeat,
    this.createdAt,
    this.updatedAt,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
      id: json['id'],
      name: json['name'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      link: json['link'] ?? '',
      materialLink: json['material_link'],
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      duration: json['duration'],
      lessonId: json['lesson_id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      groupId: json['group_id'] ?? 0,
      type: json['type'] ?? '',
      price: json['price'],
      accessDays: json['access_dayes'],
      repeat: json['repeat'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
