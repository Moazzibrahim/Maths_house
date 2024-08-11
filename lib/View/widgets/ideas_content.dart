import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
    super.initState();

    if (widget.lesson.videos.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNoVideosDialog();
      });
    } else {
      videolink = widget.lesson.videos[viewedVideoIndex].videoLink;
      if (videolink != null && videolink!.isNotEmpty) {
        controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(videolink!));
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showNoVideosDialog();
        });
      }
    }
  }

  void _showNoVideosDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Videos'),
          content: const Text('There are no videos for this lesson.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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

  Future<void> _launchPDF() async {
    final pdfUrl = widget.lesson.videos[viewedVideoIndex].pdfLink;
    if (pdfUrl != null && pdfUrl.isNotEmpty) {
      if (await canLaunch(pdfUrl)) {
        await launch(pdfUrl);
      } else {
        throw 'Could not launch $pdfUrl';
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: faceBookColor,
            content: Text('This lesson does not have a PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              if (videolink != null && videolink!.isNotEmpty)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: WebViewWidget(
                    controller: controller,
                  ),
                )
              else
                const SizedBox(
                    height: 200,
                    child: Center(child: Text('No video available'))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: faceBookColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                    onPressed: _launchPDF,
                    child: const Text(
                      'Download PDF',
                      style: TextStyle(color: Colors.white),
                    ),
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
                          videolink =
                              widget.lesson.videos[viewedVideoIndex].videoLink;
                          if (videolink != null && videolink!.isNotEmpty) {
                            controller.loadRequest(Uri.parse(videolink!));
                          } else {
                            _showNoVideosDialog();
                          }
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
