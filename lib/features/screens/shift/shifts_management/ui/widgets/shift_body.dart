import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/logic/shift_state.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts_management/ui/widgets/shift_list_details_build.dart';

class ShiftBody extends StatefulWidget {
  const ShiftBody({super.key});

  @override
  State<ShiftBody> createState() => _ShiftBodyState();
}

class _ShiftBodyState extends State<ShiftBody> {
  @override
  void initState() {
    context.read<ShiftCubit>().initialize();

    if (role == 'Admin') {
      context.read<ShiftCubit>().getAllShifts();
      context.read<ShiftCubit>().getArea();
      context.read<ShiftCubit>().getAllDeletedShifts();
    }
    if (role == 'Manager') {
      context.read<ShiftCubit>().getAllShifts();
      context.read<ShiftCubit>().getArea();
    }

    super.initState();
  }

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: customBackButton(context),
          title: Text('Shifts'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            height: 57.h,
            width: 57.w,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.addShiftScreen);
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
                Icons.post_add_outlined,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ),
        ),
        body: BlocConsumer<ShiftCubit, ShiftState>(
          listener: (context, state) {
            if (state is ShiftDeleteErrorState) {
              toast(text: state.error, color: Colors.red);
            }

            if (state is ShiftDeleteSuccessState) {
              toast(text: state.deleteShiftModel.message!, color: Colors.blue);

              context.read<ShiftCubit>().getAllDeletedShifts();
            }
            if (state is RestoreShiftSuccessState) {
              toast(text: state.message, color: Colors.blue);
            }
            if (state is ForceDeleteShiftSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.read<ShiftCubit>().getAllShifts();
              context.read<ShiftCubit>().getAllDeletedShifts();
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: (context.read<ShiftCubit>().allShiftsModel == null &&
                  context.read<ShiftCubit>().allShiftsDeletedModel == null),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(15),
                      filterAndSearchBuild(context, context.read<ShiftCubit>()),
                      verticalSpace(15),
                      SizedBox(
                        height: 45.h,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Total available width
                            double totalWidth = constraints.maxWidth;
                            // Gap between the containers
                            double gap = 10;
                            // Width for each container
                            double containerWidth = (totalWidth - gap) / 2;

                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (role == 'Admin') ? 2 : 1,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                    width: gap); // 10px gap between containers
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (role == 'Admin')
                                              ? index == 0
                                                  ? "${context.read<ShiftCubit>().allShiftsModel?.data?.shifts!.length ?? 0}"
                                                  : "${context.read<ShiftCubit>().allShiftsDeletedModel?.data?.length ?? 0}"
                                              : "${context.read<ShiftCubit>().allShiftsModel?.data?.shifts!.length ?? 0}",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: isSelected
                                                ? Colors.white
                                                : AppColor.primaryColor,
                                          ),
                                        ),
                                        horizontalSpace(5),
                                        Text(
                                          role == 'Admin'
                                              ? index == 0
                                                  ? "Total Shift"
                                                  : 'Deleted Shift'
                                              : "Total Shift",
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
                      Expanded(
                        child: state is ShiftLoadingState &&
                                (context.read<ShiftCubit>().allShiftsModel ==
                                        null &&
                                    context
                                            .read<ShiftCubit>()
                                            .allShiftsDeletedModel ==
                                        null)
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor))
                            : shiftListDetailsBuild(context, selectedIndex!),
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
