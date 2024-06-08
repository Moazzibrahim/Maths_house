class LiveFilter {
  final int catId;
  final String cateName;
  final String cateUrl;
  final int teacherId;
  final List<CourseLive> courseLiveList;

  LiveFilter(
      {required this.catId,
      required this.cateName,
      required this.cateUrl,
      required this.teacherId,
      required this.courseLiveList});

  factory LiveFilter.fromJson(Map<String, dynamic> json) {
    List<CourseLive> cl = [];
    for (var e in json['courses_live']) {
      cl.add(CourseLive.fromJson(e));
    }
    return LiveFilter(
      catId: json['id'],
      cateName: json['cate_name'],
      cateUrl: json['cate_url'],
      teacherId: json['teacher_id'],
      courseLiveList: cl,
    );
  }
}

class CourseLive {
  final int id;
  final String courseName;
  final String courseUrl;
  final String type;
  final List<ChapterLive> chapterLiveList;

  CourseLive(
      {required this.id,
      required this.courseName,
      required this.courseUrl,
      required this.type,
      required this.chapterLiveList});

  factory CourseLive.fromJson(Map<String, dynamic> json) {
    List<ChapterLive> chl = [];
    for (var e in json['chapter']) {
      chl.add(ChapterLive.fromJson(e));
    }
    return CourseLive(
      id: json['id'],
      courseName: json['course_name'],
      courseUrl: json['course_url'],
      type: json['type'],
      chapterLiveList: chl,
    );
  }
}

class ChapterLive {
  final int id;
  final String chapterName;
  final String chapterUrl;
  final List<LessonLive> lessonLiveList;

  ChapterLive(
      {required this.id,
      required this.chapterName,
      required this.chapterUrl,
      required this.lessonLiveList});

  factory ChapterLive.fromJson(Map<String, dynamic> json) {
    List<LessonLive> lll = [];
    for (var e in json['lessons']) {
      lll.add(LessonLive.fromJson(e));
    }
    return ChapterLive(
        id: json['id'],
        chapterName: json['chapter_name'],
        chapterUrl: json['ch_url'],
        lessonLiveList: lll);
  }
}

class LessonLive {
  final int id;
  final String lessonName;
  final String lessonrUrl;
  final List<SessionLive> sessionLiveList;
  LessonLive(
      {required this.id, required this.lessonName, required this.lessonrUrl,required this.sessionLiveList});

  factory LessonLive.fromJson(Map<String, dynamic> json) {
    List<SessionLive> sll = [];
    for(var e in json['sessions']){
      sll.add(SessionLive.fromJson(e));
    }
    return LessonLive(
      id: json['id'],
      lessonName: json['lesson_name'],
      lessonrUrl: json['lesson_url'],
      sessionLiveList: sll
    );
  }
}

class SessionLive {
  final String sessionName;
  final String date;
  final String dateFrom;
  final String dateTo;
  final int id;

  SessionLive(
      {required this.sessionName,
      required this.date,
      required this.dateFrom,
      required this.dateTo,
      required this.id});

  factory SessionLive.fromJson(Map<String, dynamic> json) {
    return SessionLive(
      sessionName: json['name'],
      date: json['date'],
      dateFrom: json['from'],
      dateTo: json['to'],
      id: json['id'],
    );
  }
}
