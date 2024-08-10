import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_answer_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/quiz_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class QuizMistakesScreen extends StatelessWidget {
  const QuizMistakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Mistakes'),
      body: Consumer<QuizHistoryProvider>(
        builder: (context, mistakeProvider, _) {
          final mistakes = mistakeProvider.allMistakes;
          if(mistakes.isEmpty){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return ListView.builder(
              itemCount: mistakes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.network(mistakes[index].qurl),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => QuestionAnswerScreen(
                                    id: mistakes[index].id,
                                      )));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.h, horizontal: 5.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor: Colors.redAccent[700],
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('View Answer'),
                          ),
                  ],
                ); 
              },
              );
          }
        },
      ),
    );
  }
}