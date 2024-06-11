class LessonSession {
  final int id;
  final String name;
  final String date;
  final String link;
  final String materialLink;
  final String from;
  final String to;
  final int lessonId;
  final int teacherId;
  final int groupId;
  final String type;
  final dynamic price;
  final dynamic accessDays;
  final dynamic repeat;
  final String createdAt;
  final String updatedAt;

  LessonSession({
    required this.id,
    required this.name,
    required this.date,
    required this.link,
    required this.materialLink,
    required this.from,
    required this.to,
    required this.lessonId,
    required this.teacherId,
    required this.groupId,
    required this.type,
    required this.price,
    required this.accessDays,
    required this.repeat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessonSession.fromJson(Map<String, dynamic> json) {
    return LessonSession(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      link: json['link'],
      materialLink: json['material_link'],
      from: json['from'],
      to: json['to'],
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

class LessonData {
  final String chapter;
  final String lessonSessions;
  final LessonSession sessionData;

  LessonData({
    required this.chapter,
    required this.lessonSessions,
    required this.sessionData,
  });

  factory LessonData.fromJson(Map<String, dynamic> json) {
    return LessonData(
      chapter: json['chapter'],
      lessonSessions: json['lessonSessions'],
      sessionData: LessonSession.fromJson(json['sessionData']),
    );
  }
}

class LiveRequest {
  final String success;
  final String category;
  final List<LessonData> liveRequest;

  LiveRequest({
    required this.success,
    required this.category,
    required this.liveRequest,
  });

  factory LiveRequest.fromJson(Map<String, dynamic> json) {
    return LiveRequest(
      success: json['success'],
      category: json['category'],
      liveRequest: List<LessonData>.from(
        json['liveRequest'].map(
          (lessonData) => LessonData.fromJson(lessonData),
        ),
      ),
    );
  }
}