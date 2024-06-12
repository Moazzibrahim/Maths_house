import 'dart:convert';



List<MyLiveSession> myLiveSessionFromJson(String str) => List<MyLiveSession>.from(json.decode(str)["myLiveSession"].map((x) => MyLiveSession.fromJson(x)));

String myLiveSessionToJson(List<MyLiveSession> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyLiveSession {
    MyLiveSession({
        this.id,
        this.userId,
        this.sessionId,
        this.createdAt,
        this.updatedAt,
        this.session,
    });

    int? id;
    int? userId;
    int? sessionId;
    dynamic createdAt;
    dynamic updatedAt;
    Session? session;

    factory MyLiveSession.fromJson(Map<String, dynamic> json) => MyLiveSession(
        id: json["id"],
        userId: json["user_id"],
        sessionId: json["session_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        session: Session.fromJson(json["session"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "session_id": sessionId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "session": session!.toJson(),
    };
}

class Session {
    Session({
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
        this.lesson,
    });

    int? id;
    String? name;
    DateTime? date;
    String? link;
    String? materialLink;
    String? from;
    String? to;
    dynamic duration;
    int? lessonId;
    int? teacherId;
    int? groupId;
    String? type;
    dynamic price;
    dynamic accessDayes;
    dynamic repeat;
    DateTime? createdAt;
    DateTime? updatedAt;
    Lesson? lesson;

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        materialLink: json["material_link"],
        from: json["from"],
        to: json["to"],
        duration: json["duration"],
        lessonId: json["lesson_id"],
        teacherId: json["teacher_id"],
        groupId: json["group_id"],
        type: json["type"],
        price: json["price"],
        accessDayes: json["access_dayes"],
        repeat: json["repeat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lesson: Lesson.fromJson(json["lesson"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date!.toIso8601String(),
        "link": link,
        "material_link": materialLink,
        "from": from,
        "to": to,
        "duration": duration,
        "lesson_id": lessonId,
        "teacher_id": teacherId,
        "group_id": groupId,
        "type": type,
        "price": price,
        "access_dayes": accessDayes,
        "repeat": repeat,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "lesson": lesson!.toJson(),
    };
}

class Lesson {
    Lesson({
        this.id,
        this.lessonName,
        this.chapterId,
        this.teacherId,
        this.lessonDes,
        this.lessonUrl,
        this.preRequisition,
        this.gain,
        this.createdAt,
        this.updatedAt,
        this.chapterMyLive,
        this.ideas,
    });

    int? id;
    String? lessonName;
    int? chapterId;
    int? teacherId;
    String? lessonDes;
    String? lessonUrl;
    String? preRequisition;
    String? gain;
    DateTime? createdAt;
    DateTime? updatedAt;
    ChapterMyLive? chapterMyLive;
    List<Idea>? ideas;

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        lessonName: json["lesson_name"],
        chapterId: json["chapter_id"],
        teacherId: json["teacher_id"],
        lessonDes: json["lesson_des"],
        lessonUrl: json["lesson_url"],
        preRequisition: json["pre_requisition"],
        gain: json["gain"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chapterMyLive: ChapterMyLive.fromJson(json["chapter_my_live"]),
        ideas: List<Idea>.from(json["ideas"].map((x) => Idea.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_name": lessonName,
        "chapter_id": chapterId,
        "teacher_id": teacherId,
        "lesson_des": lessonDes,
        "lesson_url": lessonUrl,
        "pre_requisition": preRequisition,
        "gain": gain,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "chapter_my_live": chapterMyLive!.toJson(),
        "ideas": List<dynamic>.from(ideas!.map((x) => x.toJson())),
    };
}

class ChapterMyLive {
    ChapterMyLive({
        this.id,
        this.chapterName,
        this.courseId,
        this.chDes,
        this.chUrl,
        this.preRequisition,
        this.gain,
        this.teacherId,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.course,
    });

    int? id;
    String? chapterName;
    int? courseId;
    String? chDes;
    String? chUrl;
    String? preRequisition;
    String? gain;
    int? teacherId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? type;
    Course? course;

    factory ChapterMyLive.fromJson(Map<String, dynamic> json) => ChapterMyLive(
        id: json["id"],
        chapterName: json["chapter_name"],
        courseId: json["course_id"],
        chDes: json["ch_des"],
        chUrl: json["ch_url"],
        preRequisition: json["pre_requisition"],
        gain: json["gain"],
        teacherId: json["teacher_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        course: Course.fromJson(json["course"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_name": chapterName,
        "course_id": courseId,
        "ch_des": chDes,
        "ch_url": chUrl,
        "pre_requisition": preRequisition,
        "gain": gain,
        "teacher_id": teacherId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "type": type,
        "course": course!.toJson(),
    };
}

class Course {
    Course({
        this.id,
        this.courseName,
        this.categoryId,
        this.courseDes,
        this.courseUrl,
        this.preRequisition,
        this.gain,
        this.createdAt,
        this.updatedAt,
        this.teacherId,
        this.userId,
        this.type,
    });

    int? id;
    String? courseName;
    int? categoryId;
    String? courseDes;
    String? courseUrl;
    dynamic preRequisition;
    dynamic gain;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? teacherId;
    dynamic userId;
    String? type;

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseName: json["course_name"],
        categoryId: json["category_id"],
        courseDes: json["course_des"],
        courseUrl: json["course_url"],
        preRequisition: json["pre_requisition"],
        gain: json["gain"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        teacherId: json["teacher_id"],
        userId: json["user_id"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course_name": courseName,
        "category_id": categoryId,
        "course_des": courseDes,
        "course_url": courseUrl,
        "pre_requisition": preRequisition,
        "gain": gain,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "teacher_id": teacherId,
        "user_id": userId,
        "type": type,
    };
}

class Idea {
    Idea({
        this.id,
        this.idea,
        this.syllabus,
        this.ideaOrder,
        this.pdf,
        this.vLink,
        this.lessonId,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    dynamic idea;
    dynamic syllabus;
    dynamic ideaOrder;
    String? pdf;
    dynamic vLink;
    int? lessonId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Idea.fromJson(Map<String, dynamic> json) => Idea(
        id: json["id"],
        idea: json["idea"],
        syllabus: json["syllabus"],
        ideaOrder: json["idea_order"],
        pdf: json["pdf"],
        vLink: json["v_link"],
        lessonId: json["lesson_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idea": idea,
        "syllabus": syllabus,
        "idea_order": ideaOrder,
        "pdf": pdf,
        "v_link": vLink,
        "lesson_id": lessonId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
