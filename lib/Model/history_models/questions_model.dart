class QuestionHistory {
  final int answer;
  final int month;
  final int year;
  final String section;

  QuestionHistory({
    required this.answer,
    required this.month,
    required this.year,
    required this.section,
  });

  factory QuestionHistory.fromJson(Map<String, dynamic> json) =>
      QuestionHistory(
        answer: json['answer']?? 30,
        month: json['question']['month']??30,
        year: json['question']['year']??30,
        section: json['question']['section']??'nullo',
      );
}


class QuestionsHistoryList{
  final List<dynamic> questionsHistoryList;

  QuestionsHistoryList({required this.questionsHistoryList});

  factory QuestionsHistoryList.fromJson(Map<String,dynamic> json)=>
  QuestionsHistoryList(questionsHistoryList: json['question']??[]);
}