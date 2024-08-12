import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_chapter_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must select at least one duration!')),
      );
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
    List<int> uniqueDurations = widget.durations.toSet().toList();

    return Scaffold(
      appBar: buildAppBar(context, 'Exam Duration'),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.red[100], // Light yellow background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  border: Border.all(color: Colors.red[700]!, width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.red[700],
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'You should select a duration for needed chapters only.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900], // Darker yellow text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < widget.chapterNames.length; i++)
                Card(
                  margin: EdgeInsets.only(bottom: 16.h),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select duration for: ${widget.chapterNames[i]}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        DropdownButton<int>(
                          hint: const Text("Select Duration"),
                          items: uniqueDurations
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
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
              const Divider(),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  backgroundColor: Colors.redAccent[700],
                ),
                onPressed: _checkout,
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  "Check Out",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
