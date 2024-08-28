class Exam {
  final int id;
  final String name;
  final String module;
  final int number;
  final double price;
  final int duration;
  final int?
      courseId; // Nullable because some exams may not be associated with a course
  final String createdAt;
  final String updatedAt;
  final String type;

  Exam({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
    this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      name: json['name'],
      module: json['module'],
      number: json['number'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      courseId: json['course_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type'],
    );
  }
}

class LivePackage {
  final int id;
  final String name;
  final String module;
  final int number;
  final double price;
  final int duration;
  final int courseId;
  final String type;

  LivePackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
    required this.courseId,
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
      courseId: json['course_id'],
      type: json['type'],
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
  final int? courseId; // Make courseId nullable

  QuestionPackage({
    required this.id,
    required this.name,
    required this.module,
    required this.number,
    required this.price,
    required this.duration,
    required this.type,
    required this.courseId, // Initialize this property
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
      courseId: json['course_id'], // Map this to the correct JSON field
    );
  }
}

class Course {
  final int id;
  final String courseName;
  final int categoryId;
  final String courseDes;
  final String courseUrl;

  Course({
    required this.id,
    required this.courseName,
    required this.categoryId,
    required this.courseDes,
    required this.courseUrl,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      courseName: json['course_name'],
      categoryId: json['category_id'],
      courseDes: json['course_des'],
      courseUrl: json['course_url'],
    );
  }
}
