import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

class FilterAndSearchWidget extends StatelessWidget {
  final int selectedIndex;
  const FilterAndSearchWidget({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final WorkLocationCubit cubit = context.read<WorkLocationCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextFormField(
            color: AppColor.secondaryColor,
            perfixIcon: Icon(IconBroken.search),
            controller: cubit.searchController,
            hint: 'Find name of work location',
            keyboardType: TextInputType.text,
            onlyRead: false,
            onChanged: (searchedCharacter) {
              selectedIndex == 0
                  ? cubit.getArea()
                  : selectedIndex == 1
                      ? cubit.getCity()
                      : selectedIndex == 2
                          ? cubit.getOrganization()
                          : selectedIndex == 3
                              ? cubit.getBuilding()
                              : selectedIndex == 4
                                  ? cubit.getFloor()
                                  : selectedIndex == 5
                                      ? cubit.getSection()
                                      : cubit.getPoint();
            },
          ),
        ),
        horizontalSpace(10),
        InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider(
                  create: (context) {
                    switch (selectedIndex) {
                      case 0:
                        return FilterDialogCubit()..getCountry(false, true);
                      case 1:
                        return FilterDialogCubit()..getCountry(false, true);
                      case 2:
                        return FilterDialogCubit()..getArea();
                      case 3:
                        return FilterDialogCubit()..getCity();
                      case 4:
                        return FilterDialogCubit()..getOrganization();
                      case 5:
                        return FilterDialogCubit()..getBuilding();
                      case 6:
                        return FilterDialogCubit()..getFloor();

                      default:
                        return FilterDialogCubit();
                    }
                  },
                  child: selectedIndex == 0
                      ? FilterDialogWidget(
                          index: 'W-a',
                          onPressed: (data) {
                            cubit.filterModel = data;
                            cubit.getArea();
                          },
                        )
                      : selectedIndex == 1
                          ? FilterDialogWidget(
                              index: 'W-c',
                              onPressed: (data) {
                                cubit.filterModel = data;
                                cubit.getCity();
                              },
                            )
                          : selectedIndex == 2
                              ? FilterDialogWidget(
                                  index: 'W-o',
                                  onPressed: (data) {
                                    cubit.filterModel = data;
                                    cubit.getOrganization();
                                  },
                                )
                              : selectedIndex == 3
                                  ? FilterDialogWidget(
                                      index: 'W-b',
                                      onPressed: (data) {
                                        cubit.filterModel = data;
                                        cubit.getBuilding();
                                      },
                                    )
                                  : selectedIndex == 4
                                      ? FilterDialogWidget(
                                          index: 'W-f',
                                          onPressed: (data) {
                                            cubit.filterModel = data;
                                            cubit.getFloor();
                                          },
                                        )
                                      : selectedIndex == 5
                                          ? FilterDialogWidget(
                                              index: 'W-s',
                                              onPressed: (data) {
                                                cubit.filterModel = data;
                                                cubit.getSection();
                                              },
                                            )
                                          : FilterDialogWidget(
                                              index: 'W-p',
                                              onPressed: (data) {
                                                cubit.filterModel = data;
                                                cubit.getPoint();
                                              },
                                            ),
                );
              },
            );
          },
          child: Container(
            height: 47.h,
            width: 49.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.secondaryColor)),
            child: Icon(
              Icons.tune,
              color: AppColor.primaryColor,
              size: 25.sp,
            ),
          ),
        ),
      ],
    );
  }
}
