import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool isLandscapeGlobal = false;

class IdeasContent extends StatefulWidget {
  const IdeasContent({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<IdeasContent> createState() => _IdeasContentState();
}

class _IdeasContentState extends State<IdeasContent> {
  int rating = 0;
  int viewedVideoIndex = 0;
  String? videolink;
  final controller = WebViewController();
  @override
  void initState() {
    videolink = widget.lesson.videos[viewedVideoIndex].videoLink;
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(videolink!));
  }
  // final controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..loadRequest(Uri.parse(videolink!));

  void toggleRotation() {
    if (isLandscapeGlobal) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    setState(() {
      isLandscapeGlobal = !isLandscapeGlobal;
    });
  }

  void updateRating(int newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: const Text('Ideas Content'),
        actions: [
          IconButton(
            icon: Icon(isLandscapeGlobal
                ? Icons.screen_lock_rotation
                : Icons.screen_rotation),
            onPressed: toggleRotation,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: WebViewWidget(
                  controller: controller,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chapter 1: Lesson 1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Mr. Amir',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < 5; i++)
                    GestureDetector(
                      onTap: () {
                        updateRating(i);
                      },
                      child: Icon(
                        i <= rating ? Icons.star : Icons.star_border_outlined,
                        color: Colors.redAccent[700],
                      ),
                    ),
                  const SizedBox(width: 10),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.grey.shade300,
                  //   ),
                  //   child: const Row(
                  //     children: [
                  //       Text('Report'),
                  //       SizedBox(width: 5),
                  //       Icon(Icons.flag_outlined),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              if (widget.lesson.videos.isNotEmpty)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.lesson.videos.length - 1,
                  itemBuilder: (context, i) {
                    int index = i + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          viewedVideoIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade900,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade800,
                              ),
                              child: Center(
                                child: Text(
                                  'Video ${index + 1}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.lesson.videos[index].videoName ??
                                        'Video Name',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Description for every lesson and its idea or video',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              else
                const Text('No more videos',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
