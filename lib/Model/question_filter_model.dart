class Question {
  final String question;
  final String qUrl;
  final List<Mcq> mcqList;

  Question({
    required this.question,
    required this.qUrl,
    required this.mcqList,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<Mcq> mcqList = [];

      if (json.containsKey('mcq')) {
      List<dynamic> mcqs = json['mcq'];
      mcqs.forEach((mcq) {
        mcqList.add(Mcq.fromJson(mcq));
      });
    }
    return Question(
      question: json['question']??'',
      qUrl: json['q_url']??'',
      mcqList: mcqList,
    );
  }
}

class QuestionsList {
  final List<dynamic> questionsList;

  QuestionsList({required this.questionsList});

  factory QuestionsList.fromJson(Map<String, dynamic> json) =>
      QuestionsList(questionsList: json['q_items']);
}

class Mcq {
  final String text;
  final String answer;

  Mcq({required this.text, required this.answer});

  factory Mcq.fromJson(Map<String, dynamic> json) =>
      Mcq(text: json['mcq_ans'], answer: json['mcq_answers']);
}
