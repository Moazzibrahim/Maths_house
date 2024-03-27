class Course {
  final String name;
  final String image;
  final int coursId;

  Course({required this.name, required this.image, required this.coursId});

  factory Course.fromjson(Map<String, dynamic> json) => Course(
        name: json['course']['course_name'],
        image: json['storage'],
        coursId: json['course']['id'],
      );
}

class CoursesList {
  final List<dynamic> courses;

  CoursesList({required this.courses});

  factory CoursesList.fromjson(Map<String, dynamic> json) => CoursesList(
        courses: json['courses'],
      );
}
