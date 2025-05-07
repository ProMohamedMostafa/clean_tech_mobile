import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/transaction_details_list_build.dart';

class TransactionManagmentBody extends StatefulWidget {
  const TransactionManagmentBody({super.key});

  @override
  State<TransactionManagmentBody> createState() =>
      _TransactionManagmentBodyState();
}

class _TransactionManagmentBodyState extends State<TransactionManagmentBody> {
  @override
  Widget build(BuildContext context) {
    TransactionManagementCubit cubit =
        context.read<TransactionManagementCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
          'Transaction Management',
        ),
      ),
      body:
          BlocConsumer<TransactionManagementCubit, TransactionManagementState>(
        listener: (context, state) {},
        builder: (context, state) {
          int allCount =
              cubit.transactionManagementModel?.data?.totalCount ?? 0;
          int inCount =
              cubit.transactionManagementInModel?.data?.totalCount ?? 0;
          int outCount =
              cubit.transactionManagementOutModel?.data?.totalCount ?? 0;
          return Skeletonizer(
            enabled: (cubit.transactionManagementModel == null),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    FilterAndSearchWidget(),
                    verticalSpace(10),
                    twoButtonsIntegration(
                      selectedIndex: cubit.selectedIndex,
                      onTap: cubit.changeTap,
                      firstCount: allCount,
                      firstLabel: 'All',
                      secondCount: inCount,
                      secondLabel: 'Inside',
                      thirdCount: outCount,
                      thirdLabel: 'Outside',
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child:
                          transactionDetailsBuild(context, cubit.selectedIndex),
                    ),
                    verticalSpace(10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
