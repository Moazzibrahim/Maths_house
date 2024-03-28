class Chapter {
  final String name;
  final int courseId;
  final int id;

  Chapter({required this.name, required this.courseId,required this.id});

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        name: json['chapter_name'],
        courseId: json['course_id'], 
        id: json['id'],
      );
}

class ChaptersList {
  final List<dynamic> chaptersList;

  ChaptersList({required this.chaptersList});

  factory ChaptersList.fromJson(Map<String, dynamic> json) => ChaptersList(
        chaptersList: json['chapters'],
      );
}
