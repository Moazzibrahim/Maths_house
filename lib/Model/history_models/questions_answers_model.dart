class QuestionAnswer {
  final String answerPdf;
  final String answerVid;

  QuestionAnswer({required this.answerPdf, required this.answerVid});

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        answerPdf: json['ans_pdf'],
        answerVid: json['ans_video'],
      );
}

class QuestionAnswerList {
  final List<dynamic> questionAnswerList;

  QuestionAnswerList({required this.questionAnswerList});

  factory QuestionAnswerList.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerList(
        questionAnswerList: json['question_ans'],
      );
}

class Parallel {
  final String question;
  final String? qUrl;

  Parallel({required this.question, required this.qUrl});

  factory Parallel.fromJson(Map<String, dynamic> json) => Parallel(
        question: json['question'],
        qUrl: json['q_url'],
      );
}

class ParallelList {
  final List<dynamic> parallelList;

  ParallelList({required this.parallelList});

  factory ParallelList.fromJson(Map<String, dynamic> json) => ParallelList(
        parallelList: json['parallel'],
      );
}
