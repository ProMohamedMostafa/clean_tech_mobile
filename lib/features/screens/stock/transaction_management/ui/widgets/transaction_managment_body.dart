import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/transaction_filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/transaction_details_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class TransactionManagmentBody extends StatelessWidget {
  const TransactionManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionManagementCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).transactionManagement), leading: CustomBackButton()),
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

          final isLoadingCounts = cubit.transactionManagementModel == null ||
              cubit.transactionManagementInModel == null ||
              cubit.transactionManagementOutModel == null;

          return Skeletonizer(
            enabled: isLoadingCounts,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(),
                  verticalSpace(10),
                  integrationsButtons(
                      selectedIndex: cubit.selectedIndex,
                      onTap: cubit.changeTap,
                      firstCount: allCount,
                      firstLabel: S.of(context).all,
                      secondCount: inCount,
                      secondLabel: S.of(context).inside,
                      thirdCount: outCount,
                      thirdLabel: S.of(context).outside),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300], height: 0),
                  verticalSpace(10),
                  Expanded(child: TransactionDetailsListBuild()),
                  verticalSpace(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
