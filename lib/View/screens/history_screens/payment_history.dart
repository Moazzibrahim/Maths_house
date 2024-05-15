import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/payment_history_provider.dart';
import 'package:provider/provider.dart';

class Paymenthistoryscreen extends StatefulWidget {
  const Paymenthistoryscreen({Key? key}) : super(key: key);

  @override
  State<Paymenthistoryscreen> createState() => _PaymenthistoryscreenState();
}

class _PaymenthistoryscreenState extends State<Paymenthistoryscreen> {
  bool showTable = false;

  @override
  void initState() {
    Provider.of<PaymentHistoryProvider>(context, listen: false)
        .fetchPaymentHistory(context)
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentHistoryProvider>(
      builder: (context, paymentProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, "payment history"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text and button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    // Total payment amount

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Toggle table visibility
                          showTable = !showTable;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 100,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Conditional table
              if (showTable)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('#')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Module')),
                          DataColumn(label: Text('created_at')),
                          DataColumn(label: Text('Payment Method')),
                        ],
                        rows: paymentProvider.paymentHistoryList
                            .asMap()
                            .entries
                            .map((entry) => DataRow(
                                  cells: [
                                    DataCell(Text('${entry.key + 1}')),
                                    DataCell(
                                        Text(entry.value.price.toString())),
                                    DataCell(Text(entry.value.module)),
                                    DataCell(
                                        Text(entry.value.createdAt.toString())),
                                    DataCell(Text(entry.value.method?.payment ??
                                        'wallet')),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
