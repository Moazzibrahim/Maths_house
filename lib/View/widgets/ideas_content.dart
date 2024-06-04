import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IdeasContent extends StatefulWidget {
  const IdeasContent({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<IdeasContent> createState() => _IdeasContentState();
}

class _IdeasContentState extends State<IdeasContent> {
  int rating =0 ;
  void updateRating(int newRating){
    setState(() {
      rating = newRating;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: 'v69praWH6cs', // Youtube video ID
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text('Chapter 1'),
                SizedBox(
                  width: 10,
                ),
                Text('Lesson 1'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/moaz.jpeg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Mr.Amir'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for(int i=0;i<5;i++)
                GestureDetector(
                  onTap: () {
                    updateRating(i);
                  },
                  child: Icon(
                        i <= rating ? Icons.star : Icons.star_border_outlined, color: Colors.redAccent[700],
                      ),
                ),
                const SizedBox(width: 5,),
              Container(
                padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 194, 193, 193)
                  ),
                  child: const Row(
                    children: [
                      Text('Report'),
                      Icon(Icons.flag_outlined),
                    ],
                  ),
                ),
              ],
            ),
            widget.lesson.videos.isNotEmpty ?
            ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.lesson.videos.length,
            itemBuilder: (context, i) {
              return Row(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8
                    ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 55, 54, 54),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color.fromARGB(255, 195, 194, 194),
                            ),
                            child: const Text('0:10/2:30'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.lesson.videos[i].videoName ?? 'camera wowo'),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text('discription for every lesson and it\'s idea or video')
                    ],
                  ),
                )
                ],
              );
            },
          ):const Text('no more videos')
          ],
        ),
      ),
    );
  }
}
