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
        score: json['exams']?['score'] ?? 0,
        examName: json['exams']?['title'] ?? 'no title',
        date: json['date'] ?? 'no date',
      );
}

class ExamHistoryList {
  final List<ExamHistory> examHistoryList;

  ExamHistoryList({required this.examHistoryList});

  factory ExamHistoryList.fromJson(Map<String, dynamic> json) {
    var list = json['exam'] as List? ?? [];
    List<ExamHistory> examHistoryList =
        list.map((i) => ExamHistory.fromJson(i)).toList();
    return ExamHistoryList(examHistoryList: examHistoryList);
  }
}

class ExamViewMistake {
  final String question;
  final String qUrl;
  final int qId;

  ExamViewMistake({
    required this.question,
    required this.qUrl,
    required this.qId,
  });

  factory ExamViewMistake.fromJson(Map<String, dynamic> json) => ExamViewMistake(
        question: json['question']?['question'] ?? 'no question',
        qUrl: json['question']?['q_url'] ?? 'no url',
        qId: json['question_id'] ?? 0,
      );
}

class ExamViewMistakesList {
  final List<ExamViewMistake> examViewMistakeList;

  ExamViewMistakesList({required this.examViewMistakeList});

  factory ExamViewMistakesList.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List? ?? [];
    List<ExamViewMistake> examViewMistakeList =
        list.map((i) => ExamViewMistake.fromJson(i)).toList();
    return ExamViewMistakesList(examViewMistakeList: examViewMistakeList);
  }
}

class ExamReccomndation {
  final String chapterName;
  final int id;
  final List<Price> prices;

  ExamReccomndation({
    required this.chapterName,
    required this.prices,
    required this.id,
  });

  factory ExamReccomndation.fromJson(Map<String, dynamic> json) {
    var priceList = (json['price'] as List? ?? [])
        .map((i) => Price.fromJson(i))
        .toList();
    return ExamReccomndation(
      chapterName: json['chapter_name'] ?? 'no chapter name',
      id: json['id'] ?? 0,
      prices: priceList,
    );
  }
}

class Price {
  final double price;
  final int duration;
  final double discount;

  Price({
    required this.price,
    required this.discount,
    required this.duration,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        price: (json['price'] ?? 0).toDouble(),
        duration: (json['duration'] ?? 0),
        discount: (json['discount'] ?? 0).toDouble(),
      );
}

class ExamReccomndationList {
  final List<ExamReccomndation> examRecommendationList;

  ExamReccomndationList({required this.examRecommendationList});

  factory ExamReccomndationList.fromJson(Map<String, dynamic> json) {
    var list = json['recommendation'] as List? ?? [];
    List<ExamReccomndation> examRecommendationList =
        list.map((i) => ExamReccomndation.fromJson(i)).toList();
    return ExamReccomndationList(examRecommendationList: examRecommendationList);
  }
}
