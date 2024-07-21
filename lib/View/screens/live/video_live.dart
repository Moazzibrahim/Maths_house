import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatefulWidget {
  final String url; // Accept URL as a parameter

  const VideoWebView({super.key, required this.url});

  @override
  _VideoWebViewState createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  bool isLandscape = false;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        "https://ucloud.mfscripts.com/video/embed/4g/640x320/Iron_Sky_Trailer.mp4"));

  void toggleRotation() {
    if (isLandscape) {
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
      isLandscape = !isLandscape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ideas Content'),
        actions: [
          IconButton(
            icon: Icon(isLandscape
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
                aspectRatio: 21 / 9,
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
                        // Add rating update logic here if needed
                      },
                      child: Icon(
                        i < 3
                            ? Icons.star
                            : Icons
                                .star_border_outlined, // Adjust rating condition as needed
                        color: Colors.redAccent[700],
                      ),
                    ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: const Row(
                      children: [
                        Text('Report'),
                        SizedBox(width: 5),
                        Icon(Icons.flag_outlined),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'No more videos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video WebView App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoWebView(
          url:
              'https://ucloud.mfscripts.com/video/embed/4g/640x320/Iron_Sky_Trailer.mp4'),
    );
  }
}
