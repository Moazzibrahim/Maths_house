class Course {
  final String name;
  final int coursId;

  Course({required this.name,  required this.coursId});

  factory Course.fromjson(Map<String, dynamic> json) => Course(
        name: json['course_name'],
        
        coursId: json['id'],
      );
}

class CoursesList {
  final List<dynamic> courses;

  CoursesList({required this.courses});

  factory CoursesList.fromjson(Map<String, dynamic> json) => CoursesList(
        courses: json['courses'],
      );
}
