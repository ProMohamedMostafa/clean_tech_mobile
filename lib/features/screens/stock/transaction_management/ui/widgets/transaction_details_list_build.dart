import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/item_list_build.dart';

Widget transactionDetailsBuild(BuildContext context, int selectedIndex) {
  final transactionsData = selectedIndex == 0
      ? context
          .read<TransactionManagementCubit>()
          .transactionManagementModel
          ?.data
          .data
      : selectedIndex == 1
          ? context
              .read<TransactionManagementCubit>()
              .transactionManagementInModel
              ?.data
              .data
          : context
              .read<TransactionManagementCubit>()
              .transactionManagementOutModel
              ?.data
              .data;

  if (transactionsData == null || transactionsData.isEmpty) {
    return Center(
      child: Text(
        "There's no data",
        style: TextStyles.font13Blackmedium,
      ),
    );
  } else {
    return ListView.separated(
      controller: selectedIndex == 0
          ? context.read<TransactionManagementCubit>().scrollController
          : selectedIndex == 1
              ? context.read<TransactionManagementCubit>().inScrollController
              : context.read<TransactionManagementCubit>().outScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: transactionsData.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listItemBuild(context, selectedIndex, index),
            Divider(
              color: Colors.grey[300],
              height: 0.1,
            ),
          ],
        );
      },
    );
  }
}
