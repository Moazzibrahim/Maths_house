class ExamCode {
  final int id;
  final String examCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExamCode({
    required this.id,
    required this.examCode,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory ExamCode.fromJson(Map<String, dynamic> json) {
    return ExamCode(
      id: json['id'],
      examCode: json['exam_code'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam_code': examCode,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ExamCodeList {
  final List<ExamCode> codes;

  ExamCodeList({required this.codes});

  // Factory constructor to create an instance from JSON list
  factory ExamCodeList.fromJson(List<dynamic> jsonList) {
    return ExamCodeList(
      codes: jsonList.map((json) => ExamCode.fromJson(json)).toList(),
    );
  }

  // Method to convert an instance to JSON list
  List<Map<String, dynamic>> toJson() {
    return codes.map((code) => code.toJson()).toList();
  }
}
