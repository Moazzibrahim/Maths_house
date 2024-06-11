class ApiResponse {
  final String? success;
  final String? category;
  final List<List<LiveRequest>> liveRequest;

  ApiResponse({
    required this.success,
    required this.category,
    required this.liveRequest,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      category: json['category'],
      liveRequest: (json['liveRequest'] as List)
          .map((i) => (i as List).map((j) => LiveRequest.fromJson(j)).toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'category': category,
      'liveRequest':
          liveRequest.map((i) => i.map((j) => j.toJson()).toList()).toList(),
    };
  }
}

class LiveRequest {
  final String? chapter;
  final String? lessonSessions;
  final SessionData sessionData;

  LiveRequest({
    required this.chapter,
    required this.lessonSessions,
    required this.sessionData,
  });

  factory LiveRequest.fromJson(Map<String, dynamic> json) {
    return LiveRequest(
      chapter: json['chapter'],
      lessonSessions: json['lessonSessions'],
      sessionData: SessionData.fromJson(json['sessionData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter': chapter,
      'lessonSessions': lessonSessions,
      'sessionData': sessionData.toJson(),
    };
  }
}

class SessionData {
  final int? id;
  final String? name;
  final String? date;
  final String? link;
  final String? materialLink;
  final String? from;
  final String? to;
  final dynamic duration;
  final int? lessonId;
  final int? teacherId;
  final int? groupId;
  final String? type;
  final dynamic price;
  final dynamic accessDayes;
  final dynamic repeat;
  final String? createdAt;
  final String? updatedAt;

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
    this.accessDayes,
    this.repeat,
    this.createdAt,
    this.updatedAt,
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
      accessDayes: json['access_dayes'],
      repeat: json['repeat'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'link': link,
      'material_link': materialLink,
      'from': from,
      'to': to,
      'duration': duration,
      'lesson_id': lessonId,
      'teacher_id': teacherId,
      'group_id': groupId,
      'type': type,
      'price': price,
      'access_dayes': accessDayes,
      'repeat': repeat,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
