import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/chapters_tiles.dart';
import 'package:flutter_application_1/services/chapters_provider.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key, required this.title});
  final String title;

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  void initState() {
    Provider.of<ChapterProvider>(context,listen: false).getChaptersData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ChapterProvider>(
          builder: (context, chapterProvider, _) {
          if(chapterProvider.allChapters.isEmpty){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              itemCount: chapterProvider.allChapters.length,
              itemBuilder:(context, index) {
              final chapter = chapterProvider.allChapters[index];
              return ChaptersTiles(chapter: chapter);
            },
            );
          }
          },
        ),
      )
    );
  }
}