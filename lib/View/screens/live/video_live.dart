import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/live/my_live_Sceen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatefulWidget {
  final String url; // Accept URL as a parameter

  const VideoWebView({super.key, required this.url});

  @override
  _VideoWebViewState createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        "https://ucloud.mfscripts.com/video/embed/4g/640x320/Iron_Sky_Trailer.mp4"));
  @override
  void initState() {
    super.initState();

    // SystemChrome.setPreferredOrientations([
    //   // DeviceOrientation.landscapeRight,
    //   // DeviceOrientation.landscapeLeft,
    // ]);
  }

  @override
  void dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Embedded Video'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: WebViewWidget(
            controller: controller,
            // initialUrl: widget.url, // Use the URL from the widget
            // javascriptMode: JavascriptMode.unrestricted,
            // initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          ),
        ),
      ),
    );
  }
}

void main() {
  // WebView.platform;
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
      home: const MyLiveScreen(),
    );
  }
}
