class Course {
  final String name;
  final int courseId;

  Course({required this.name,  required this.courseId});

  factory Course.fromjson(Map<String, dynamic> json) => Course(
        name: json['course_name'],
        
        courseId: json['id'],
      );
}

class CoursesList {
  final List<dynamic> courses;

  CoursesList({required this.courses});

  factory CoursesList.fromjson(Map<String, dynamic> json) => CoursesList(
        courses: json['courses'],
      );
}
