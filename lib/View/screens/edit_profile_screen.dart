
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/profile_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController extraemailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailparentController = TextEditingController();
  TextEditingController phoneparentController = TextEditingController();
  File? _image;
  bool _imageSelected = false;

  // Function to open image picker and update the avatar
  Future<void> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageSelected = true;
      } else {
        print('No image selected.');
        _imageSelected = false;
      }
    });
  }

  Future<void> postImage(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      // Check if an image is selected
      if (_image != null) {
        var stream = http.ByteStream(_image!.openRead());
        var length = await _image!.length();
        var uri = Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/update_stu_image');
        var request = http.MultipartRequest("POST", uri);
        var multipartFile = http.MultipartFile('image', stream, length,
            filename: path.basename(_image!.path));

        // Add the file to the request
        request.files.add(multipartFile);
        // Add authorization token
        request.headers.addAll({'Authorization': 'Bearer $token'});
        // Send the request
        var response = await request.send();
        if (response.statusCode == 200) {
          print('Image uploaded successfully');
          // Update the state to reflect the new image
          setState(() {
            // Update the _image variable with the new image
            _image =
                File(_image!.path); // Update the _image with the new file path
          });
        } else {
          print('Failed to upload image: ${response.reasonPhrase}');
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, inform the user
    }
  }

  Future<void> postData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    // Get values from text controllers
    var fname = fnameController.text;
    var lname = lnameController.text;

    var nickname = nicknameController.text;
    var email = emailController.text;
    var phone = phoneController.text;
    var parentphone = phoneparentController.text;
    var emailparent = emailparentController.text;
    var password = passwordController.text;
    var extraemail = extraemailController.text;

    Map<String, dynamic> data = {
      "f_name": fname,
      "l_name": lname,
      "password": password,
      "nick_name": nickname,
      "email": email,
      "phone": phone,
      "parent_phone": parentphone,
      "parent_email": emailparent,
      "extra_email": extraemail,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_profile_data'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        // Handle successful response if needed
      } else {
        print('Failed to update profile: ${response.statusCode}');
        // Handle failure, maybe inform the user
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, inform the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: buildAppBar(context, 'edit profile'),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(_image!) as ImageProvider<Object>?
                              : NetworkImage(profileProvider.userData!.image),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: const Icon(Icons.edit),
                          onTap: () async {
                            await getImageFromGallery();
                            if (_imageSelected) {
                              postImage(context); // Post the selected image
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    labelPadding: EdgeInsets
                        .zero, // No padding between label and indicator
                    indicator: BoxDecoration(
                      color: Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.redAccent[700],
                    tabs: const [
                      _CustomTabProfile(text: 'Requester'),
                      _CustomTabProfile(text: 'Parent'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RequesterContent(
                          nicknamecontoller: nicknameController,
                          emailController: emailController,
                          phonecontroller: phoneController,
                          fnameconrtoller: fnameController,
                          lnameconrtoller: lnameController,
                          passwordconrtoller: passwordController,
                        ),
                        ParentContent(
                          emailparentController: emailparentController,
                          phoneparentController: phoneparentController,
                          extraemailController: extraemailController,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor),
                    onPressed: () async {
                      // Post the data
                      postData(context);
                      // Navigate back to the profile screen only if the widget is still mounted
                      if (mounted) {
                        Navigator.pop(context);
                      }
                      // Reload the profile screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(
                            isLoggedIn: false,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomTabProfile extends StatelessWidget {
  final String text;

  const _CustomTabProfile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class RequesterContent extends StatelessWidget {
  const RequesterContent({
    super.key,
    required this.emailController,
    required this.fnameconrtoller,
    required this.lnameconrtoller,
    required this.nicknamecontoller,
    required this.phonecontroller,
    required this.passwordconrtoller,
  });
  final TextEditingController emailController;
  final TextEditingController fnameconrtoller;

  final TextEditingController lnameconrtoller;
  final TextEditingController nicknamecontoller;
  final TextEditingController phonecontroller;
  final TextEditingController passwordconrtoller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: fnameconrtoller,
              decoration: const InputDecoration(
                labelText: 'fisrt name',
              ),
            ),
            TextField(
              controller: lnameconrtoller,
              decoration: const InputDecoration(
                labelText: 'last name',
              ),
            ),
            TextField(
              controller: nicknamecontoller,
              decoration: const InputDecoration(
                labelText: 'nickname',
              ),
            ),
            TextField(
              controller: phonecontroller,
              decoration: const InputDecoration(
                labelText: 'phone',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordconrtoller,
              decoration: const InputDecoration(
                labelText: 'password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParentContent extends StatelessWidget {
  const ParentContent({
    super.key,
    required this.emailparentController,
    required this.phoneparentController,
    required this.extraemailController,
  });
  final TextEditingController emailparentController;
  final TextEditingController phoneparentController;
  final TextEditingController extraemailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: emailparentController,
              decoration: const InputDecoration(
                labelText: 'email',
              ),
            ),
            TextField(
              controller: phoneparentController,
              decoration: const InputDecoration(
                labelText: 'phone',
              ),
            ),
            TextField(
              controller: extraemailController,
              decoration: const InputDecoration(
                labelText: 'Extra email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
