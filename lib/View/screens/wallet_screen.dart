import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/wallet_recharge.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/wallet_history_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

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
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, 'wallet'),
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
                      'Total: ${walletProvider.totalWallet}\$',
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
                              builder: (context) => WalletRechargeScreen(),
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
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('#')),
                          DataColumn(label: Text('wallet')),
                          DataColumn(label: Text('data')),
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
                                    DataCell(Text(entry.value.date)),
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
        );
      },
    );
  }
}
