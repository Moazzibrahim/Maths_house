class DataModel {
  int totalScore;
  int passScore;
  int grade;
  List<Chapter> chapters;

  DataModel({
    required this.totalScore,
    required this.passScore,
    required this.grade,
    required this.chapters,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      totalScore: json['total_score'],
      passScore: json['pass_score'],
      grade: json['grade'],
      chapters: (json['chapters'] as List<dynamic>)
          .map((chapterJson) => Chapter.fromJson(chapterJson))
          .toList(),
    );
  }
}

class Chapter {
  int id;
  int lessonId;
  String question;
  String state;
  String qUrl;
  String qCode;
  String qType;
  int month;
  String qNum;
  int year;
  String section;
  String difficulty;
  String ansType;
  String updatedAt;
  String createdAt;
  ApiLesson apiLesson;

  Chapter({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.state,
    required this.qUrl,
    required this.qCode,
    required this.qType,
    required this.month,
    required this.qNum,
    required this.year,
    required this.section,
    required this.difficulty,
    required this.ansType,
    required this.updatedAt,
    required this.createdAt,
    required this.apiLesson,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      lessonId: json['lesson_id'],
      question: json['question'],
      state: json['state'],
      qUrl: json['q_url'],
      qCode: json['q_code'],
      qType: json['q_type'],
      month: json['month'],
      qNum: json['q_num'],
      year: json['year'],
      section: json['section'],
      difficulty: json['difficulty'],
      ansType: json['ans_type'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      apiLesson: ApiLesson.fromJson(json['api_lesson']),
    );
  }
}

class ApiLesson {
  int id;
  String lessonName;
  int chapterId;
  int teacherId;
  String lessonDes;
  String lessonUrl;
  String preRequisition;
  String gain;
  String createdAt;
  String updatedAt;
  ApiChapter apiChapter;

  ApiLesson({
    required this.id,
    required this.lessonName,
    required this.chapterId,
    required this.teacherId,
    required this.lessonDes,
    required this.lessonUrl,
    required this.preRequisition,
    required this.gain,
    required this.createdAt,
    required this.updatedAt,
    required this.apiChapter,
  });

  factory ApiLesson.fromJson(Map<String, dynamic> json) {
    return ApiLesson(
      id: json['id'],
      lessonName: json['lesson_name'],
      chapterId: json['chapter_id'],
      teacherId: json['teacher_id'],
      lessonDes: json['lesson_des'],
      lessonUrl: json['lesson_url'],
      preRequisition: json['pre_requisition'],
      gain: json['gain'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      apiChapter: ApiChapter.fromJson(json['api_chapter']),
    );
  }
}

class ApiChapter {
  int id;
  String chapterName;
  int courseId;
  String chDes;
  String chUrl;
  String preRequisition;
  String gain;
  int teacherId;
  String? createdAt;
  String updatedAt;
  String type;
  List<Price> price;

  ApiChapter({
    required this.id,
    required this.chapterName,
    required this.courseId,
    required this.chDes,
    required this.chUrl,
    required this.preRequisition,
    required this.gain,
    required this.teacherId,
    this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.price,
  });

  factory ApiChapter.fromJson(Map<String, dynamic> json) {
    return ApiChapter(
      id: json['id'],
      chapterName: json['chapter_name'],
      courseId: json['course_id'],
      chDes: json['ch_des'],
      chUrl: json['ch_url'],
      preRequisition: json['pre_requisition'],
      gain: json['gain'],
      teacherId: json['teacher_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type'],
      price: (json['price'] as List<dynamic>)
          .map((priceJson) => Price.fromJson(priceJson))
          .toList(),
    );
  }
}

class Price {
  int id;
  int duration;
  double price;
  int discount;
  int chapterId;
  String createdAt;
  String updatedAt;

  Price({
    required this.id,
    required this.duration,
    required this.price,
    required this.discount,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      duration: json['duration'],
      price: json['price'],
      discount: json['discount'],
      chapterId: json['chapter_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
