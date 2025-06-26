import 'package:smart_cleaning_application/features/screens/stock/transaction_management/data/model/transaction_management_model.dart';

abstract class TransactionManagementState {}

class TransactionManagementInitialState extends TransactionManagementState {}

class TransactionManagementLoadingState extends TransactionManagementState {}

class TransactionManagementSuccessState extends TransactionManagementState {
  final TransactionManagementModel transactionManagementModel;

  TransactionManagementSuccessState(this.transactionManagementModel);
}

class TransactionManagementErrorState extends TransactionManagementState {
  final String error;
  TransactionManagementErrorState(this.error);
}

