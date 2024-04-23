class QuizHistory {
  final String date;
  final String courseName;
  final String chapterName;
  final String lessonName;
  final String quizName;
  final String time;
  final int score;
  final List<dynamic> questions;
  final int rightCount;
  final int id;

  QuizHistory(
      {required this.date,
      required this.courseName,
      required this.chapterName,
      required this.lessonName,
      required this.quizName,
      required this.time,
      required this.score,
      required this.questions,
      required this.rightCount,
      required this.id});

  factory QuizHistory.fromJson(Map<String, dynamic> json) => QuizHistory(
        date: json['date'],
        courseName: json['lesson_api']['chapter_api']['course']['course_name']??'no course',
        chapterName: json['lesson_api']['chapter_api']['chapter_name']??'no chapter',
        lessonName: json['lesson_api']['lesson_name']??'no lesson',
        quizName: json['quizze']['title'],
        time: json['time'],
        score: json['quizze']['score'],
        questions: json['questions']??[],
        rightCount: json['r_questions']??0,
        id: json['quizze_id'],
      );
}

class QuizHistoryList {
  final List<dynamic> quizHistoryList;

  QuizHistoryList({required this.quizHistoryList});

  factory QuizHistoryList.fromJson(Map<String, dynamic> json) =>
      QuizHistoryList(
        quizHistoryList: json['quiz_history'],
      );
}
