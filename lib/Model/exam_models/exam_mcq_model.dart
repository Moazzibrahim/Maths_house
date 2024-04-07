class ExamApiResponse {
  final List<ExamData> exam;

  ExamApiResponse({required this.exam});

  factory ExamApiResponse.fromJson(Map<String, dynamic> json) {
    return ExamApiResponse(
      exam: List<ExamData>.from(json['exam'].map((x) => ExamData.fromJson(x))),
    );
  }
}

class ExamData {
  final Question question;
  final List<Answer> answers;

  ExamData({required this.question, required this.answers});

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      question: Question.fromJson(json['question']),
      answers: List<Answer>.from(json['Answers'].map((x) => Answer.fromJson(x))),
    );
  }
}

class Question {
  final int id;
  final int lessonId;
  final String questionText;
  final String state;
  final String questionUrl;
  final String questionCode;
  final String questionType;
  final int month;
  final String questionNumber;
  final int year;
  final String section;
  final String difficulty;
  final String answerType;
  final String updatedAt;
  final dynamic createdAt;

  Question({
    required this.id,
    required this.lessonId,
    required this.questionText,
    required this.state,
    required this.questionUrl,
    required this.questionCode,
    required this.questionType,
    required this.month,
    required this.questionNumber,
    required this.year,
    required this.section,
    required this.difficulty,
    required this.answerType,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      lessonId: json['lesson_id'],
      questionText: json['question'],
      state: json['state'],
      questionUrl: json['q_url'],
      questionCode: json['q_code'],
      questionType: json['q_type'],
      month: json['month'],
      questionNumber: json['q_num'],
      year: json['year'],
      section: json['section'],
      difficulty: json['difficulty'],
      answerType: json['ans_type'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}

class Answer {
  final int id;
  final String? mcqAns;
  final String mcqAnswers;
  final int qId;
  final String createdAt;
  final String updatedAt;

  Answer({
    required this.id,
    required this.mcqAns,
    required this.mcqAnswers,
    required this.qId,
    required this.createdAt,
    required this.updatedAt,
  });

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
