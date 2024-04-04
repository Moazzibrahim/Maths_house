import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class UnregisteredProfile extends StatelessWidget {
  const UnregisteredProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have no account'),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const LoginPage()));
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
                    side: const BorderSide(
                      color: faceBookColor,
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: faceBookColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
