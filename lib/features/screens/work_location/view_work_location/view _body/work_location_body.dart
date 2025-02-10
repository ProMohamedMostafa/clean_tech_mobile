import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view%20_body/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view%20_body/widgets/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view%20_body/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/view%20_body/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationDetailsBody extends StatefulWidget {
  final int selectedIndex;
  final int id;
  const WorkLocationDetailsBody(
      {super.key, required this.id, required this.selectedIndex});

  @override
  State<WorkLocationDetailsBody> createState() =>
      _WorkLocationDetailsBodyState();
}

class _WorkLocationDetailsBodyState extends State<WorkLocationDetailsBody>
    with TickerProviderStateMixin {
  late TabController controller;
  bool descTextShowFlag = false;
  int selectedIndex = 0;

  @override
  void initState() {
    if (widget.selectedIndex == 0) {
      context.read<WorkLocationCubit>().getAreaDetails(widget.id);
      context.read<WorkLocationCubit>().getAreaManagersDetails(widget.id);
      context.read<WorkLocationCubit>().getAreatree(widget.id);
    }
    if (widget.selectedIndex == 1) {
      context.read<WorkLocationCubit>().getCityDetails(widget.id);
      context.read<WorkLocationCubit>().getCityManagersDetails(widget.id);
      context.read<WorkLocationCubit>().getCitytree(widget.id);
    }
    if (widget.selectedIndex == 2) {
      context.read<WorkLocationCubit>().getOrganizationDetails(widget.id);
      context.read<WorkLocationCubit>().getOrganizationShiftsDetails(widget.id);
      context
          .read<WorkLocationCubit>()
          .getOrganizationManagersDetails(widget.id);
    }
    if (widget.selectedIndex == 3) {
      context.read<WorkLocationCubit>().getBuildingDetails(widget.id);
      context.read<WorkLocationCubit>().getBuildingManagersDetails(widget.id);
      context.read<WorkLocationCubit>().getBuildingShiftsDetails(widget.id);
    }
    if (widget.selectedIndex == 4) {
      context.read<WorkLocationCubit>().getFloorDetails(widget.id);
      context.read<WorkLocationCubit>().getFloorManagersDetails(widget.id);
      context.read<WorkLocationCubit>().getFloorShiftsDetails(widget.id);
    }
    if (widget.selectedIndex == 5) {
      context.read<WorkLocationCubit>().getPointDetails(widget.id);
      context.read<WorkLocationCubit>().getPointManagersDetails(widget.id);
      context.read<WorkLocationCubit>().getPointShiftsDetails(widget.id);
      context.read<WorkLocationCubit>().getPointTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistoryPoint(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesPoint(widget.id);
    }

    controller = TabController(length: 6, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // List<Map<String, String>> getCountsFromModel(AreaTreeModel model) {
  //   List<Map<String, String>> counts = [];

  //   if (model.data != null) {
  //     int cityCount = model.data!.cities?.length ?? 0;
  //     if (cityCount > 0) {
  //       counts.add({"count": "$cityCount", "title": "City"});
  //     }

  //     int organizationCount = model.data!.cities
  //             ?.expand((city) => city.organizations ?? [])
  //             .length ??
  //         0;
  //     if (organizationCount > 0) {
  //       counts.add({"count": "$organizationCount", "title": "Organization"});
  //     }

  //     int buildingCount = model.data!.cities
  //             ?.expand((city) => city.organizations ?? [])
  //             .expand((org) => org.buildings ?? [])
  //             .length ??
  //         0;
  //     if (buildingCount > 0) {
  //       counts.add({"count": "$buildingCount", "title": "Building"});
  //     }

  //     int floorCount = model.data!.cities
  //             ?.expand((city) => city.organizations ?? [])
  //             .expand((org) => org.buildings ?? [])
  //             .expand((building) => building.floors ?? [])
  //             .length ??
  //         0;
  //     if (floorCount > 0) {
  //       counts.add({"count": "$floorCount", "title": "Floor"});
  //     }

  //     int pointCount = model.data!.cities
  //             ?.expand((city) => city.organizations ?? [])
  //             .expand((org) => org.buildings ?? [])
  //             .expand((building) => building.floors ?? [])
  //             .expand((floor) => floor.points ?? [])
  //             .length ??
  //         0;
  //     if (pointCount > 0) {
  //       counts.add({"count": "$pointCount", "title": "Point"});
  //     }
  //   }

  //   return counts;
  // }

  // List<dynamic> getFilteredList(WorkLocationCubit cubit, int selectedIndex) {
  //   final areaTreeModel = cubit.areaTreeModel;
  //   if (areaTreeModel == null || areaTreeModel.data == null) return [];

  //   switch (selectedIndex) {
  //     case 0: // City
  //       return areaTreeModel.data!.cities ?? [];
  //     case 1: // Organization
  //       return areaTreeModel.data!.cities
  //               ?.expand((city) => city.organizations ?? [])
  //               .toList() ??
  //           [];
  //     case 2: // Building
  //       return areaTreeModel.data!.cities
  //               ?.expand((city) => city.organizations ?? [])
  //               .expand((org) => org.buildings ?? [])
  //               .toList() ??
  //           [];
  //     case 3: // Floor
  //       return areaTreeModel.data!.cities
  //               ?.expand((city) => city.organizations ?? [])
  //               .expand((org) => org.buildings ?? [])
  //               .expand((building) => building.floors ?? [])
  //               .toList() ??
  //           [];
  //     case 4: // Point
  //       return areaTreeModel.data!.cities
  //               ?.expand((city) => city.organizations ?? [])
  //               .expand((org) => org.buildings ?? [])
  //               .expand((building) => building.floors ?? [])
  //               .expand((floor) => floor.points ?? [])
  //               .toList() ??
  //           [];
  //     default:
  //       return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedIndex == 0
              ? 'Area details'
              : widget.selectedIndex == 1
                  ? 'City details'
                  : widget.selectedIndex == 2
                      ? 'Organization details'
                      : widget.selectedIndex == 3
                          ? 'Building details'
                          : widget.selectedIndex == 4
                              ? 'Floor details'
                              : 'Point details',
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
            onPressed: () {
              // generateAndSavePDF(context);
            },
            icon: Icon(
              CupertinoIcons.tray_arrow_down,
              color: Colors.red,
              size: 22.sp,
            ),
          ),
          IconButton(
              onPressed: () {
                widget.selectedIndex == 0
                    ? context.pushNamed(Routes.editAreaScreen,
                        arguments: widget.id)
                    : widget.selectedIndex == 1
                        ? context.pushNamed(Routes.editCityScreen,
                            arguments: widget.id)
                        : widget.selectedIndex == 2
                            ? context.pushNamed(Routes.editOrganizationScreen,
                                arguments: widget.id)
                            : widget.selectedIndex == 3
                                ? context.pushNamed(Routes.editBuildingScreen,
                                    arguments: widget.id)
                                : widget.selectedIndex == 4
                                    ? context.pushNamed(Routes.editFloorScreen,
                                        arguments: widget.id)
                                    : context.pushNamed(Routes.editPointScreen,
                                        arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<WorkLocationCubit, WorkLocationState>(
        listener: (context, state) {
          if (state is PointDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen);
          }
          if (state is PointDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if ((widget.selectedIndex == 0 &&
                  (context.read<WorkLocationCubit>().areaManagersDetailsModel == null ||
                      context.read<WorkLocationCubit>().areaDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().areaTreeModel ==
                          null)) ||
              (widget.selectedIndex == 1 &&
                  (context.read<WorkLocationCubit>().cityManagersDetailsModel == null ||
                      context.read<WorkLocationCubit>().cityDetailsModel ==
                          null)) ||
              (widget.selectedIndex == 2 &&
                  (context.read<WorkLocationCubit>().organizationDetailsModel == null ||
                      context.read<WorkLocationCubit>().organizationShiftsDetailsModel ==
                          null ||
                      context
                              .read<WorkLocationCubit>()
                              .organizationManagersDetailsModel ==
                          null)) ||
              (widget.selectedIndex == 3 &&
                  (context.read<WorkLocationCubit>().buildingDetailsModel == null ||
                      context.read<WorkLocationCubit>().buildingManagersDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().buildingShiftsDetailsModel ==
                          null)) ||
              (widget.selectedIndex == 4 &&
                  (context.read<WorkLocationCubit>().floorDetailsModel == null ||
                      context.read<WorkLocationCubit>().floorManagersDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().floorShiftsDetailsModel ==
                          null)) ||
              (widget.selectedIndex == 5 &&
                  (context.read<WorkLocationCubit>().pointDetailsModel == null ||
                      context.read<WorkLocationCubit>().pointManagersDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().pointShiftsDetailsModel == null))) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        border: Border.all(color: AppColor.secondaryColor)),
                    child: TabBar(
                        tabAlignment: TabAlignment.center,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: controller,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: controller.index == controller.index
                              ? AppColor.primaryColor
                              : Colors.transparent,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Work Location",
                              style: TextStyle(
                                  color: controller.index == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Managers",
                              style: TextStyle(
                                  color: controller.index == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Shifts",
                              style: TextStyle(
                                  color: controller.index == 2
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Tasks",
                              style: TextStyle(
                                  color: controller.index == 3
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Attendance",
                              style: TextStyle(
                                  color: controller.index == 4
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Leaves",
                              style: TextStyle(
                                  color: controller.index == 5
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ]),
                  ),
                  verticalSpace(20),
                  Expanded(
                    child: TabBarView(controller: controller, children: [
                      locationDetails(),
                      userDetails(),
                      shiftsDetails(),
                      tasksDetails(),
                      attendanceDetails(),
                      leavesDetails()
                    ]),
                  ),
                  verticalSpace(15),
                  (uId == widget.id)
                      ? SizedBox.shrink()
                      : DefaultElevatedButton(
                          name: S.of(context).deleteButton,
                          onPressed: () {
                            showCustomDialog(
                                context, S.of(context).deleteMessage, () {
                              widget.selectedIndex == 0
                                  ? context
                                      .read<WorkLocationCubit>()
                                      .deleteArea(widget.id)
                                  : widget.selectedIndex == 1
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .deleteCity(widget.id)
                                      : widget.selectedIndex == 2
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .deleteOrganization(widget.id)
                                          : widget.selectedIndex == 3
                                              ? context
                                                  .read<WorkLocationCubit>()
                                                  .deleteBuilding(widget.id)
                                              : widget.selectedIndex == 4
                                                  ? context
                                                      .read<WorkLocationCubit>()
                                                      .deleteFloor(widget.id)
                                                  : context
                                                      .read<WorkLocationCubit>()
                                                      .deletePoint(widget.id);
                            });
                          },
                          color: Colors.red,
                          height: 48,
                          width: double.infinity,
                          textStyles: TextStyles.font20Whitesemimedium),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget locationDetails() {
    // List<Map<String, String>> items =
    //     getCountsFromModel(context.read<WorkLocationCubit>().areaTreeModel!);
    // List<dynamic> filteredList =
    //     getFilteredList(context.read<WorkLocationCubit>(), selectedIndex);
    final workLocationDetailsModel;

    switch (widget.selectedIndex) {
      case 0:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().areaDetailsModel?.data;
        break;
      case 1:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().cityDetailsModel?.data;
        break;
      case 2:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().organizationDetailsModel?.data;
        break;
      case 3:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().buildingDetailsModel?.data;
        break;
      case 4:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().floorDetailsModel?.data;
        break;
      case 5:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().pointDetailsModel?.data;
        break;
      default:
        workLocationDetailsModel = null;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowDetailsBuild(
              context, "Country", workLocationDetailsModel.countryName!),
          Divider(),
          if (widget.selectedIndex >= 0) ...[
            rowDetailsBuild(
                context,
                "Area",
                widget.selectedIndex == 0
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.areaName!,
                color:
                    widget.selectedIndex == 0 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 1) ...[
            rowDetailsBuild(
                context,
                "City",
                widget.selectedIndex == 1
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.cityName!,
                color:
                    widget.selectedIndex == 1 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 2) ...[
            rowDetailsBuild(
                context,
                "Organization",
                widget.selectedIndex == 2
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.organizationName!,
                color:
                    widget.selectedIndex == 2 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 3) ...[
            rowDetailsBuild(
                context,
                "Building",
                widget.selectedIndex == 3
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.buildingName!,
                color:
                    widget.selectedIndex == 3 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 4) ...[
            rowDetailsBuild(
                context,
                "Floor",
                widget.selectedIndex == 4
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.floorName!,
                color:
                    widget.selectedIndex == 4 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 5) ...[
            rowDetailsBuild(context, "Point", workLocationDetailsModel.name!,
                color:
                    widget.selectedIndex == 5 ? AppColor.primaryColor : null),
            Divider()
          ],
          if (widget.selectedIndex >= 3) ...[
            Text(
              'Description',
              style: TextStyles.font14GreyRegular.copyWith(color: Colors.black),
            ),
            verticalSpace(5),
            Text(
              workLocationDetailsModel.description!,
              overflow: TextOverflow.ellipsis,
              maxLines: descTextShowFlag ? 40 : 3,
              style: TextStyles.font14GreyRegular,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  borderRadius: BorderRadius.circular(5.r),
                  onTap: () {
                    setState(() {
                      descTextShowFlag = !descTextShowFlag;
                    });
                  },
                  child: descTextShowFlag
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Read less",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Read more",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        )),
            ),
            Divider(),
          ],
          // SizedBox(
          //   height: 40.h,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: items.length,
          //     itemBuilder: (context, index) {
          //       bool isSelected = index == selectedIndex;
          //       return GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             selectedIndex = index;
          //           });
          //         },
          //         child: IntrinsicWidth(
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "${items[index]['count']} ${items[index]['title']}",
          //                   style: TextStyle(
          //                       color: isSelected
          //                           ? AppColor.primaryColor
          //                           : Colors.black,
          //                       fontWeight: FontWeight.normal,
          //                       fontSize: 11.sp),
          //                 ),
          //                 if (isSelected)
          //                   Container(
          //                     margin: EdgeInsets.only(top: 4),
          //                     height: 2.h,
          //                     color: AppColor.primaryColor,
          //                   ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // ListView.separated(
          //   shrinkWrap: true,
          //   physics: const ClampingScrollPhysics(),
          //   scrollDirection: Axis.vertical,
          //   itemCount: filteredList.length,
          //   separatorBuilder: (context, index) {
          //     return verticalSpace(10);
          //   },
          //   itemBuilder: (context, index) {
          //     return Column(
          //       mainAxisSize: MainAxisSize.min,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             context.pushNamed(Routes.workLocationDetailsScreen,
          //                 arguments: {
          //                   'id': context
          //                       .read<WorkLocationCubit>()
          //                       .areaTreeModel!
          //                       .data!
          //                       .cities![index]
          //                       .id!
          //                       .toInt(),
          //                   'selectedIndex': selectedIndex
          //                 });
          //           },
          //           child: Card(
          //             elevation: 1,
          //             margin: EdgeInsets.zero,
          //             color: Colors.white,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(11.r),
          //                 side: BorderSide(color: AppColor.secondaryColor)),
          //             child: ListTile(
          //               contentPadding: EdgeInsets.symmetric(horizontal: 20),
          //               minTileHeight: 72.h,
          //               // leading:
          //               // Icon(
          //               //   selectedIndex == 0
          //               //       ? Icons.location_city
          //               //       : selectedIndex == 1
          //               //           ? Icons.business
          //               //           : selectedIndex == 2
          //               //               ? Icons.house
          //               //               : selectedIndex == 3
          //               //                   ? Icons.stairs
          //               //                   : Icons.place,
          //               //   color: AppColor.thirdColor,
          //               // ),
          //               title: Text(
          //                 filteredList[index].name ?? '',
          //                 style: TextStyles.font14BlackSemiBold,
          //               ),
          //               subtitle: Text(
          //                 '',
          //                 style: TextStyles.font12GreyRegular,
          //               ),
          //               trailing: Icon(
          //                 Icons.arrow_forward_ios_rounded,
          //                 color: AppColor.thirdColor,
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     );
          //   },
          // )
        ],
      ),
    );
    // if (workLocationModel.data == null) {
    //   return Center(
    //     child: Text(
    //       "There's no data",
    //       style: TextStyles.font13Blackmedium,
    //     ),
    //   );
    // } else {
    //   return SingleChildScrollView(child: listWorkLocationItemBuild(context));
    // }
  }

  Widget userDetails() {
    final shiftModel =
        context.read<WorkLocationCubit>().pointShiftsDetailsModel!;
    if (shiftModel.data!.shifts == null || shiftModel.data!.shifts!.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: shiftModel.data!.shifts!.length,
              separatorBuilder: (context, index) {
                return verticalSpace(10);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    listShiftItemBuild(context, index),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget shiftsDetails() {
    final shiftModel =
        context.read<WorkLocationCubit>().pointShiftsDetailsModel!;
    if (shiftModel.data!.shifts == null || shiftModel.data!.shifts!.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: shiftModel.data!.shifts!.length,
              separatorBuilder: (context, index) {
                return verticalSpace(10);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    listShiftItemBuild(context, index),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget tasksDetails() {
    final taskModel = context.read<WorkLocationCubit>().allPointTasksModel!;
    if (taskModel.data!.data == null || taskModel.data!.data!.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: taskModel.data!.data!.length,
      separatorBuilder: (context, index) {
        return verticalSpace(10);
      },
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTaskCardItem(context, index),
          ],
        );
      },
    );
  }

  Widget attendanceDetails() {
    final attendanceData = context
        .read<WorkLocationCubit>()
        .attendanceHistoryPointModel
        ?.data
        ?.data;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return Column(
      children: [
        Divider(),
        verticalSpace(5),
        SizedBox(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyles.font16BlackSemiBold,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.secondaryColor),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: AppColor.primaryColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: attendanceData.length,
          separatorBuilder: (context, index) {
            return verticalSpace(10);
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAttendanceCardItem(context, index),
              ],
            );
          },
        )
      ],
    );
  }

  Widget leavesDetails() {
    final attendanceData = context
        .read<WorkLocationCubit>()
        .attendanceLeavesPointModel
        ?.data
        ?.data;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return Column(
      children: [
        Divider(),
        verticalSpace(5),
        SizedBox(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyles.font16BlackSemiBold,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.secondaryColor),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: AppColor.primaryColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: attendanceData.length,
          separatorBuilder: (context, index) {
            return verticalSpace(10);
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildLeavesCardItem(context, index),
              ],
            );
          },
        )
      ],
    );
  }
}
