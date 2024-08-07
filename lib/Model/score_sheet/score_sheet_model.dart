class Quizze {
  final int id;
  final String title;
  final String description;
  final String time;
  final int score;
  final int passScore;
  final int quizzeOrder;
  final int lessonId;
  final int state;
  final DateTime createdAt;
  final DateTime updatedAt;

  Quizze({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.score,
    required this.passScore,
    required this.quizzeOrder,
    required this.lessonId,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Quizze.fromJson(Map<String, dynamic> json) {
    return Quizze(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: json['time'],
      score: json['score'],
      passScore: json['pass_score'],
      quizzeOrder: json['quizze_order'],
      lessonId: json['lesson_id'],
      state: json['state'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'score': score,
      'pass_score': passScore,
      'quizze_order': quizzeOrder,
      'lesson_id': lessonId,
      'state': state,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Question {
  final int id;
  final int lessonId;
  final String question;
  final String state;
  final String? qUrl;
  final String qCode;
  final String qType;
  final int month;
  final String qNum;
  final int year;
  final String section;
  final String difficulty;
  final String ansType;
  final DateTime updatedAt;
  final DateTime createdAt;

  Question({
    required this.id,
    required this.lessonId,
    required this.question,
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
    required this.updatedAt,
    required this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      lessonId: json['lesson_id'],
      question: json['question'],
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
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lesson_id': lessonId,
      'question': question,
      'state': state,
      'q_url': qUrl,
      'q_code': qCode,
      'q_type': qType,
      'month': month,
      'q_num': qNum,
      'year': year,
      'section': section,
      'difficulty': difficulty,
      'ans_type': ansType,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class StudentQuizScore {
  final int id;
  final DateTime date;
  final int studentId;
  final int lessonId;
  final int quizzeId;
  final int score;
  final String? time;
  final int rQuestions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Quizze quizze;
  final List<Question> questions;

  StudentQuizScore({
    required this.id,
    required this.date,
    required this.studentId,
    required this.lessonId,
    required this.quizzeId,
    required this.score,
    this.time,
    required this.rQuestions,
    required this.createdAt,
    required this.updatedAt,
    required this.quizze,
    required this.questions,
  });

  factory StudentQuizScore.fromJson(Map<String, dynamic> json) {
    return StudentQuizScore(
      id: json['id'],
      date: DateTime.parse(json['date']),
      studentId: json['student_id'],
      lessonId: json['lesson_id'],
      quizzeId: json['quizze_id'],
      score: json['score'],
      time: json['time'],
      rQuestions: json['r_questions'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      quizze: Quizze.fromJson(json['quizze']),
      questions: (json['questions'] as List)
          .map((i) => Question.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'student_id': studentId,
      'lesson_id': lessonId,
      'quizze_id': quizzeId,
      'score': score,
      'time': time,
      'r_questions': rQuestions,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'quizze': quizze.toJson(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
