import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/logic/feedback_audit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_audit_view/feedback_audit_mangement/ui/widget/feedback_audit_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackAuditBody extends StatelessWidget {
  const FeedbackAuditBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedbackAuditCubit>();

    return BlocConsumer<FeedbackAuditCubit, FeedbackAuditState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: CustomBackButton(),
              title: Text(cubit.selectedIndex == 0 ? S.of(context).feedback : S.of(context).audit),
            ),
            floatingActionButton: floatingActionButton(
              icon: Icons.rate_review_outlined,
              onPressed: () async {
                final result = await context.pushNamed(
                    Routes.addFeedbackAuditScreen,
                    arguments: cubit.selectedIndex);

                if (result == true) {
                  cubit.refresh();
                }
              },
            ),
            body: Skeletonizer(
              enabled:
                  cubit.allFeedbackModel == null || cubit.allAuditModel == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    FilterAndSearchWidget(
                      hintText: S.of(context).find_question,
                      searchController: cubit.searchController,
                      onSearchChanged: (value) {
                        cubit.selectedIndex == 0
                            ? cubit.getAllFeedback()
                            : cubit.getAllAudit();
                      },
                      onFilterTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider(
                              create: (context) => FilterDialogCubit()..getBuilding(),
                              child: FilterDialogWidget(
                                index: 'Fee',
                                onPressed: (data) {
                                  cubit.filterModel = data;
                                  cubit.selectedIndex == 0
                                      ? cubit.getAllFeedback()
                                      : cubit.getAllAudit();
                                },
                              ),
                            );
                          },
                        );
                      },
                      isFilterActive: cubit.filterModel != null,
                      onClearFilter: () {
                        cubit.filterModel = null;
                        cubit.searchController.clear();
                        cubit.selectedIndex == 0
                            ? cubit.getAllFeedback()
                            : cubit.getAllAudit();
                      },
                    ),
                    verticalSpace(10),
                    integrationsButtons(
                      selectedIndex: cubit.selectedIndex,
                      onTap: (index) => cubit.changeTap(index),
                      firstCount: cubit.allFeedbackModel?.data?.totalCount ?? 0,
                      firstLabel: S.of(context).feedback,
                      secondCount: cubit.allAuditModel?.data?.totalCount ?? 0,
                      secondLabel: S.of(context).audits,
                    ),
                    verticalSpace(10),
                    Expanded(child: FeedbackAuditListBuild()),
                    verticalSpace(10),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
