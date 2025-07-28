import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_transaction/ui/widgets/transaction_details_body.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final int id;
  final int type;
  const TransactionDetailsScreen(
      {super.key, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    return TransactionDetailsBody(id: id, type: type);
  }
}
