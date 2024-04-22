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
        id: json['exam_id']??0,
        score: json['exams']['score']??0,
        examName: json['exams']['title']?? 'no title',
        date: json['date']?? 'no title',
      );
}

class ExamHistoryList{
final List<dynamic> examHistoryList;

  ExamHistoryList({required this.examHistoryList});

  factory ExamHistoryList.fromJson(Map<String,dynamic> json)=>
  ExamHistoryList(examHistoryList: json['exam']);
}


