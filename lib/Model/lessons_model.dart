// ignore_for_file: avoid_function_literals_in_foreach_calls

class Lesson {
  final String name;
  final int chapterId;
  final int lessonId;
  final List<Videos> videos;
  Lesson(
      {required this.name, required this.chapterId, required this.videos,required this.lessonId});

  factory Lesson.fromJson(Map<String, dynamic> json) {
  List<Videos> videosList = [];
  
  if (json.containsKey('ideas')) {
    // Access the "ideas" list from the JSON data
    List<dynamic> ideas = json['ideas'];

    // Iterate over each idea and create Videos objects
    ideas.forEach((idea) {
      videosList.add(Videos.fromJson(idea));
    });
  }

  return Lesson(
    name: json['lesson_name'],
    chapterId: json['chapter_id'],
    lessonId: json['id'],
    videos: videosList,
  );
}

}

class LessonsList {
  final List<dynamic> lessonsList;

  LessonsList({required this.lessonsList});

  factory LessonsList.fromJson(Map<String, dynamic> json) => LessonsList(
        lessonsList: json['lessons'],
      );
}

class Videos {
  final String? videoName;
  final String? videoLink;

  Videos({required this.videoName, required this.videoLink});

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        videoName: json['idea'],
        videoLink: json['v_link'],
      );
}



