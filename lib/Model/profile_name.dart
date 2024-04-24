class User {
  int id;
  String fName;
  String lName;
  String name;
  String email;
  String profilePhotoPath;
  String phone;
  String parentPhone;
  String parentEmail;
  String image;

  User({
    required this.id,
    required this.fName,
    required this.lName,
    required this.name,
    required this.email,
    required this.profilePhotoPath,
    required this.phone,
    required this.parentPhone,
    required this.parentEmail,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id']??'',
      fName: json['user']['f_name']?? 'non user',
      lName: json['user']['l_name']??'',
      name: json['user']['name']??'',
      email: json['user']['email']??'',
      profilePhotoPath: json['user']['profile_photo_path']??'',
      phone: json['user']['phone']??'',
      parentPhone: json['user']['parent_phone']??'',
      parentEmail: json['user']['parent_email']??'',
      image: json['user']['image']??'',
    );
  }
}
