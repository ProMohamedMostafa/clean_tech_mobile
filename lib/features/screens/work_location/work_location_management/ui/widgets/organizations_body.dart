import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/organizations_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/organizations_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/organizations_filter_search_build.dart';

class OrganizationsBody extends StatefulWidget {
  const OrganizationsBody({super.key});

  @override
  State<OrganizationsBody> createState() => _OrganizationsBodyState();
}

class _OrganizationsBodyState extends State<OrganizationsBody> {
  List<String> tapList = [
    "Areas",
    "Cities",
    "Organizations",
    "Buildings",
    "Floors",
    "Points",
  ];
  @override
  void initState() {
    context.read<OrganizationsCubit>()
      ..getArea()
      ..getCity()
      ..getOrganization()
      ..getBuilding()
      ..getFloor()
      ..getPoint();

    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Work Location'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 57.h,
              width: 57.w,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.deleteOrganizationScreen,
                      arguments: selectedIndex);
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
                  IconBroken.delete,
                  color: Colors.white,
                  size: 27.sp,
                ),
              ),
            ),
            verticalSpace(10),
            SizedBox(
              height: 57.h,
              width: 57.w,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.addOrganizationScreen);
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
                  Icons.add_home_outlined,
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<OrganizationsCubit, OrganizationsState>(
        listener: (context, state) {
          if (state is AreaErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is AreaDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<OrganizationsCubit>().getArea();
          }
          if (state is AreaDeleteSuccessState ||
              state is CityDeleteSuccessState ||
              state is OrganizationDeleteSuccessState ||
              state is BuildingDeleteSuccessState ||
              state is FloorDeleteSuccessState ||
              state is PointDeleteSuccessState) {
            String? message;

            if (state is AreaDeleteSuccessState) {
              message = state.message;
            } else if (state is CityDeleteSuccessState) {
              message = state.message;
            } else if (state is OrganizationDeleteSuccessState) {
              message = state.message;
            } else if (state is BuildingDeleteSuccessState) {
              message = state.message;
            } else if (state is FloorDeleteSuccessState) {
              message = state.message;
            } else if (state is PointDeleteSuccessState) {
              message = state.message;
            }

            if (message != null) {
              toast(text: message, color: Colors.blue);
            }
            context.read<OrganizationsCubit>()
              ..getArea()
              ..getCity()
              ..getOrganization()
              ..getBuilding()
              ..getFloor()
              ..getPoint();
          }

          if (state is AreaDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    organizationsFilterAndDeleteBuild(context,
                        context.read<OrganizationsCubit>(), selectedIndex),
                    verticalSpace(15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 45.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return horizontalSpace(10);
                          },
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: tapList.length,
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
                                          ? "${context.read<OrganizationsCubit>().areaModel?.data?.areas?.length ?? 0}"
                                          : index == 1
                                              ? "${context.read<OrganizationsCubit>().cityModel?.data?.data?.length ?? 0}"
                                              : index == 2
                                                  ? "${context.read<OrganizationsCubit>().organizationModel?.data?.data?.length ?? 0}"
                                                  : index == 3
                                                      ? "${context.read<OrganizationsCubit>().buildingModel?.data?.data?.length ?? 0}"
                                                      : index == 4
                                                          ? "${context.read<OrganizationsCubit>().floorModel?.data?.data?.length ?? 0}"
                                                          : "${context.read<OrganizationsCubit>().pointModel?.data?.data?.length ?? 0}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColor.primaryColor,
                                      ),
                                    ),
                                    horizontalSpace(5),
                                    Text(
                                      tapList[index],
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
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    organizationDetailsBuild(context, selectedIndex!),
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
