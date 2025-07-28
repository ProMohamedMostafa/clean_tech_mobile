import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_transaction/data/model/transaction_details_model.dart';

part 'transaction_details_state.dart';

class TransactionDetailsCubit extends Cubit<TransactionDetailsState> {
  TransactionDetailsCubit() : super(TransactionDetailsInitial());

  TransactionDetailsModel? transactionDetailsModel;
  getTransactionDetails(int? id, int? type) {
    emit(TransactionDetailsLoadingState());
    DioHelper.getData(url: 'stock/transactions/$id/$type').then((value) {
      transactionDetailsModel = TransactionDetailsModel.fromJson(value!.data);
      emit(TransactionDetailsSuccessState(transactionDetailsModel!));
    }).catchError((error) {
      emit(TransactionDetailsErrorState(error.toString()));
    });
  }

  String getDateOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String getTimeOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  final List<Color> statusColor = [
    Colors.green,
    Colors.red,
  ];
}
