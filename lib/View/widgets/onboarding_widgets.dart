import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingWidgets extends StatelessWidget {
  const OnBoardingWidgets({super.key, required this.description, required this.image});
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: 150.h,),
              TextButton(
                onPressed: () async{
                  SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isNewUser', false);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx)=>  const TabsScreen(isLoggedIn: true))
                  );
                },
                child: Text('Skip',style: TextStyle(color: Colors.redAccent[700],fontSize: 20),),
              ),
            ],
          ),
        ),
      );
  }
}
