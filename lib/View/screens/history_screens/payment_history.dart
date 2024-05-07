import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class Paymenthistoryscreen extends StatefulWidget {
  const Paymenthistoryscreen({super.key});

  @override
  State<Paymenthistoryscreen> createState() => _PaymenthistoryscreenState();
}

class _PaymenthistoryscreenState extends State<Paymenthistoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "payment history"),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('#')),
            DataColumn(label: Text('wallet')),
            DataColumn(label: Text('data')),
            DataColumn(label: Text('service')),
            DataColumn(label: Text("payment method"))
          ],
          rows: const [
            DataRow(
              cells: [
                DataCell(Text('1')),
                DataCell(Text('200')),
                DataCell(Text('26/4/2024')),
                DataCell(Text('exam')),
                DataCell(Text('vodafone cash')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('2')),
                DataCell(Text('300')),
                DataCell(Text('26/4/2024')),
                DataCell(Text('course 1')),
                DataCell(Text('vodafone cash')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('3')),
                DataCell(Text('50')),
                DataCell(Text('25/4/2024')),
                DataCell(Text('live package')),
                DataCell(Text('skrill')),
              ],
            ),
            // Add more rows as needed
          ],
        ),
      ),
    );
  }
}
