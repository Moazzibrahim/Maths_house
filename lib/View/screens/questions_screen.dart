import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/question_provider.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  String? selectedAnswer;

  @override
  void initState() {
    Provider.of<QuestionsProvider>(context, listen: false)
        .getQuestionsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              )),
        ),
        title: const Text('Question number 1'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<QuestionsProvider>(
          builder: (context, questionsProvider, _) {
            if (questionsProvider.allQuestions.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                return Center(
            child: Column(
              children: [
                const Text('What is the oldest types of science ?',style: TextStyle(fontSize: 25),),
                const SizedBox(height: 30,),
                Image.asset('assets/images/planet.png'),
                const SizedBox(height: 20,),
                RadioListTile<String>(
                    title: const Text('A. Astronomy'),
                    value: 'A',
                    groupValue: selectedAnswer,
                    activeColor: Colors.redAccent[700],
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('B. physics'),
                    value: 'B',
                    groupValue: selectedAnswer,
                    activeColor: Colors.redAccent[700],
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('C. chemistry'),
                    value: 'C',
                    groupValue: selectedAnswer,
                    activeColor: Colors.redAccent[700],
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('D. biology'),
                    value: 'D',
                    groupValue: selectedAnswer,
                    activeColor: Colors.redAccent[700],
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[700],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 60,
                    )
                  ),
                  child: const Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ],
            ),
          );
              } 
          },
        ),
      ),
    );
  }
}