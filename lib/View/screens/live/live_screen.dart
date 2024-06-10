import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/live/all_sessions_screen.dart';
import 'package:flutter_application_1/View/screens/live/history_live_screen.dart';
import 'package:flutter_application_1/View/screens/live/my_live_Sceen.dart';
import 'package:flutter_application_1/View/screens/live/private_live_screen.dart';
import 'package:flutter_application_1/View/screens/live/upcoming_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Live'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const UpComingScreen()));
              },
              child: GridContainer(
                text: 'UpComing Live',
                color: gridHomeColor,
                styleColor: Colors.redAccent[700],
                image: 'assets/images/icons8-tear-off-calendar-50.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const HistoryLiveScreen()));
              },
              child: GridContainer(
                text: 'History Live',
                color: gridHomeColor,
                styleColor: Colors.redAccent[700],
                image: 'assets/images/history_red.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AllSessionsScreen()));
              },
              child: GridContainer(
                text: 'All Sessions',
                color: gridHomeColor,
                styleColor: Colors.redAccent[700],
                image: 'assets/images/play-cricle.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const PrivateLiveScreen()));
              },
              child: GridContainer(
                text: 'Private Live',
                color: gridHomeColor,
                styleColor: Colors.redAccent[700],
                image: 'assets/images/lock_red.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const MyLiveScreen()));
              },
              child: GridContainer(
                text: 'My Live',
                color: gridHomeColor,
                styleColor: Colors.redAccent[700],
                image: 'assets/images/checked.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
