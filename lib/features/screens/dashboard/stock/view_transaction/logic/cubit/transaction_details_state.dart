part of 'transaction_details_cubit.dart';

abstract class TransactionDetailsState {}

final class TransactionDetailsInitial extends TransactionDetailsState {}

class TransactionDetailsLoadingState extends TransactionDetailsState {}

class TransactionDetailsSuccessState extends TransactionDetailsState {
  final TransactionDetailsModel transactionDetailsModel;

  TransactionDetailsSuccessState(this.transactionDetailsModel);
}

class TransactionDetailsErrorState extends TransactionDetailsState {
  final String error;
  TransactionDetailsErrorState(this.error);
}
