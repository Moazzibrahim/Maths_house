import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/logout_model.dart';
import 'package:flutter_application_1/View/screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios),
      ),
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
                  backgroundImage: AssetImage(
                      'assets/images/moaz.jpeg'), // Your image path here
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Youssef Tamer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Edit Profile'),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 23,
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.wallet),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Wallet',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  await LogoutModel().logout(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx)=> const LoginPage())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide(
                      color: faceBookColor!,
                    ),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: faceBookColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
