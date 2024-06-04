import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_chapter_screen.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamDuration extends StatefulWidget {
  final List<String> chapterNames;
  final List<int> ids;
  final List<double> prices;
  final List<int> durations;
  final List<double> discounts;

  const ExamDuration({
    super.key,
    required this.chapterNames,
    required this.ids,
    required this.prices,
    required this.durations,
    required this.discounts,
  });

  @override
  State<ExamDuration> createState() => _ExamDurationState();
}

class _ExamDurationState extends State<ExamDuration> {
  Map<int, double> selectedPrices = {};
  Map<int, int> selectedDurations = {};
  double totalPrice = 0.0;
  bool showError = false;

  void _updateTotalPrice() {
    totalPrice = selectedPrices.values.fold(0.0, (sum, price) => sum + price);
  }

  void _checkout() {
    if (selectedDurations.isEmpty) {
      setState(() {
        showError = true;
      });
    } else {
      setState(() {
        showError = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckoutChapterScreen(
                duration: selectedDurations.values.toList(),
                price: totalPrice,
                id: widget.ids,
                type: "Chapter",
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Duration"),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: faceBookColor,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ExamScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < widget.chapterNames.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select duration for: ${widget.chapterNames[i]}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    DropdownButton<int>(
                      hint: const Text("Select Duration"),
                      items: widget.durations
                          .map(
                            (duration) => DropdownMenuItem<int>(
                              value: duration,
                              child: Text('$duration '),
                            ),
                          )
                          .toList(),
                      onChanged: (selectedDuration) {
                        if (selectedDuration != null) {
                          setState(() {
                            int index =
                                widget.durations.indexOf(selectedDuration);
                            double price = widget.prices[index];
                            selectedPrices[i] = price;
                            selectedDurations[i] = selectedDuration;
                            _updateTotalPrice();
                          });
                        }
                      },
                    ),
                    if (selectedPrices.containsKey(i))
                      Text(
                        'Price: \$${selectedPrices[i]!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    SizedBox(height: 16.h),
                  ],
                ),
              const Divider(),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
              if (showError)
                Text(
                  'You must select at least one duration first!',
                  style: TextStyle(fontSize: 14.sp, color: Colors.red),
                ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: Colors.redAccent[700],
                  foregroundColor: Colors.white,
                ),
                onPressed: _checkout,
                child: const Text(
                  "check out",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
