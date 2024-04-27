import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/start_quiz.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/quiz_provider.dart';
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
            return Card(
              color: gridHomeColor,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx)=> StartQuiz(quiz: quizzesProvider.allQuizzesModel[index],))
                  );
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
