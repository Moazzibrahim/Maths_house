import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamDuration extends StatefulWidget {
  final List<String> chapterNames;
  final List<int> ids;
  final List<double> prices;
  final List<int> durations;
  final List<double> discounts;
  final List<String> types;

  const ExamDuration({
    super.key,
    required this.chapterNames,
    required this.ids,
    required this.prices,
    required this.durations,
    required this.discounts,
    required this.types,
  });

  @override
  State<ExamDuration> createState() => _ExamDurationState();
}

class _ExamDurationState extends State<ExamDuration> {
  Map<int, double> selectedPrices = {};
  double totalPrice = 0.0;

  void _updateTotalPrice() {
    totalPrice = selectedPrices.values.fold(0.0, (sum, price) => sum + price);
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
            ],
          ),
        ),
      ),
    );
  }
}
