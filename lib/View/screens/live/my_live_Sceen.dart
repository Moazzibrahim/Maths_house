import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLiveScreen extends StatelessWidget {
  const MyLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'My live'),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No session name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0.sp,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No chapter',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: faceBookColor),
                      SizedBox(width: 5.w),
                      Text(
                        'No date',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: faceBookColor),
                      const SizedBox(width: 5),
                      Text(
                        'From: no from',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'To: No to',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.info, color: faceBookColor),
                      SizedBox(width: 5.w),
                      Text(
                        'Type:No type',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Wrap(
                    spacing: 8.0, // Gap between adjacent buttons
                    runSpacing: 4.0, // Gap between lines if wrapped
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon:
                            Icon(Icons.play_circle_filled, color: Colors.white),
                        label: Text('video lesson'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: faceBookColor,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.video_library, color: Colors.white),
                        label: Text('video record'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: faceBookColor,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                        label: Text('download pdf'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: faceBookColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
