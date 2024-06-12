// ignore_for_file: avoid_function_literals_in_foreach_calls

class Question {
  final String? question;
  final String? qUrl;
  final String? section;
  final int? month;
  final String? questionNum;
  final int? year;
  final String? examCode;
  final int? qId;
  final List<Mcq> mcqList;
  final List<McqAnswer> mcqAnswerList;

  Question(
      {required this.question,
      required this.qId,
      required this.qUrl,
      required this.mcqList,
      required this.section,
      required this.month,
      required this.questionNum,
      required this.year,
      required this.examCode,
      required this.mcqAnswerList});

  factory Question.fromJson(Map<String, dynamic> json) {
    List<Mcq> mcqList = [];
    List<McqAnswer> mcqAnswerList = [];

    if (json.containsKey('mcq')) {
      List<dynamic> mcqs = json['mcq'];
      mcqs.forEach((mcq) {
        mcqList.add(Mcq.fromJson(mcq));
      });
    }

    if (json.containsKey('g_ans')) {
      List<dynamic> mcqsAnswers = json['g_ans'];
      mcqsAnswers.forEach((ans) {
        mcqAnswerList.add(McqAnswer.fromJson(ans));
      });
    }

    return Question(
      qId: json['id'] ?? '',
      question: json['question'] ?? '',
      qUrl: json['q_url'] ?? '',
      mcqList: mcqList,
      section: json['section'],
      month: json['month'],
      questionNum: json['q_num'],
      year: json['year'],
      examCode: json['q_code'],
      mcqAnswerList: mcqAnswerList,
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
  final String? text;
  final String? answer;

  Mcq({required this.text, required this.answer});

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        text: json['mcq_num'] ?? '',
        answer: json['mcq_answers']?? '',
      );
}

class McqAnswer {
  final String mcqAnswer;

  McqAnswer({required this.mcqAnswer});

  factory McqAnswer.fromJson(Map<String, dynamic> json) =>
      McqAnswer(mcqAnswer: json['grid_ans']);
}
