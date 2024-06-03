class ExamMcq {
  ExamQuestion exam;

  ExamMcq({required this.exam});

  factory ExamMcq.fromJson(Map<String, dynamic> json) {
    return ExamMcq(
      exam: ExamQuestion.fromJson(json['exam']['questionExam']),
    );
  }
}

class ExamQuestion {
  Question question;
  List<Answer> answers;

  ExamQuestion({required this.question, required this.answers});

  factory ExamQuestion.fromJson(Map<String, dynamic> json) {
    return ExamQuestion(
      question: Question.fromJson(json['question']),
      answers: (json['Answers'] as List)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
    );
  }
}

class Question {
  final int? id;
  int lessonId;
  String? questionText;
  String state;
  String? qUrl;
  String qCode;
  String qType;
  final int? month;
  String qNum;
  final int? year;
  String section;
  String difficulty;
  String ansType;
  String updatedAt;
  String createdAt;

  Question({
    this.id,
    required this.lessonId,
    this.questionText,
    required this.state,
    this.qUrl,
    required this.qCode,
    required this.qType,
    this.month,
    required this.qNum,
    this.year,
    required this.section,
    required this.difficulty,
    required this.ansType,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      lessonId: json['lesson_id'],
      questionText: json['question'] ?? "",
      state: json['state'],
      qUrl: json['q_url'] ?? "",
      qCode: json['q_code'],
      qType: json['q_type'],
      month: json['month'],
      qNum: json['q_num'],
      year: json['year'],
      section: json['section'],
      difficulty: json['difficulty'],
      ansType: json['ans_type'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}

class Answer {
  final int? id;
  final String? mcqAns;
  final String? mcqAnswers;
  final String? mcqnum;
  final int? qId;
  String createdAt;
  String updatedAt;

  Answer({
    this.id,
    this.mcqAns,
    this.mcqnum,
    this.mcqAnswers,
    this.qId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      mcqAns: json['mcq_ans'] ?? "",
      mcqnum: json['mcq_num'] ?? "",
      mcqAnswers: json['mcq_answers'],
      qId: json['q_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class QuestionWithAnswers {
  final Question? question;
  final List<Question> questiondata;
  final List<Answer> answers;
  final List<String> mcqOptions;
  int? selectedSolutionIndex;

  QuestionWithAnswers({
    this.question,
    required this.questiondata,
    required this.answers,
    required this.mcqOptions,
    this.selectedSolutionIndex,
  });
}
