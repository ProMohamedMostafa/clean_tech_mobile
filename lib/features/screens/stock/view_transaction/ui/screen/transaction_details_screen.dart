import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/stock/view_transaction/ui/widgets/transaction_details_body.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final int id;
  const TransactionDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionDetailsBody(
        id: id,
      ),
    );
  }
}
