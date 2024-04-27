import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailparentController = TextEditingController();
  TextEditingController phoneparentController = TextEditingController();

  Future<void> postData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    // Get values from text controllers
    var firstname = fnameController.text;
    var lastname = lnameController.text;
    var email = emailController.text;
    var phone = phoneController.text;
    var parentphone = phoneparentController.text;
    var emailparent = emailparentController.text;

    // Prepare data to send
    Map<String, dynamic> data = {
      "id": 8, // Assuming this is the user's ID
      "f_name": firstname,
      "l_name": lastname,
      'name': '$firstname $lastname', // Combining first and last name
      "email": email,
      "phone": phone,
      "parent_phone": parentphone,
      "parent_email": emailparent,
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

  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Scaffold(
            appBar: buildAppBar(context, 'edit profile'),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/moaz.jpeg'),
                      ),
                    ],
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
                          fnameconrtoller: fnameController,
                          lnamecontoller: lnameController,
                          emailController: emailController,
                          phonecontroller: phoneController,
                        ),
                        ParentContent(
                          nameController: nameController,
                          emailparentController: emailparentController,
                          phoneparentController: phoneparentController,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Get the data from the controllers
                      postData(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
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
    required this.lnamecontoller,
    required this.phonecontroller,
  });
  final TextEditingController emailController;
  final TextEditingController fnameconrtoller;
  final TextEditingController lnamecontoller;
  final TextEditingController phonecontroller;

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
              labelText: 'first name',
            ),
          ),
          TextField(
            controller: lnamecontoller,
            decoration: const InputDecoration(
              labelText: 'last name',
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
        ],
      )),
    );
  }
}

class ParentContent extends StatelessWidget {
  const ParentContent({
    super.key,
    required this.nameController,
    required this.emailparentController,
    required this.phoneparentController,
  });
  final TextEditingController nameController;
  final TextEditingController emailparentController;
  final TextEditingController phoneparentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'name',
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
