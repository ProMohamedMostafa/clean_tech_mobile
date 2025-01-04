import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/logic/shift_state.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/ui/widgets/adding_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shifts/ui/widgets/shift_list_details_build.dart';

class ShiftBody extends StatefulWidget {
  const ShiftBody({super.key});

  @override
  State<ShiftBody> createState() => _ShiftBodyState();
}

class _ShiftBodyState extends State<ShiftBody> {
  @override
  void initState() {
    context.read<ShiftCubit>().getAllShifts();
    context.read<ShiftCubit>().getAllDeletedShifts();
    super.initState();
  }

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: customBackButton(context),
          title:
              Text('Shift Management', style: TextStyles.font16BlackSemiBold),
          centerTitle: true,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            height: 50.h,
            width: 50.w,
            child: ElevatedButton(
              onPressed: () {
                // context.pushNamed(Routes.addOrganizationScreen);
              },
              style: ElevatedButton.styleFrom(
                padding: REdgeInsets.all(0),
                backgroundColor: AppColor.primaryColor,
                shape: CircleBorder(),
                side: BorderSide(
                  color: AppColor.secondaryColor,
                  width: 1,
                ),
              ),
              child: Icon(
                IconBroken.calendar,
                color: Colors.white,
                size: 26.sp,
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
              toast(text: state.message, color: Colors.blue);

              context.read<ShiftCubit>().getAllShifts();
              context.read<ShiftCubit>().getAllDeletedShifts();
            }
            if (state is RestoreShiftSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.read<ShiftCubit>().getAllShifts();
              context.read<ShiftCubit>().getAllDeletedShifts();
            }
            if (state is ForceDeleteShiftSuccessState) {
              toast(text: state.message, color: Colors.blue);
              context.read<ShiftCubit>().getAllShifts();
              context.read<ShiftCubit>().getAllDeletedShifts();
            }
          },
          builder: (context, state) {
            final cubit = context.read<ShiftCubit>();
            if (state is ShiftLoadingState || cubit.allShiftsModel == null) {
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            // Ensure data is non-null before building the UI
            final allShifts = cubit.allShiftsModel?.data;

            if (allShifts == null) {
              // Handle case where data fetching fails
              return const Center(
                child: Text("Failed to load organization details."),
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
                      filterAndSearchBuild(context, context.read<ShiftCubit>()),
                      verticalSpace(15),
                      SizedBox(
                        height: 45.h,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return horizontalSpace(10);
                                },
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
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
                                      width: 118.w,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
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
                                            index == 0
                                                ? "${context.read<ShiftCubit>().allShiftsModel!.data?.length ?? 0}"
                                                : "${context.read<ShiftCubit>().allShiftsDeletedModel!.data?.length ?? 0}",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColor.primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            index == 0
                                                ? "Total Shift"
                                                : 'Deleted Shift',
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
                              ),
                            ),
                            Expanded(flex: 1, child: addingBuild(context)),
                          ],
                        ),
                      ),
                      verticalSpace(10),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Shift Name",
                              style: TextStyles.font11GreyMedium,
                            ),
                            horizontalSpace(20),
                            Text(
                              "Shift Time",
                              style: TextStyles.font11GreyMedium,
                            ),
                            horizontalSpace(20),
                            Text(
                              "Shift Date",
                              style: TextStyles.font11GreyMedium,
                            ),
                            horizontalSpace(20),
                            Spacer()
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      shiftListDetailsBuild(context, selectedIndex!),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
