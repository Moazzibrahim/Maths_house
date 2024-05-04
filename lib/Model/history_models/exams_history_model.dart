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
        id: json['exam_id'] ?? 0,
        score: json['exams']['score'] ?? 0,
        examName: json['exams']['title'] ?? 'no title',
        date: json['date'] ?? 'no title',
      );
}

class ExamHistoryList {
  final List<dynamic> examHistoryList;

  ExamHistoryList({required this.examHistoryList});

  factory ExamHistoryList.fromJson(Map<String, dynamic> json) =>
      ExamHistoryList(examHistoryList: json['exam']);
}

class ExamViewMistake {
  final String question;
  final String qUrl;
  final int qId;

  ExamViewMistake({required this.question, required this.qUrl,required this.qId});

  factory ExamViewMistake.fromJson(Map<String, dynamic> json) =>
      ExamViewMistake(
        question: json['question']['question']??'no question',
        qUrl: json['question']['q_url']?? 'no url',
        qId: json['question_id']
      );
}

class ExamViewMistakesList {
  final List<dynamic> examViewMistakeList;

  ExamViewMistakesList({required this.examViewMistakeList});

  factory ExamViewMistakesList.fromJson(Map<String, dynamic> json) =>
      ExamViewMistakesList(
        examViewMistakeList: json['questions'],
      );
}
