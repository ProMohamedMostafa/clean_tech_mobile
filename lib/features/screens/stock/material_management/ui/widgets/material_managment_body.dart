import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/material_details_list_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/ui/widgets/filter_search_build.dart';

class MaterialManagmentBody extends StatefulWidget {
  const MaterialManagmentBody({super.key});

  @override
  State<MaterialManagmentBody> createState() => _MaterialManagmentBodyState();
}

class _MaterialManagmentBodyState extends State<MaterialManagmentBody> {
  @override
  void initState() {
    context.read<MaterialManagementCubit>().getMaterialList();
    context.read<MaterialManagementCubit>().getAllDeletedMaterial();
    context.read<MaterialManagementCubit>().getProviders();

    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
          'Material Management',
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          height: 57.h,
          width: 57.w,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.addMaterialScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: REdgeInsets.all(0),
              backgroundColor: AppColor.primaryColor,
              shape: CircleBorder(),
              side: BorderSide(
                color: AppColor.secondaryColor,
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.library_add,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
        ),
      ),
      body: BlocConsumer<MaterialManagementCubit, MaterialManagementState>(
        listener: (context, state) {
          if (state is DeleteMaterialSuccessState) {
            context.read<MaterialManagementCubit>().getMaterialList();
            context.read<MaterialManagementCubit>().getAllDeletedMaterial();
            toast(text: state.message, color: Colors.blue);
          }
          if (state is ForceDeleteMaterialSuccessState) {
            context.read<MaterialManagementCubit>().getMaterialList();
            context.read<MaterialManagementCubit>().getAllDeletedMaterial();
            toast(text: state.message, color: Colors.blue);
          }
          if (state is RestoreMaterialSuccessState) {
            context.read<MaterialManagementCubit>().getMaterialList();
            context.read<MaterialManagementCubit>().getAllDeletedMaterial();
            toast(text: state.message, color: Colors.blue);
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

          if (state is MaterialManagementErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is DeleteMaterialErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is ForceDeleteMaterialErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is RestoreMaterialErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is AddMaterialErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is ReduceMaterialErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<MaterialManagementCubit>().materialManagementModel ==
                  null &&
              context
                      .read<MaterialManagementCubit>()
                      .deletedMaterialListModel ==
                  null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    filterAndSearchBuild(
                        context, context.read<MaterialManagementCubit>()),
                    verticalSpace(15),
                    SizedBox(
                      height: 45.h,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;
                          double gap = 10;
                          double containerWidth = (totalWidth - gap) / 2;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: gap);
                            },
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColor.secondaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        index == 0
                                            ? "${context.read<MaterialManagementCubit>().materialManagementModel?.data.data.length ?? 0}"
                                            : "${context.read<MaterialManagementCubit>().deletedMaterialListModel?.data?.length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        index == 0
                                            ? "Total Materials"
                                            : 'Deleted Material',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    materialDetailsBuild(context, selectedIndex!),
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
