import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/widgets/textfield_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    TextEditingController newName = TextEditingController();
    TextEditingController newEmail = TextEditingController();
    TextEditingController newPass = TextEditingController();
    TextEditingController confirmPass = TextEditingController();
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Stack(
        children:[ Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            const Text('Creat an account',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            CustomTextField(controller: newName, hintText: 'Name'),
            CustomTextField(controller: newEmail, hintText: 'Email'),
            CustomTextField(controller: newPass, hintText: 'Password'),
            CustomTextField(controller: confirmPass, hintText: 'Confirm Password'),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TabsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 160,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Positioned(
                bottom: 10,
                left: 95,
                child: Row(
                children: [
                  const Text('Already have an account?'),
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text('Login',style: TextStyle(color: Colors.black,fontSize: 15),))
                ],
              ))
        ]
      ),
    );
  }
}