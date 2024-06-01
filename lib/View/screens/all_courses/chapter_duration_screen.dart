import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/all_courses_model.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_chapter_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterDurationScreen extends StatefulWidget {
  const ChapterDurationScreen(
      {super.key,
      required this.chapterActiveStatus,
      required this.chaptersList});
  final List<bool> chapterActiveStatus;
  final List<ChapterWithPrice> chaptersList;

  @override
  State<ChapterDurationScreen> createState() => _ChapterDurationScreenState();
}

class _ChapterDurationScreenState extends State<ChapterDurationScreen> {
  List<int> ids = [];
  List<String?> selectedDurations = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    selectedDurations = List<String?>.filled(widget.chaptersList.length, null);
    ids = widget.chaptersList.map((e) => e.id).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Function to calculate total price
    void calculateTotalPrice() {
      double total = 0.0;
      for (var i = 0; i < widget.chaptersList.length; i++) {
        if (selectedDurations[i] != null) {
          final selectedDuration = selectedDurations[i]!;
          final chapter = widget.chaptersList[i];
          final price = chapter.chapterPrices
              .firstWhere(
                  (element) => element.duration.toString() == selectedDuration)
              .price;
          total += price;
        }
      }
      setState(() {
        totalPrice = total;
      });
    }

    return Scaffold(
      appBar: buildAppBar(context, 'Durations'),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < widget.chaptersList.length; i++)
                if (widget.chapterActiveStatus[i]) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select duration for ${widget.chaptersList[i].chapterName}: ',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                      if (widget.chaptersList[i].chapterPrices.isNotEmpty)
                        DropdownButton<String>(
                          value: selectedDurations[i],
                          items:
                              widget.chaptersList[i].chapterPrices.map((price) {
                            return DropdownMenuItem<String>(
                              value: price.duration.toString(),
                              child: Text(price.duration.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDurations[i] = value;
                              calculateTotalPrice();
                            });
                          },
                          hint: Text('Select duration',
                              style: TextStyle(fontSize: 14.sp)),
                        )
                      else
                        Text('No duration available',
                            style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  if (i < widget.chaptersList.length - 1)
                    SizedBox(height: 30.h),
                ],
              SizedBox(height: 40.h),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.all(13.w),
                width: double.infinity,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: totalPrice != 0.0
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CheckoutChapterScreen(
                                id: ids,
                                price: totalPrice,
                                type: 'Chapters',
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.redAccent[700],
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Check Out',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
