class QuizHistory {
  final String date;
  final String courseName;
  final String chapterName;
  final String lessonName;
  final String quizName;
  final String time;
  final int score;
  final int questionCount;
  final int rightCount;
  final int wrongCount;
  final int id;

  QuizHistory(
      {required this.date,
      required this.courseName,
      required this.chapterName,
      required this.lessonName,
      required this.quizName,
      required this.time,
      required this.score,
      required this.questionCount,
      required this.rightCount,
      required this.wrongCount,
      required this.id});

  factory QuizHistory.fromJson(Map<String, dynamic> json) => QuizHistory(
        date: json['date'],
        courseName: json['quizze']['title'],
        chapterName: json['']??'',
        lessonName: json[''],
        quizName: json[''],
        time: json['time'],
        score: json['score'],
        questionCount: json[''],
        rightCount: json[''],
        wrongCount: json[''],
        id: json[''],
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
