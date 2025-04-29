import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/material_details_list_build.dart';

class MaterialManagmentBody extends StatelessWidget {
  final int? id;
  const MaterialManagmentBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final MaterialManagementCubit cubit =
        context.read<MaterialManagementCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
          'Material Management',
        ),
      ),
      floatingActionButton: floatingActionButton(
        icon: Icons.library_add,
        onPressed: () {
          context.pushNamed(Routes.addMaterialScreen);
        },
      ),
      body: BlocConsumer<MaterialManagementCubit, MaterialManagementState>(
        listener: (context, state) {
          if (state is MaterialManagementErrorState ||
              state is DeleteMaterialErrorState) {
            final errorMessage = state is MaterialManagementErrorState
                ? state.error
                : (state as DeleteMaterialErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is ForceDeleteMaterialSuccessState) {
            toast(text: state.message, color: Colors.blue);
            cubit.getMaterialList();
            cubit.getAllDeletedMaterial();
          }
          if (state is RestoreMaterialSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is DeleteMaterialSuccessState) {
            toast(text: state.deleteMaterialModel.message!, color: Colors.blue);
            cubit.getMaterialList();
          }
          if (state is AddMaterialSuccessState) {
            context.read<MaterialManagementCubit>().getMaterialList();
            context.read<MaterialManagementCubit>().getAllDeletedMaterial();
            toast(text: state.message, color: Colors.blue);
          }
          if (state is ReduceMaterialSuccessState) {
            context.read<MaterialManagementCubit>().getMaterialList();
            context.read<MaterialManagementCubit>().getAllDeletedMaterial();
            toast(text: state.message, color: Colors.blue);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (context
                        .read<MaterialManagementCubit>()
                        .materialManagementModel ==
                    null &&
                context
                        .read<MaterialManagementCubit>()
                        .deletedMaterialListModel ==
                    null),
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
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit
                            .materialManagementModel?.data?.materials?.length ??
                        0,
                    firstLabel: 'Total Materials',
                    secondCount:
                        cubit.deletedMaterialListModel?.data?.length ?? 0,
                    secondLabel: 'Deleted Materials',
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: state is MaterialManagementLoadingState &&
                            (context
                                        .read<MaterialManagementCubit>()
                                        .materialManagementModel ==
                                    null &&
                                context
                                        .read<MaterialManagementCubit>()
                                        .deletedMaterialListModel ==
                                    null)
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor))
                        : materialDetailsBuild(context, cubit.selectedIndex),
                  ),
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
