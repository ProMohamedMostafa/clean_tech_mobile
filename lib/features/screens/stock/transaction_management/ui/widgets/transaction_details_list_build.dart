import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/item_list_build.dart';

class TransactionDetailsListBuild extends StatelessWidget {
  const TransactionDetailsListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionManagementCubit>();
    final transactionsData = cubit.selectedIndex == 0
        ? cubit.transactionManagementModel?.data?.data ?? []
        : cubit.selectedIndex == 1
            ? cubit.transactionManagementInModel?.data?.data ?? []
            : cubit.transactionManagementOutModel?.data?.data ?? [];

    if (transactionsData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }

    return ListView.separated(
      controller: cubit.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: transactionsData.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) =>
          TransactionListitembuild(index: index),
    );
  }
}
