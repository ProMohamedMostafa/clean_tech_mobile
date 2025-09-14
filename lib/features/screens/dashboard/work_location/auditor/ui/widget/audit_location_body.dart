import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/logic/cubit/auditor_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/ui/widget/audit_location_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AuditLocationBody extends StatelessWidget {
  const AuditLocationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).sections),
        ),
        body: BlocConsumer<AuditorCubit, AuditorState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<AuditorCubit>();

            return Skeletonizer(
              enabled: cubit.auditLocationModel == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilterAndSearchWidget(
                      hintText: S.of(context).find_location,
                      searchController: cubit.searchController,
                      onSearchChanged: (value) {
                        cubit.getAuditLocation();
                      },
                      onFilterTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider(
                              create: (context) =>
                                  FilterDialogCubit()..getArea(),
                              child: FilterDialogWidget(
                                index: 'Au',
                                onPressed: (data) {
                                  cubit.filterModel = data;
                                  cubit.getAuditLocation();
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
                        cubit.getAuditLocation();
                      },
                    ),
                  ),
                  verticalSpace(10),
                  Expanded(child: AuditLocationListBuild()),
                  verticalSpace(10),
                ],
              ),
            );
          },
        ));
  }
}
