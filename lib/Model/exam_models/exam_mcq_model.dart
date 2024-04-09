class ExamMcq {
  List<ExamQuestion> exam;

  ExamMcq({required this.exam});

  factory ExamMcq.fromJson(Map<String, dynamic> json) {
    List<dynamic> examList = json['exam'];
    List<ExamQuestion> examQuestions = examList
        .map((question) => ExamQuestion.fromJson(question))
        .toList();
    return ExamMcq(exam: examQuestions);
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
  int id;
  int lessonId;
  String? questionText;
  String state;
  String? qUrl;
  String qCode;
  String qType;
  int month;
  String qNum;
  int year;
  String section;
  String difficulty;
  String ansType;
  String updatedAt;

  Question(
      {required this.id,
      required this.lessonId,
      this.questionText,
      required this.state,
      this.qUrl,
      required this.qCode,
      required this.qType,
      required this.month,
      required this.qNum,
      required this.year,
      required this.section,
      required this.difficulty,
      required this.ansType,
      required this.updatedAt});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      lessonId: json['lesson_id'],
      questionText: json['question'],
      state: json['state'],
      qUrl: json['q_url'],
      qCode: json['q_code'],
      qType: json['q_type'],
      month: json['month'],
      qNum: json['q_num'],
      year: json['year'],
      section: json['section'],
      difficulty: json['difficulty'],
      ansType: json['ans_type'],
      updatedAt: json['updated_at'],
    );
  }
}

class Answer {
  int id;
  String mcqAns;
  String mcqAnswers;
  int qId;
  String createdAt;
  String updatedAt;

  Answer(
      {required this.id,
      required this.mcqAns,
      required this.mcqAnswers,
      required this.qId,
      required this.createdAt,
      required this.updatedAt});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      mcqAns: json['mcq_ans'],
      mcqAnswers: json['mcq_answers'],
      qId: json['q_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
