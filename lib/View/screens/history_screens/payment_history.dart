import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/payment_history_provider.dart';
import 'package:provider/provider.dart';

class Paymenthistoryscreen extends StatefulWidget {
  const Paymenthistoryscreen({super.key});

  @override
  State<Paymenthistoryscreen> createState() => _PaymenthistoryscreenState();
}

class _PaymenthistoryscreenState extends State<Paymenthistoryscreen> {
  bool showTable = false;
  final ScrollController _scrollController = ScrollController();
  bool _isAtStart = true;

  @override
  void initState() {
    super.initState();
    Provider.of<PaymentHistoryProvider>(context, listen: false)
        .fetchPaymentHistory(context)
        .catchError((e) {
      log(e);
    });

    _scrollController.addListener(() {
      setState(() {
        _isAtStart = _scrollController.position.pixels == 0;
      });
    });
  }

  void _scrollHorizontally() {
    if (_isAtStart) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentHistoryProvider>(
      builder: (context, paymentProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, "Payment History"),
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Toggle table visibility
                          showTable = !showTable;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 100,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
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
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('#')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Created At')),
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
                                        DataCell(Text(
                                            entry.value.createdAt.toString())),
                                        DataCell(Text(
                                            entry.value.method?.payment ??
                                                'wallet')),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _scrollHorizontally,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isAtStart
                                  ? Icons.arrow_forward
                                  : Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
