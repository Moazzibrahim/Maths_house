class Lesson {
  final String name;
  final int chapterId;

  Lesson({required this.name, required this.chapterId});

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        name: json['lesson_name'],
        chapterId: json['chapter_id'],
      );
}

class LessonsList {
  final List<dynamic> lessonsList;

  LessonsList({required this.lessonsList});

  factory LessonsList.fromJson(Map<String, dynamic> json) => LessonsList(
        lessonsList: json['lessons'],
      );
}
