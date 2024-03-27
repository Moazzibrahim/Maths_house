class Chapter {
  final String name;
  final int courseId;

  Chapter({required this.name, required this.courseId});

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        name: json['chapter_name'],
        courseId: json['course_id'],
      );
}

class ChaptersList {
  final List<dynamic> chaptersList;

  ChaptersList({required this.chaptersList});

  factory ChaptersList.fromJson(Map<String, dynamic> json) => ChaptersList(
        chaptersList: json['chapters'],
      );
}
