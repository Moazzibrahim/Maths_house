import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/widgets/onboarding_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  List<Widget> onboarrdingPages = [
    const OnBoardingWidgets(
      description:
          'Welcome to our online learning application! Start your educational journey now by registering and exploring our unique content',
      image: 'assets/images/onboarding_1.png',
    ),
    const OnBoardingWidgets(
      description:
          'Explore new worlds of knowledge and learning with us. Discover exciting lessons and outstanding educational resources to achieve your learning goals',
      image: 'assets/images/onboarding_2.png',
    ),
    const OnBoardingWidgets(
      description:
          'Learn easily and enjoyably through a unique learning experience. Discover how we can help you succeed academically and professionally',
      image: 'assets/images/onboarding_3.png',
    ),
  ];
  double currentPage = 0;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Maths House',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            PageView(
              controller: controller,
              children: onboarrdingPages,
            ),
            Positioned(
                bottom: 140.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    DotsIndicator(
                      dotsCount: onboarrdingPages.length,
                      position: currentPage.toInt(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (currentPage < onboarrdingPages.length - 1) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isNewUser', false);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  const TabsScreen(isLoggedIn: true)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 60,
                          )),
                      child: Text(
                        currentPage < onboarrdingPages.length - 1
                            ? 'Next'
                            : 'Get Started',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
