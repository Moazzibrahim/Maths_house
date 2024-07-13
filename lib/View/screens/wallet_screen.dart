import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/screens/wallet_recharge.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/wallet_history_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    super.key,
    this.chapters = const [],
  });
  final List<Map<String, dynamic>> chapters;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool showTable = false;

  @override
  void initState() {
    Provider.of<WalletProvider>(context, listen: false)
        .fetchWalletHistory(context)
        .catchError((e) {
      log(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Consumer<WalletProvider>(
        builder: (context, walletProvider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Wallet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              leading: IconButton(
                color: faceBookColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TabsScreen(isLoggedIn: false),
                      ));
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text and buttons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total: ${walletProvider.totalWallet}\$', // No need to convert to String
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WalletRechargeScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: faceBookColor,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 100.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12.r), // Use ScreenUtil for border radius
                            ),
                          ),
                          child: Text(
                            'wallet Recharge',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
                            vertical: 12.h,
                            horizontal: 100.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.r), // Use ScreenUtil for border radius
                          ),
                        ),
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontSize: 15.sp,
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
                            DataColumn(label: Text('wallet')),
                            DataColumn(label: Text('date')),
                            DataColumn(label: Text('state')),
                          ],
                          rows: walletProvider.walletHistoryList
                              .asMap()
                              .entries
                              .map((entry) => DataRow(
                                    cells: [
                                      DataCell(Text('${entry.key + 1}')),
                                      DataCell(
                                          Text(entry.value.wallet.toString())),
                                      // Horizontally scrollable date cell
                                      DataCell(
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(entry.value.date),
                                        ),
                                      ),
                                      DataCell(Text(entry.value.state)),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Home button at the bottom
            // floatingActionButton: FloatingActionButton.extended(
            //   backgroundColor: gridHomeColor,
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => TabsScreen(
            //           isLoggedIn: false,
            //         ),
            //       ),
            //     );
            //   },
            //   label: Text(
            //     'Home',
            //     style: TextStyle(color: faceBookColor),
            //   ),
            //   icon: Icon(
            //     Icons.home,
            //     color: faceBookColor,
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
