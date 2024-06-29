class ExamHistory {
  final int id;
  final int score;
  final String examName;
  final String date;

  ExamHistory({
    required this.id,
    required this.score,
    required this.examName,
    required this.date,
  });

  factory ExamHistory.fromJson(Map<String, dynamic> json) => ExamHistory(
        id: json['id'] ?? 0,
        score: json['exams']['score'] ?? 0,
        examName: json['exams']['title'] ?? 'no title',
        date: json['date'] ?? 'no title',
      );
}

class ExamHistoryList {
  final List<dynamic> examHistoryList;

  ExamHistoryList({required this.examHistoryList});

  factory ExamHistoryList.fromJson(Map<String, dynamic> json) =>
      ExamHistoryList(examHistoryList: json['exam']);
}

class ExamViewMistake {
  final String question;
  final String qUrl;
  final int qId;

  ExamViewMistake(
      {required this.question, required this.qUrl, required this.qId});

  factory ExamViewMistake.fromJson(Map<String, dynamic> json) =>
      ExamViewMistake(
          question: json['question']['question'] ?? 'no question',
          qUrl: json['question']['q_url'] ?? 'no url',
          qId: json['question_id']??''
          );
}

class ExamViewMistakesList {
  final List<dynamic> examViewMistakeList;

  ExamViewMistakesList({required this.examViewMistakeList});

  factory ExamViewMistakesList.fromJson(Map<String, dynamic> json) =>
      ExamViewMistakesList(
        examViewMistakeList: json['questions'],
      );
}

class ExamReccomndation {
  final String chapteName;
  final int id;
  final List<Price> prices;

  ExamReccomndation({required this.chapteName, required this.prices, required this.id});

  factory ExamReccomndation.fromJson(Map<String, dynamic> json) {
    List<Price> priceList = [];
    List<dynamic> pl = json['price'];
    for (var e in pl) {
      priceList.add(Price.fromJson(e));
    }
    return ExamReccomndation(
      chapteName: json['chapter_name']??'no chapter name',
      id: json['id'] ?? 'no id',
      prices: priceList,
    );
  }
}

class Price {
  final double price;
  final dynamic duration;
  final double discount;

  Price({
    required this.price,
    required this.discount,
    required this.duration,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        price: (json['price'] ?? 0).toDouble(),
        duration: json['duration'] ?? 'no',
        discount: (json['discount'] ?? 0).toDouble(),
      );
}


class ExamReccomndationList {
  final List<dynamic> examReccomendationList;

  ExamReccomndationList({required this.examReccomendationList});

  factory ExamReccomndationList.fromJson(Map<String, dynamic> json) =>
      ExamReccomndationList(
        examReccomendationList: json['recommandition'],
      );
}
