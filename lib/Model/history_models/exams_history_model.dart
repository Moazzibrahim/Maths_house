class ExamHistory {
  final int id;
  final int score;
  final String examName;
  final String date;

  ExamHistory({
    required this.id,
    required this.score,
    required this.examName,
    required this.date,
  });

  factory ExamHistory.fromJson(Map<String, dynamic> json) => ExamHistory(
        id: json['exam_id'],
        score: json['score'],
        examName: json['title'],
        date: json['date'],
      );
}

class ExamHistoryList{
final List<dynamic> examHistoryList;

  ExamHistoryList({required this.examHistoryList});

  factory ExamHistoryList.fromJson(Map<String,dynamic> json)=>
  ExamHistoryList(examHistoryList: json['exam']);
}


