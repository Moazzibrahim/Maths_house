class Course {
  final String name;
  final int courseId;
  final String courseUrl;

  Course( {required this.name,  required this.courseId,required this.courseUrl});

  factory Course.fromjson(Map<String, dynamic> json) => Course(
        name: json['course_name'],
        courseId: json['id'], 
        courseUrl: json['course_url'],
      );
}

class CoursesList {
  final List<dynamic> courses;

  CoursesList({required this.courses});

  factory CoursesList.fromjson(Map<String, dynamic> json) => CoursesList(
        courses: json['courses'],
      );
}
