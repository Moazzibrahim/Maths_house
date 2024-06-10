class Category {
  final String success;
  final List<Chapter> liveRequest;

  Category({required this.success, required this.liveRequest});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      success: json['success'],
      liveRequest: (json['liveRequest'] as List)
          .map((chapter) => Chapter.fromJson(chapter))
          .toList(),
    );
  }
}

class Chapter {
  final String chapter;
  final String lessonSessions;
  final List<SessionData> sessionData;

  Chapter({required this.chapter, required this.lessonSessions, required this.sessionData});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapter: json['chapter'],
      lessonSessions: json['lessonSessions'],
      sessionData: (json['sessionData'] as List)
          .map((session) => SessionData.fromJson(session))
          .toList(),
    );
  }
}

class SessionData {
  final int id;
  final String name;
  final String date;
  final String link;
  final String? materialLink;
  final String from;
  final String to;
  final int duration;
  final int lessonId;
  final int teacherId;
  final int? groupId;
  final String type;
  final int price;
  final int accessDays;
  final String repeat;
  final String createdAt;
  final String updatedAt;

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
    this.groupId,
    required this.type,
    required this.price,
    required this.accessDays,
    required this.repeat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
      id: json['id'],
      name: json['name'],
      date: json['date'],
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
