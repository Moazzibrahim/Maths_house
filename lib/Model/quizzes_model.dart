class QuizzesModel {
  final String title;
  final int id;
  final List<QuestionsQuiz> questionQuizList;

  QuizzesModel({
    required this.title,
    required this.id,
    required this.questionQuizList,
  });
  factory QuizzesModel.fromJson(Map<String, dynamic> json) { 
    List<QuestionsQuiz> qql = [];
    List<dynamic> questionsQuizList= json['question_api'];
    for(var e in questionsQuizList){
      qql.add(QuestionsQuiz.fromJson(e));
    }
    return QuizzesModel(
        title: json['title']??'no title',
        id: json['id']?? 0,
        questionQuizList: qql,
      );
  }
}

class QuestionsQuiz {
  final int questionId;
  final String question;
  final List<McqQuiz> mcqQuizList;
  final List<GridAnswer> gridList;

  QuestionsQuiz({
      required this.questionId,
      required this.question,
      required this.mcqQuizList,
      required this.gridList,
      });
  factory QuestionsQuiz.fromJson(Map<String, dynamic> json) {
    List<McqQuiz> mcql = [];
    List<dynamic> mcqQuizList = json['mcq'];
    for(var e in mcqQuizList){
      mcql.add(McqQuiz.fromJson(e));
    }
    List<GridAnswer> gal=[];
    List<dynamic> gridAnswerList = json['g_ans']??[];
    for(var e in gridAnswerList){
      gal.add(GridAnswer.fromJson(e));
    }
    return QuestionsQuiz(
        questionId: json['id']?? 'no id',
        question: json['question']??'no question',
        mcqQuizList: mcql,
        gridList: gal,
      );
  }
}

class McqQuiz {
  final String choice;
  final String answer;

  McqQuiz({required this.choice, required this.answer});
  factory McqQuiz.fromJson(Map<String, dynamic> json) => McqQuiz(
        choice: json['mcq_ans']?? 'no choice',
        answer: json['mcq_answers']?? 'no ans',
      );
}

class GridAnswer {
  final String correctAnswer;

  GridAnswer({required this.correctAnswer});

  factory GridAnswer.fromJson(Map<String, dynamic> json) => GridAnswer(
        correctAnswer: json['grid_ans']??'no grid ans',
      );
}


class QuizzesModelList {
  final List<dynamic> quizzesModelList;

  QuizzesModelList({required this.quizzesModelList});
  factory QuizzesModelList.fromJson(Map<String, dynamic> json) =>
      QuizzesModelList(
        quizzesModelList: json['quiz']??[],
      );
}


