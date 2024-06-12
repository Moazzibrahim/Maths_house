
class DiaExamHistory {
  final String examTitle;
  final String date;
  final int id;
  final int score;

  DiaExamHistory({
    required this.examTitle,
    required this.date,
    required this.id,
    required this.score,
  });

  factory DiaExamHistory.fromJson(Map<String, dynamic> json) => DiaExamHistory(
        examTitle: json['exams']['title'] ?? 'no title',
        date: json['date'] ?? 'no date',
        id: json['id'],
        score: json['exams']['score'],
      );
}

class DiaExamHistoryList {
  final List<dynamic> diaExamList;

  DiaExamHistoryList({required this.diaExamList});

  factory DiaExamHistoryList.fromJson(Map<String, dynamic> json) =>
      DiaExamHistoryList(
        diaExamList: json['dia_exam'],
      );
}

class DiaExamReccomendation {
  final String chapterName;
  final int id;
  final List<DiaPrices> diaPrices;

  DiaExamReccomendation(
      {required this.chapterName, required this.id, required this.diaPrices});

  factory DiaExamReccomendation.fromJson(Map<String, dynamic> json) {
    List<DiaPrices> dp =[];
    for(var e in json['price']){
      dp.add(DiaPrices.fromJson(e));
    }
    return DiaExamReccomendation(
      chapterName: json['chapter_name'],
      id: json['id'],
      diaPrices: dp,
    );
  }
}

class DiaPrices {
  final double price;
  final int duration;
  final double discount;

  DiaPrices(
      {required this.price, required this.duration, required this.discount});

  factory DiaPrices.fromJson(Map<String, dynamic> json) => DiaPrices(
        price: json['price'],
        duration: json['duration'],
        discount: json['discount'],
      );
}

class DiaExamReccomendationList {
  final List<dynamic> diaExamReccomendationList;

  DiaExamReccomendationList({required this.diaExamReccomendationList});

  factory DiaExamReccomendationList.fromJson(Map<String,dynamic> json)=>
  DiaExamReccomendationList(diaExamReccomendationList: json['recommandition']);
}
