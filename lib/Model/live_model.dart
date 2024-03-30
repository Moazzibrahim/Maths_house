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
  int id;
  int sessionId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      session: SessionData.fromJson(json['session']),
    );
  }
}

class SessionData {
  int id;
  String name;
  DateTime date;
  String link;
  String? materialLink;
  String from;
  String to;
  int duration;
  int lessonId;
  int teacherId;
  int groupId;
  String type;
  int? price;
  int? accessDays;
  String repeat;
  DateTime createdAt;
  DateTime updatedAt;

  SessionData({
    required this.id,
    required this.name,
    required this.date,
    required this.link,
    this.materialLink,
    required this.from,
    required this.to,
    required this.duration,
    required this.lessonId,
    required this.teacherId,
    required this.groupId,
    required this.type,
    this.price,
    this.accessDays,
    required this.repeat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      link: json['link'],
      materialLink: json['material_link'],
      from: json['from'],
      to: json['to'],
      duration: json['duration'],
      lessonId: json['lesson_id'],
      teacherId: json['teacher_id'],
      groupId: json['group_id'],
      type: json['type'],
      price: json['price'],
      accessDays: json['access_days'],
      repeat: json['repeat'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
