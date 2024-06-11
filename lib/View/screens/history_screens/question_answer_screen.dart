// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/parallel_question_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


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

  Future<Uint8List> fetchAndConvertImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> saveImage(Uint8List imageData) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await ImageGallerySaver.saveImage(imageData);
      final isSuccess = result["isSuccess"];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              isSuccess ? 'Image Saved to Gallery!' : 'Failed to Save Image'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission Denied'),
        ),
      );
    }
  }

  int selectedParallel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Answers"),
      body: Consumer<QuestionHistoryProvider>(
        builder: (context, questionAnswerProvider, _) {
          return Stack(
            children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: questionAnswerProvider.allQuestionAnswers.length,
                    itemBuilder: (context, index) {
                      String pdf = questionAnswerProvider.allQuestionAnswers[index].answerPdf;
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
                                  onPressed: () async{
                                  final bytesPdf = await fetchAndConvertImage(pdf);
                                  saveImage(bytesPdf);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent[700],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text('Download PDF ${++index}')),
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
