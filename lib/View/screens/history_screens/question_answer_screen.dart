import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/parallel_question_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key, required this.id});
  final int id;

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    _initYoutubePlayerController();
    super.initState();
  }

  void _initYoutubePlayerController() {
    Provider.of<QuestionHistoryProvider>(context, listen: false)
        .getQuestionAnswer(context, widget.id);
    Provider.of<QuestionHistoryProvider>(context, listen: false)
        .getParallelQuestion(context, widget.id);
    controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  int selectedParallel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Answers"),
      body: Consumer<QuestionHistoryProvider>(
        builder: (context, questionAnswerProvider, _) {
          return Stack(children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: questionAnswerProvider.allQuestionAnswers.length,
                    itemBuilder: (context, index) {
                      RegExp regExp = RegExp(r"\/embed\/([^?]+)");
                      Match? match = regExp.firstMatch(
                          questionAnswerProvider.allQuestionAnswers[index].answerVid);
                      String videoId = match?.group(1) ?? "";
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: videoId,
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                    disableDragSeek: false,
                                    loop: false,
                                    isLive: false,
                                    forceHD: false,
                                    enableCaption: true,
                                  ),
                                ),
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.redAccent[700],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent[700],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text('Download PDF ${index + 1}')),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 70,)
              ],
            ),
            Positioned(
              bottom: 10,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Choose Parallel"),
                          content: SizedBox(
                            width: 200,
                            height: 145,
                            child: ListView.builder(
                              itemCount: questionAnswerProvider
                                  .allParallelQuestions.length,
                              itemBuilder: (context, index) {
                                int parallelNumber = index + 1;
                                return ListTile(
                                  title: Text("Parallel $parallelNumber"),
                                  onTap: () {
                                    setState(() {
                                      selectedParallel = index;
                                    });
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (ctx) => ParallelQuestionScreen(
                                        selectedParallel: selectedParallel,
                                        id: widget.id,
                                      ),
                                    ));
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(
                        vertical: 9.h,
                        horizontal: 10.w,
                      )),
                  child: Row(
                    children: [
                      Text(
                        'Solve parallel',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 200.w,
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
