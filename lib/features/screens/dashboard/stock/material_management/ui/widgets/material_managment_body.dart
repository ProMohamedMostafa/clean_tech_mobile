import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/logic/material_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/ui/widgets/material_details_list_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/material_management/ui/widgets/pdf.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class MaterialManagmentBody extends StatelessWidget {
  final int? id;
  const MaterialManagmentBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MaterialManagementCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).materialManagement),
          leading: CustomBackButton(),
          actions: [
            IconButton(
              onPressed: () {
                createMaterialPDF(context);
              },
              icon: Icon(
                CupertinoIcons.tray_arrow_down,
                color: Colors.red,
                size: 22.sp,
              ),
            ),
            horizontalSpace(10)
          ]),
      floatingActionButton: floatingActionButton(
        icon: Icons.library_add,
        onPressed: () async {
          final result = await context.pushNamed(Routes.addMaterialScreen);

          if (result == true) {
            cubit.refreshMaterials();
          }
        },
      ),
      body: BlocConsumer<MaterialManagementCubit, MaterialManagementState>(
        listener: (context, state) {
          if (state is MaterialManagementErrorState ||
              state is DeleteMaterialErrorState) {
            final errorMessage = state is MaterialManagementErrorState
                ? state.error
                : (state as DeleteMaterialErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }
          if (state is DeleteMaterialSuccessState) {
            toast(text: state.deleteMaterialModel.message!, isSuccess: true);
            cubit.getMaterialList();
          }
          if (state is ForceDeleteMaterialSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getMaterialList();
            cubit.getAllDeletedMaterial();
          }
          if (state is ForceDeleteMaterialErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreMaterialSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreMaterialErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is AddMaterialSuccessState) {
            cubit.getMaterialList();
            cubit.getAllDeletedMaterial();
            toast(text: state.message, isSuccess: true);
          }
          if (state is AddMaterialErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is ReduceMaterialSuccessState) {
            cubit.getMaterialList();
            cubit.getAllDeletedMaterial();
            toast(text: state.message, isSuccess: true);
          }
          if (state is ReduceMaterialErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (cubit.materialManagementModel == null &&
                cubit.deletedMaterialListModel == null),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    FilterAndSearchWidget(
                      hintText: S.of(context).findMaterial,
                      searchController: cubit.searchController,
                      onSearchChanged: (value) {
                        cubit.getMaterialList();
                      },
                      onFilterTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider(
                              create: (context) =>
                                  FilterDialogCubit()..getCategory(),
                              child: FilterDialogWidget(
                                index: 'S-m',
                                onPressed: (data) {
                                  cubit.filterModel = data;
                                  cubit.getMaterialList();
                                },
                              ),
                            );
                          },
                        );
                      },isFilterActive: cubit.filterModel != null,
                    onClearFilter: () {
                      cubit.filterModel = null;
                      cubit.searchController.clear();
                      cubit.getMaterialList();
                    },
                    ),
                    verticalSpace(10),
                    integrationsButtons(
                      selectedIndex: cubit.selectedIndex,
                      onTap: (index) => cubit.changeTap(index),
                      firstCount:
                          cubit.materialManagementModel?.data?.totalCount ?? 0,
                      firstLabel: S.of(context).totalMaterials,
                      secondCount:
                          cubit.deletedMaterialListModel?.data?.length ?? 0,
                      secondLabel: S.of(context).deletedMaterials,
                    ),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    Expanded(child: MaterialDetailsListBuild()),
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
