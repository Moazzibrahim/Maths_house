class QuestionHistory {
  final int answer;
  final int month;
  final int year;
  final String section;
  final int id;

  QuestionHistory({
    required this.answer,
    required this.month,
    required this.year,
    required this.section,
    required this.id,
  });

  factory QuestionHistory.fromJson(Map<String, dynamic> json) =>
      QuestionHistory(
        answer: json['answer'],
        month: json['question']['month']?? 0,
        year: json['question']['year'] ?? 0,
        section: json['question']['section'] ?? 'no section',
        id: json['question_id'],
      );
}

class QuestionsHistoryList {
  final List<dynamic> questionsHistoryList;

  QuestionsHistoryList({required this.questionsHistoryList});

  factory QuestionsHistoryList.fromJson(Map<String, dynamic> json) =>
      QuestionsHistoryList(questionsHistoryList: json['question']);
}
