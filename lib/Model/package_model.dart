class ExamPackage {
  final int id;
  final String name;
  final String module;
  final int number;
  final double price;
  final int duration;
  final String type;

  ExamPackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
    required this.type,
  });

  factory ExamPackage.fromJson(Map<String, dynamic> json) {
    return ExamPackage(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      type: json['type'],
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
  final String type;

  QuestionPackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
    required this.type,
  });

  factory QuestionPackage.fromJson(Map<String, dynamic> json) {
    return QuestionPackage(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      type: json['type'],
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
  final String type;

  final int duration;
  LivePackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
    required this.type,
  });

  factory LivePackage.fromJson(Map<String, dynamic> json) {
    return LivePackage(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      type: json['type'],
    );
  }
}

class LivePackageList {
  final List<dynamic> livepackageList;

  LivePackageList({required this.livepackageList});

  factory LivePackageList.fromJson(Map<String, dynamic> json) =>
      LivePackageList(livepackageList: json['Live']);
}
