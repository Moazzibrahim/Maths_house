import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/live/my_live_Sceen.dart';
import 'package:webview_flutter_x5/webview_flutter.dart';
import 'package:flutter/services.dart';

class VideoWebView extends StatefulWidget {
  final String url; // Accept URL as a parameter

  const VideoWebView({super.key, required this.url});

  @override
  _VideoWebViewState createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  @override
  void initState() {
    super.initState();
    WebView.platform ??= SurfaceAndroidWebView();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
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
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: WebView(
            initialUrl: widget.url, // Use the URL from the widget
            javascriptMode: JavascriptMode.unrestricted,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          ),
        ),
      ),
    );
  }
}

void main() {
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
      home: const MyLiveScreen(),
    );
  }
}
