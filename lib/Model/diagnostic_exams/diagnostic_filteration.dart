class DiagnosticCategory {
  final int id;
  final String categoryName;
  final String categoryDescription;
  final String categoryUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int teacherId;

  DiagnosticCategory({
    required this.id,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.teacherId,
  });

  factory DiagnosticCategory.fromJson(Map<String, dynamic> json) {
    return DiagnosticCategory(
      id: json['id'] ?? 0,
      categoryName: json['cate_name'] ?? '',
      categoryDescription: json['cate_des'] ?? '',
      categoryUrl: json['cate_url'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      teacherId: json['teacher_id'] ?? 0,
    );
  }
}

class DiagnosticCourse {
  final int id;
  final String courseName;
  final int categoryId;
  final String courseDescription;
  final String courseUrl;
  final String? prerequisites;
  final String? gain;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int teacherId;
  final int? userId;
  final String type;

  DiagnosticCourse({
    required this.id,
    required this.courseName,
    required this.categoryId,
    required this.courseDescription,
    required this.courseUrl,
    this.prerequisites,
    this.gain,
    required this.createdAt,
    required this.updatedAt,
    required this.teacherId,
    this.userId,
    required this.type,
  });

  factory DiagnosticCourse.fromJson(Map<String, dynamic> json) {
    return DiagnosticCourse(
      id: json['id'] ?? 0,
      courseName: json['course_name'] ?? '',
      categoryId: json['category_id'] ?? 0,
      courseDescription: json['course_des'] ?? '',
      courseUrl: json['course_url'] ?? '',
      prerequisites: json['pre_requisition'],
      gain: json['gain'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      teacherId: json['teacher_id'] ?? 0,
      userId: json['user_id'],
      type: json['type'] ?? '',
    );
  }
}
