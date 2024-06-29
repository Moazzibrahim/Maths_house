import 'package:flutter/material.dart';
import 'package:webview_flutter_x5/webview_flutter.dart';
import 'package:flutter/services.dart'; // Add this import for SystemChrome

class VideoWebView extends StatefulWidget {
  @override
  _VideoWebViewState createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition on Android
    WebView.platform ??= SurfaceAndroidWebView();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Revert preferred orientation to normal when the screen is closed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Embedded Video'),
      ),
      body: const Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: WebView(
            initialUrl:
                'https://ucloud.mfscripts.com/video/embed/4g/640x320/Iron_Sky_Trailer.mp4',
            javascriptMode: JavascriptMode.unrestricted,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          ),
        ),
      ),
    );
  }
}

void main() {
  // Ensure platform is set before running the app
  WebView.platform ??= SurfaceAndroidWebView();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video WebView App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoWebView(),
    );
  }
}
