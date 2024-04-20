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
  final int id;
  final List<McqParallel> mcqParallelList;
  final List<McqParallelAnswer> mcqAnswerList;
  Parallel(
      {required this.question,
      required this.qUrl,
      required this.mcqParallelList,
      required this.id,
      required this.mcqAnswerList,
      });

  factory Parallel.fromJson(Map<String, dynamic> json) {
    List<McqParallel> mcqParallelList = [];
    List<McqParallelAnswer> mcqParallelAnswerList = [];
    if (json.containsKey('mcq')) {
      List<dynamic> mcqs = json['mcq'];
      mcqs.forEach((mcq) {
        mcqParallelList.add(McqParallel.fromJson(mcq));
      });
    }

    if (json.containsKey('g_ans')) {
      List<dynamic> mcqsAnswers = json['g_ans'];
      mcqsAnswers.forEach((ans) {
        mcqParallelAnswerList.add(McqParallelAnswer.fromJson(ans));
      });
    }
    return Parallel(
      question: json['question'],
      qUrl: json['q_url'],
      mcqParallelList: mcqParallelList, 
      id: json['id'],
      mcqAnswerList: mcqParallelAnswerList,
    );
  }
}

class ParallelList {
  final List<dynamic> parallelList;

  ParallelList({required this.parallelList});

  factory ParallelList.fromJson(Map<String, dynamic> json) => ParallelList(
        parallelList: json['parallel'],
      );
}

class McqParallel {
  final String text;
  final String answer;

  McqParallel({required this.text, required this.answer});

  factory McqParallel.fromJson(Map<String, dynamic> json) =>
      McqParallel(text: json['mcq_ans'], answer: json['mcq_answers']);
}

class McqParallelAnswer{
  final String mcqParallelAnswer;

  McqParallelAnswer({required this.mcqParallelAnswer});

  factory McqParallelAnswer.fromJson(Map<String,dynamic> json)=>
  McqParallelAnswer(mcqParallelAnswer: json['grid_ans']);
}
