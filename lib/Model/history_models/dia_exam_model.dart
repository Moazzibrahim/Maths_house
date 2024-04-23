class DiaExamHistory {
  final String examTitle;
  final String date;
  final int id;
  final int score;

  DiaExamHistory({
    required this.examTitle,
    required this.date,
    required this.id,
    required this.score,
  });

  factory DiaExamHistory.fromJson(Map<String, dynamic> json) => DiaExamHistory(
        examTitle: json['exams']['title']??'no title',
        date: json['date']??'no date',
        id: json['diagnostic_exams_id'],
        score: json['exams']['score'],
      );
}

class DiaExamHistoryList {
  final List<dynamic> diaExamList;

  DiaExamHistoryList({required this.diaExamList});

  factory DiaExamHistoryList.fromJson(Map<String, dynamic> json) => DiaExamHistoryList(
        diaExamList: json['dia_exam'],
      );
}
