import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key, required this.ChapterNo});
  final String ChapterNo;

  @override
  State<CardWidget> createState() => _CardWidgetState(ChapterNo: ChapterNo);
}

class _CardWidgetState extends State<CardWidget> {
  final String ChapterNo;
  bool isTapped = true;

  _CardWidgetState({required this.ChapterNo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color:
            isTapped ? gridHomeColor : const Color.fromARGB(255, 234, 228, 228),
        child: ExpansionTile(
          collapsedTextColor: Colors.grey,
          onExpansionChanged: (_) {
            setState(() {
              isTapped = !isTapped;
            });
          },
          title: Text(
            ChapterNo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Lesson 1'),
                      content: const Text('This is the content of Lesson 1.'),
                      actions: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text('login'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('close '),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.video_collection_rounded,
                      color: faceBookColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Lesson 1",
                      style: TextStyle(color: faceBookColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Lesson 2'),
                      content: const Text('This is the content of Lesson 2.'),
                      actions: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text('login'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('close '),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.video_collection_rounded,
                      color: faceBookColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Lesson 2",
                      style: TextStyle(color: faceBookColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Lesson 3'),
                      content: const Text('This is the content of Lesson 3.'),
                      actions: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text('login'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('close '),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.video_collection_rounded,
                      color: faceBookColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Lesson 3",
                      style: TextStyle(color: faceBookColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Lesson 4'),
                      content: const Text('This is the content of Lesson 4.'),
                      actions: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text('login'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('close '),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.video_collection_rounded,
                      color: faceBookColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Lesson 4",
                      style: TextStyle(color: faceBookColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
