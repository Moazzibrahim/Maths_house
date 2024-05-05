import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/courses/start_quiz.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/quiz_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class QuizzesContent extends StatefulWidget {
  const QuizzesContent({super.key, required this.lessonId});
  final int lessonId;

  @override
  State<QuizzesContent> createState() => _QuizzesContentState();
}

class _QuizzesContentState extends State<QuizzesContent> {
  @override
  void initState() {
    Provider.of<QuizzesProvider>(context, listen: false)
        .getQuizzesData(context, widget.lessonId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizzesProvider>(
      builder: (context, quizzesProvider, _) {
        return ListView.builder(
          itemCount: quizzesProvider.allQuizzesModel.length,
          itemBuilder: (context, index) {
            if (quizzesProvider.allQuizzesModel.isEmpty) {
              return Center(
                child: Text(
                  'There is no Quizes for that lesson yet',
                  style:
                      TextStyle(color: Colors.redAccent[700], fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Card(
              color: gridHomeColor,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => StartQuiz(
                            quiz: quizzesProvider.allQuizzesModel[index],
                          )));
                },
                title: Text(quizzesProvider.allQuizzesModel[index].title),
              ),
            );
          },
        );
      },
    );
  }
}
