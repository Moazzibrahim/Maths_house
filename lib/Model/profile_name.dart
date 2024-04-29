class User {
  int id;
  String fName;
  String lName;
  String email;
  String extraemail;
  String phone;
  String parentPhone;
  String parentEmail;
  String image;
  String nickname;

  User({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.extraemail,
    required this.phone,
    required this.parentPhone,
    required this.parentEmail,
    required this.image,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'] ?? '',
      fName: json['user']['f_name'] ?? 'non user',
      lName: json['user']['l_name'] ?? '',
      email: json['user']['email'] ?? '',
      extraemail: json['user']['extra_email'] ?? '',
      phone: json['user']['phone'] ?? '',
      parentPhone: json['user']['parent_phone'] ?? '',
      parentEmail: json['user']['parent_email'] ?? '',
      image: json['user']['image'] ?? '',
      nickname: json['user']["nick_name"] ?? '',
    );
  }
}
