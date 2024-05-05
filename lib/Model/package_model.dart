class ExamPackage {
  final int id;
  final String name;
  final String module;
  final int number;
  final double price;
  final int duration;
  ExamPackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
  });

  factory ExamPackage.fromJson(Map<String, dynamic> json) {
    return ExamPackage(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
    );
  }
}

class ExamPackageList {
  final List<dynamic> exampackageList;

  ExamPackageList({required this.exampackageList});

  factory ExamPackageList.fromJson(Map<String, dynamic> json) {
    return ExamPackageList(
      exampackageList: json['Exams'],
    );
  }
}

class QuestionPackage {
  final int id;
  final String name;
  final String module;
  final int number;
  final double price;
  final int duration;
  QuestionPackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
  });

  factory QuestionPackage.fromJson(Map<String, dynamic> json) {
    return QuestionPackage(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
    );
  }
}

class QuestionPackageList {
  final List<dynamic> questionpackageList;

  QuestionPackageList({required this.questionpackageList});

  factory QuestionPackageList.fromJson(Map<String, dynamic> json) =>
      QuestionPackageList(questionpackageList: json['Questions']);
}

class LivePackage {
  final int id;
  final String name;
  final String module;
  final int number;
  final double price;
  final int duration;
  LivePackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
  });

  factory LivePackage.fromJson(Map<String, dynamic> json) {
    return LivePackage(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
    );
  }
}

class LivePackageList {
  final List<dynamic> livepackageList;

  LivePackageList({required this.livepackageList});

  factory LivePackageList.fromJson(Map<String, dynamic> json) =>
      LivePackageList(livepackageList: json['Live']);
}
