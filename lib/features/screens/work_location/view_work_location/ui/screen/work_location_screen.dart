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
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/cleaner_item_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/manager_item_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/supervisor_item_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationDetailsScreen extends StatefulWidget {
  final int selectedIndex;
  final int id;
  const WorkLocationDetailsScreen(
      {super.key, required this.id, required this.selectedIndex});

  @override
  State<WorkLocationDetailsScreen> createState() =>
      _WorkLocationDetailsScreenState();
}

class _WorkLocationDetailsScreenState extends State<WorkLocationDetailsScreen>
    with TickerProviderStateMixin {
  late TabController controller;
  bool descTextShowFlag = false;
  int selectedTreeIndex = 0;

  @override
  void initState() {
    if (widget.selectedIndex == 0) {
      context.read<WorkLocationCubit>().getAreaUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getareaTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistoryArea(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesArea(widget.id);
      context.read<WorkLocationCubit>().getAreatree(widget.id);
    }
    if (widget.selectedIndex == 1) {
      context.read<WorkLocationCubit>().getCityUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getCityTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistoryCity(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesCity(widget.id);
      context.read<WorkLocationCubit>().getCitytree(widget.id);
    }
    if (widget.selectedIndex == 2) {
      context.read<WorkLocationCubit>().getOrganizationUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getorganizationTasks(widget.id);
      context
          .read<WorkLocationCubit>()
          .getAttendanceHistoryOrganization(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesOrganization(widget.id);
      context.read<WorkLocationCubit>().getOrganizationtree(widget.id);
    }
    if (widget.selectedIndex == 3) {
      context.read<WorkLocationCubit>().getBuildingUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getbuildingTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistoryBuilding(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesBuilding(widget.id);
      context.read<WorkLocationCubit>().getBuildingtree(widget.id);
    }
    if (widget.selectedIndex == 4) {
      context.read<WorkLocationCubit>().getFloorUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getfloorTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistoryFloor(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesFloor(widget.id);
      context.read<WorkLocationCubit>().getFloortree(widget.id);
    }
    if (widget.selectedIndex == 5) {
      context.read<WorkLocationCubit>().getSectionUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getSectionTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistorySection(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesSection(widget.id);
      context.read<WorkLocationCubit>().getSectiontree(widget.id);
    }
    if (widget.selectedIndex == 6) {
      context.read<WorkLocationCubit>().getPointUsersDetails(widget.id);
      context.read<WorkLocationCubit>().getPointTasks(widget.id);
      context.read<WorkLocationCubit>().getAttendanceHistoryPoint(widget.id);
      context.read<WorkLocationCubit>().getAllLeavesPoint(widget.id);
    }

    controller = TabController(length: 8, vsync: this);
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

  List<Map<String, String>> getAreaCountsFromModel(AreaTreeModel model) {
    List<Map<String, String>> counts = [];

    if (model.data != null) {
      int cityCount = model.data!.cities?.length ?? 0;
      if (cityCount > 0) {
        counts.add({"count": "$cityCount", "title": "City"});
      }

      int organizationCount = model.data!.cities
              ?.expand((city) => city.organizations ?? [])
              .length ??
          0;
      if (organizationCount > 0) {
        counts.add({"count": "$organizationCount", "title": "Organization"});
      }

      int buildingCount = model.data!.cities
              ?.expand((city) => city.organizations ?? [])
              .expand((org) => org.buildings ?? [])
              .length ??
          0;
      if (buildingCount > 0) {
        counts.add({"count": "$buildingCount", "title": "Building"});
      }

      int floorCount = model.data!.cities
              ?.expand((city) => city.organizations ?? [])
              .expand((org) => org.buildings ?? [])
              .expand((building) => building.floors ?? [])
              .length ??
          0;
      if (floorCount > 0) {
        counts.add({"count": "$floorCount", "title": "Floor"});
      }

      int sectionCount = model.data!.cities
              ?.expand((city) => city.organizations ?? [])
              .expand((org) => org.buildings ?? [])
              .expand((building) => building.floors ?? [])
              .expand((floor) => floor.sections ?? [])
              .length ??
          0;
      if (sectionCount > 0) {
        counts.add({"count": "$sectionCount", "title": "Section"});
      }
      int pointCount = model.data!.cities
              ?.expand((city) => city.organizations ?? [])
              .expand((org) => org.buildings ?? [])
              .expand((building) => building.floors ?? [])
              .expand((floor) => floor.sections ?? [])
              .expand((section) => section.points ?? [])
              .length ??
          0;
      if (pointCount > 0) {
        counts.add({"count": "$pointCount", "title": "Point"});
      }
    }

    return counts;
  }

  List<Map<String, String>> getCityCountsFromModel(CityTreeModel model) {
    List<Map<String, String>> counts = [];

    if (model.data != null) {
      // Organization Count
      int organizationCount = model.data!.organizations?.length ?? 0;
      if (organizationCount > 0) {
        counts.add({"count": "$organizationCount", "title": "Organization"});
      }

      // Building Count
      int buildingCount = model.data!.organizations
              ?.expand((org) => org.buildings ?? [])
              .length ??
          0;
      if (buildingCount > 0) {
        counts.add({"count": "$buildingCount", "title": "Building"});
      }

      // Floor Count
      int floorCount = model.data!.organizations
              ?.expand((org) => org.buildings ?? [])
              .expand((building) => building.floors ?? [])
              .length ??
          0;
      if (floorCount > 0) {
        counts.add({"count": "$floorCount", "title": "Floor"});
      }

      int sectionCount = model.data!.organizations
              ?.expand((org) => org.buildings ?? [])
              .expand((building) => building.floors ?? [])
              .expand((floor) => floor.sections ?? [])
              .length ??
          0;
      if (sectionCount > 0) {
        counts.add({"count": "$sectionCount", "title": "Section"});
      }

      int pointCount = model.data!.organizations
              ?.expand((org) => org.buildings ?? [])
              .expand((building) => building.floors ?? [])
              .expand((floor) => floor.sections ?? [])
              .expand((section) => section.points ?? [])
              .length ??
          0;
      if (pointCount > 0) {
        counts.add({"count": "$pointCount", "title": "Point"});
      }
    }

    return counts;
  }

  List<Map<String, String>> getOrganizationCountsFromModel(
      OrganizationTreeModel model) {
    List<Map<String, String>> counts = [];

    if (model.data != null) {
      int buildingCount = model.data!.buildings?.length ?? 0;
      if (buildingCount > 0) {
        counts.add({"count": "$buildingCount", "title": "Building"});
      }

      int floorCount = model.data!.buildings
              ?.expand((building) => building.floors ?? [])
              .length ??
          0;
      if (floorCount > 0) {
        counts.add({"count": "$floorCount", "title": "Floor"});
      }

      int sectionCount = model.data!.buildings
              ?.expand((building) => building.floors ?? [])
              .expand((floor) => floor.sections ?? [])
              .length ??
          0;
      if (sectionCount > 0) {
        counts.add({"count": "$sectionCount", "title": "Section"});
      }

      int pointCount = model.data!.buildings
              ?.expand((building) => building.floors ?? [])
              .expand((floor) => floor.sections ?? [])
              .expand((section) => section.points ?? [])
              .length ??
          0;
      if (pointCount > 0) {
        counts.add({"count": "$pointCount", "title": "Point"});
      }
    }

    return counts;
  }

  List<Map<String, String>> getBuildingCountsFromModel(
      BuildingTreeModel model) {
    List<Map<String, String>> counts = [];

    if (model.data != null) {
      // Floor Count
      int floorCount = model.data!.floors?.length ?? 0;
      if (floorCount > 0) {
        counts.add({"count": "$floorCount", "title": "Floor"});
      }

      int sectionCount =
          model.data!.floors?.expand((floor) => floor.sections ?? []).length ??
              0;
      if (sectionCount > 0) {
        counts.add({"count": "$sectionCount", "title": "Section"});
      }

      // Points Count
      int pointCount = model.data!.floors
              ?.expand((floor) => floor.sections ?? [])
              .expand((section) => section.points ?? [])
              .length ??
          0;
      if (pointCount > 0) {
        counts.add({"count": "$pointCount", "title": "Point"});
      }
    }

    return counts;
  }

  List<Map<String, String>> getFloorCountsFromModel(FloorTreeModel model) {
    List<Map<String, String>> counts = [];

    if (model.data != null) {
      int sectionCount = model.data!.sections?.length ?? 0;
      if (sectionCount > 0) {
        counts.add({"count": "$sectionCount", "title": "Section"});
      }

      int pointCount = model.data!.sections
              ?.expand((section) => section.points ?? [])
              .length ??
          0;
      if (pointCount > 0) {
        counts.add({"count": "$pointCount", "title": "Point"});
      }
    }

    return counts;
  }

  List<Map<String, String>> getSectionCountsFromModel(SectionTreeModel model) {
    List<Map<String, String>> counts = [];

    if (model.data != null) {
      int pointCount = model.data!.points?.length ?? 0;
      if (pointCount > 0) {
        counts.add({"count": "$pointCount", "title": "Point"});
      }
    }

    return counts;
  }

  List<dynamic> getAreaFilteredList(
      WorkLocationCubit cubit, int selectedIndex) {
    final areaTreeModel = cubit.areaTreeModel;
    if (areaTreeModel == null || areaTreeModel.data == null) return [];

    switch (selectedIndex) {
      case 0: // City
        return areaTreeModel.data!.cities ?? [];
      case 1: // Organization
        return areaTreeModel.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .toList() ??
            [];
      case 2: // Building
        return areaTreeModel.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .toList() ??
            [];
      case 3: // Floor
        return areaTreeModel.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .toList() ??
            [];
      case 4: // section
        return areaTreeModel.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .toList() ??
            [];
      case 5: // Point
        return areaTreeModel.data!.cities
                ?.expand((city) => city.organizations ?? [])
                .expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  List<dynamic> getCityFilteredList(
      WorkLocationCubit cubit, int selectedIndex) {
    final cityTreeModel = cubit.cityTreeModel;
    if (cityTreeModel == null || cityTreeModel.data == null) return [];

    switch (selectedIndex) {
      case 0: // Organization
        return cityTreeModel.data!.organizations ?? [];
      case 1: // Building
        return cityTreeModel.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .toList() ??
            [];
      case 2: // Floor
        return cityTreeModel.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .toList() ??
            [];
      case 3: // section
        return cityTreeModel.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .toList() ??
            [];
      case 4: // Point
        return cityTreeModel.data!.organizations
                ?.expand((org) => org.buildings ?? [])
                .expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  List<dynamic> getOrganizationFilteredList(
      WorkLocationCubit cubit, int selectedIndex) {
    final organizationTreeModel = cubit.organizationTreeModel;
    if (organizationTreeModel == null || organizationTreeModel.data == null)
      return [];

    switch (selectedIndex) {
      case 0: // Building
        return organizationTreeModel.data!.buildings ?? [];
      case 1: // Floor
        return organizationTreeModel.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .toList() ??
            [];
      case 2: // section
        return organizationTreeModel.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .toList() ??
            [];
      case 3: // Point
        return organizationTreeModel.data!.buildings
                ?.expand((building) => building.floors ?? [])
                .expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  List<dynamic> getBuildingFilteredList(
      WorkLocationCubit cubit, int selectedIndex) {
    final buildingTreeModel = cubit.buildingTreeModel;
    if (buildingTreeModel == null || buildingTreeModel.data == null) return [];

    switch (selectedIndex) {
      case 0: // Floor
        return buildingTreeModel.data!.floors ?? [];
      case 1: // section
        return buildingTreeModel.data!.floors
                ?.expand((floor) => floor.sections ?? [])
                .toList() ??
            [];
      case 2: // Point
        return buildingTreeModel.data!.floors
                ?.expand((floor) => floor.sections ?? [])
                .expand((section) => section.points ?? [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  List<dynamic> getFloorFilteredList(
      WorkLocationCubit cubit, int selectedIndex) {
    final floorTreeModel = cubit.floorTreeModel;
    if (floorTreeModel == null || floorTreeModel.data == null) return [];

    switch (selectedIndex) {
      case 0: // section
        return floorTreeModel.data!.sections ?? [];
      case 1: // Points
        return floorTreeModel.data!.sections
                ?.expand((section) => section.points ?? [])
                .toList() ??
            [];
      default:
        return [];
    }
  }

  List<dynamic> getSectionFilteredList(
      WorkLocationCubit cubit, int selectedIndex) {
    final sectionTreeModel = cubit.sectionTreeModel;
    if (sectionTreeModel == null || sectionTreeModel.data == null) return [];

    switch (selectedIndex) {
      case 0: // Points
        return sectionTreeModel.data!.points ?? [];
      default:
        return [];
    }
  }

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
                              : widget.selectedIndex == 5
                                  ? 'Section details'
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
          if (role == 'Admin')
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
                                      ? context.pushNamed(
                                          Routes.editFloorScreen,
                                          arguments: widget.id)
                                      : widget.selectedIndex == 5
                                          ? context.pushNamed(
                                              Routes.editSectionScreen,
                                              arguments: widget.id)
                                          : context.pushNamed(
                                              Routes.editPointScreen,
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
                  (context.read<WorkLocationCubit>().areaUsersDetailsModel == null ||
                      context
                              .read<WorkLocationCubit>()
                              .areaTreeModel ==
                          null)) ||
              (widget.selectedIndex == 1 &&
                  (context.read<WorkLocationCubit>().cityUsersDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().cityTreeModel ==
                          null)) ||
              (widget.selectedIndex == 2 &&
                  (context.read<WorkLocationCubit>().organizationUsersShiftDetailsModel == null ||
                      context.read<WorkLocationCubit>().organizationTreeModel ==
                          null)) ||
              (widget.selectedIndex == 3 &&
                  (context.read<WorkLocationCubit>().buildingUsersShiftDetailsModel == null ||
                      context.read<WorkLocationCubit>().buildingTreeModel ==
                          null)) ||
              (widget.selectedIndex == 4 &&
                  (context.read<WorkLocationCubit>().floorUsersShiftDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().floorTreeModel ==
                          null)) ||
              (widget.selectedIndex == 5 &&
                  (context.read<WorkLocationCubit>().sectionUsersShiftDetailsModel ==
                          null ||
                      context.read<WorkLocationCubit>().sectionTreeModel ==
                          null)) ||
              (widget.selectedIndex == 6 &&
                  (context.read<WorkLocationCubit>().pointUsersDetailsModel ==
                      null))) {
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
                              "Supervisors",
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
                              "Cleaners",
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
                              "Shifts",
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
                              "Tasks",
                              style: TextStyle(
                                  color: controller.index == 5
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
                                  color: controller.index == 6
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
                                  color: controller.index == 7
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
                      managerDetails(),
                      supervisorDetails(),
                      cleanerDetails(),
                      shiftsDetails(),
                      tasksDetails(),
                      attendanceDetails(),
                      leavesDetails()
                    ]),
                  ),
                  verticalSpace(15),
                  if (role == 'Admin')
                    DefaultElevatedButton(
                        name: S.of(context).deleteButton,
                        onPressed: () {
                          showCustomDialog(context, S.of(context).deleteMessage,
                              () {
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
                                                : widget.selectedIndex == 5
                                                    ? context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .deleteSection(
                                                            widget.id)
                                                    : context
                                                        .read<
                                                            WorkLocationCubit>()
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
    final workLocationCubit = context.read<WorkLocationCubit>();

    List<Map<String, String>> items;
    List<dynamic> filteredList;

    switch (widget.selectedIndex) {
      case 0:
        items = getAreaCountsFromModel(workLocationCubit.areaTreeModel!);
        filteredList =
            getAreaFilteredList(workLocationCubit, selectedTreeIndex);
        break;
      case 1:
        items = getCityCountsFromModel(workLocationCubit.cityTreeModel!);
        filteredList =
            getCityFilteredList(workLocationCubit, selectedTreeIndex);
        break;
      case 2:
        items = getOrganizationCountsFromModel(
            workLocationCubit.organizationTreeModel!);
        filteredList =
            getOrganizationFilteredList(workLocationCubit, selectedTreeIndex);
        break;
      case 3:
        items =
            getBuildingCountsFromModel(workLocationCubit.buildingTreeModel!);
        filteredList =
            getBuildingFilteredList(workLocationCubit, selectedTreeIndex);
        break;
      case 4:
        items = getFloorCountsFromModel(workLocationCubit.floorTreeModel!);
        filteredList =
            getFloorFilteredList(workLocationCubit, selectedTreeIndex);
        break;
      case 5:
        items = getSectionCountsFromModel(workLocationCubit.sectionTreeModel!);
        filteredList =
            getSectionFilteredList(workLocationCubit, selectedTreeIndex);
        break;
      default:
        items = [];
        filteredList = [];
    }
    final workLocationDetailsModel;

    switch (widget.selectedIndex) {
      case 0:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().areaUsersDetailsModel?.data;
        break;
      case 1:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().cityUsersDetailsModel?.data;
        break;
      case 2:
        workLocationDetailsModel = context
            .read<WorkLocationCubit>()
            .organizationUsersShiftDetailsModel
            ?.data;
        break;
      case 3:
        workLocationDetailsModel = context
            .read<WorkLocationCubit>()
            .buildingUsersShiftDetailsModel
            ?.data;
        break;
      case 4:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().floorUsersShiftDetailsModel?.data;
        break;
      case 5:
        workLocationDetailsModel = context
            .read<WorkLocationCubit>()
            .sectionUsersShiftDetailsModel
            ?.data;
        break;
      case 6:
        workLocationDetailsModel =
            context.read<WorkLocationCubit>().pointUsersDetailsModel?.data;
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
            rowDetailsBuild(
                context,
                "Section",
                widget.selectedIndex == 5
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.organizationName!,
                color:
                    widget.selectedIndex == 2 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 6) ...[
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
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                bool isSelected = index == selectedTreeIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTreeIndex = index;
                    });
                  },
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${items[index]['count']} ${items[index]['title']}",
                            style: TextStyle(
                                color: isSelected
                                    ? AppColor.primaryColor
                                    : Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 11.sp),
                          ),
                          if (isSelected)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              height: 2.h,
                              color: AppColor.primaryColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: filteredList.length,
            separatorBuilder: (context, index) {
              return verticalSpace(10);
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.selectedIndex == 0) {
                        context.pushNamed(Routes.workLocationDetailsScreen,
                            arguments: items[selectedTreeIndex]['title'] ==
                                    'City'
                                ? {
                                    'id': context
                                        .read<WorkLocationCubit>()
                                        .areaTreeModel!
                                        .data!
                                        .cities![index]
                                        .id!
                                        .toInt(),
                                    'selectedIndex': 1
                                  }
                                : items[selectedTreeIndex]['title'] ==
                                        'Organization'
                                    ? {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .areaTreeModel!
                                            .data!
                                            .cities![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 2
                                      }
                                    : items[selectedTreeIndex]['title'] ==
                                            'Building'
                                        ? {
                                            'id': context
                                                .read<WorkLocationCubit>()
                                                .areaTreeModel!
                                                .data!
                                                .cities![index]
                                                .id!
                                                .toInt(),
                                            'selectedIndex': 3
                                          }
                                        : items[selectedTreeIndex]['title'] ==
                                                'Floor'
                                            ? {
                                                'id': context
                                                    .read<WorkLocationCubit>()
                                                    .areaTreeModel!
                                                    .data!
                                                    .cities![index]
                                                    .id!
                                                    .toInt(),
                                                'selectedIndex': 4
                                              }
                                            : items[selectedTreeIndex]
                                                        ['title'] ==
                                                    'Section'
                                                ? {
                                                    'id': context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .areaTreeModel!
                                                        .data!
                                                        .cities![index]
                                                        .id!
                                                        .toInt(),
                                                    'selectedIndex': 5
                                                  }
                                                : {
                                                    'id': context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .areaTreeModel!
                                                        .data!
                                                        .cities![index]
                                                        .id!
                                                        .toInt(),
                                                    'selectedIndex': 6
                                                  });
                      }
                      if (widget.selectedIndex == 1) {
                        context.pushNamed(Routes.workLocationDetailsScreen,
                            arguments: items[selectedTreeIndex]['title'] ==
                                    'Organization'
                                ? {
                                    'id': context
                                        .read<WorkLocationCubit>()
                                        .cityTreeModel!
                                        .data!
                                        .organizations![index]
                                        .id!
                                        .toInt(),
                                    'selectedIndex': 2
                                  }
                                : items[selectedTreeIndex]['title'] ==
                                        'Building'
                                    ? {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .cityTreeModel!
                                            .data!
                                            .organizations![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 3
                                      }
                                    : items[selectedTreeIndex]['title'] ==
                                            'Floor'
                                        ? {
                                            'id': context
                                                .read<WorkLocationCubit>()
                                                .cityTreeModel!
                                                .data!
                                                .organizations![index]
                                                .id!
                                                .toInt(),
                                            'selectedIndex': 4
                                          }
                                        : items[selectedTreeIndex]['title'] ==
                                                'Section'
                                            ? {
                                                'id': context
                                                    .read<WorkLocationCubit>()
                                                    .cityTreeModel!
                                                    .data!
                                                    .organizations![index]
                                                    .id!
                                                    .toInt(),
                                                'selectedIndex': 5
                                              }
                                            : {
                                                'id': context
                                                    .read<WorkLocationCubit>()
                                                    .cityTreeModel!
                                                    .data!
                                                    .organizations![index]
                                                    .id!
                                                    .toInt(),
                                                'selectedIndex': 6
                                              });
                      }

                      if (widget.selectedIndex == 2) {
                        context.pushNamed(Routes.workLocationDetailsScreen,
                            arguments: items[selectedTreeIndex]['title'] ==
                                    'Building'
                                ? {
                                    'id': context
                                        .read<WorkLocationCubit>()
                                        .organizationTreeModel!
                                        .data!
                                        .buildings![index]
                                        .id!
                                        .toInt(),
                                    'selectedIndex': 3
                                  }
                                : items[selectedTreeIndex]['title'] == 'Floor'
                                    ? {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .organizationTreeModel!
                                            .data!
                                            .buildings![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 4
                                      }
                                    : items[selectedTreeIndex]['title'] ==
                                            'Section'
                                        ? {
                                            'id': context
                                                .read<WorkLocationCubit>()
                                                .organizationTreeModel!
                                                .data!
                                                .buildings![index]
                                                .id!
                                                .toInt(),
                                            'selectedIndex': 5
                                          }
                                        : {
                                            'id': context
                                                .read<WorkLocationCubit>()
                                                .organizationTreeModel!
                                                .data!
                                                .buildings![index]
                                                .id!
                                                .toInt(),
                                            'selectedIndex': 6
                                          });
                      }
                      if (widget.selectedIndex == 3) {
                        context.pushNamed(Routes.workLocationDetailsScreen,
                            arguments: items[selectedTreeIndex]['title'] ==
                                    'Floor'
                                ? {
                                    'id': context
                                        .read<WorkLocationCubit>()
                                        .buildingTreeModel!
                                        .data!
                                        .floors![index]
                                        .id!
                                        .toInt(),
                                    'selectedIndex': 4
                                  }
                                : items[selectedTreeIndex]['title'] == 'Section'
                                    ? {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .buildingTreeModel!
                                            .data!
                                            .floors![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 5
                                      }
                                    : {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .buildingTreeModel!
                                            .data!
                                            .floors![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 6
                                      });
                      }
                      if (widget.selectedIndex == 4) {
                        context.pushNamed(Routes.workLocationDetailsScreen,
                            arguments:
                                items[selectedTreeIndex]['title'] == 'Floor'
                                    ? {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .floorTreeModel!
                                            .data!
                                            .sections![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 5
                                      }
                                    : {
                                        'id': context
                                            .read<WorkLocationCubit>()
                                            .floorTreeModel!
                                            .data!
                                            .sections![index]
                                            .id!
                                            .toInt(),
                                        'selectedIndex': 6
                                      });
                      }

                      if (widget.selectedIndex == 5) {
                        context.pushNamed(Routes.workLocationDetailsScreen,
                            arguments: {
                              'id': context
                                  .read<WorkLocationCubit>()
                                  .sectionTreeModel!
                                  .data!
                                  .points![index]
                                  .id!
                                  .toInt(),
                              'selectedIndex': 6
                            });
                      }
                    },
                    child: Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r),
                          side: BorderSide(color: AppColor.secondaryColor)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        minTileHeight: 72.h,
                        title: Text(
                          filteredList[index].name ?? '',
                          style: TextStyles.font14BlackSemiBold,
                        ),
                        subtitle: Text(
                          items[selectedTreeIndex]['title'] == "Point"
                              ? filteredList[index].sectionName
                              : filteredList[index].previousName ?? '',
                          style: TextStyles.font12GreyRegular,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColor.thirdColor,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget managerDetails() {
    final managersData = widget.selectedIndex == 0
        ? context
            .read<WorkLocationCubit>()
            .areaUsersDetailsModel!
            .data!
            .users!
            .where((user) => user.role == 'Manager')
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationCubit>()
                .cityUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                            : widget.selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                : null;

    if (managersData == null || managersData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: managersData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              managerListItemBuild(context, index, widget.selectedIndex),
              Divider(
                color: Colors.grey[300],
                height: 0.1,
              ),
            ],
          );
        },
      );
    }
  }

  Widget supervisorDetails() {
    final supervisorsData = widget.selectedIndex == 0
        ? context
            .read<WorkLocationCubit>()
            .areaUsersDetailsModel!
            .data!
            .users!
            .where((user) => user.role == 'Supervisor')
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationCubit>()
                .cityUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Supervisor')
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Supervisor')
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Supervisor')
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Supervisor')
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Supervisor')
                            : widget.selectedIndex == 6
                                ? context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Supervisor')
                                : null;

    if (supervisorsData == null || supervisorsData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: supervisorsData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              supervisorListItemBuild(context, index, widget.selectedIndex),
              Divider(
                color: Colors.grey[300],
                height: 0.1,
              ),
            ],
          );
        },
      );
    }
  }

  Widget cleanerDetails() {
    final cleanersData = widget.selectedIndex == 0
        ? context
            .read<WorkLocationCubit>()
            .areaUsersDetailsModel!
            .data!
            .users!
            .where((user) => user.role == 'Cleaner')
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationCubit>()
                .cityUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Cleaner')
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Cleaner')
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Cleaner')
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Cleaner')
                            : widget.selectedIndex == 6
                                ? context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Cleaner')
                                : null;

    if (cleanersData == null || cleanersData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: cleanersData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cleanerListItemBuild(context, index, widget.selectedIndex),
              Divider(
                color: Colors.grey[300],
                height: 0.1,
              ),
            ],
          );
        },
      );
    }
  }

  Widget shiftsDetails() {
    final shiftModel = widget.selectedIndex == 0
        ? null
        : widget.selectedIndex == 1
            ? null
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .shifts
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .shifts
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .shifts
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .shifts
                            : null;

    if (shiftModel == null || shiftModel.isEmpty) {
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
              itemCount: shiftModel.length,
              separatorBuilder: (context, index) {
                return verticalSpace(10);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    listShiftItemBuild(context, index, widget.selectedIndex),
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
    final taskModel = widget.selectedIndex == 0
        ? context.read<WorkLocationCubit>().allareaTasksModel
        : widget.selectedIndex == 1
            ? context.read<WorkLocationCubit>().allcityTasksModel
            : widget.selectedIndex == 2
                ? context.read<WorkLocationCubit>().allorganizationTasksModel
                : widget.selectedIndex == 3
                    ? context.read<WorkLocationCubit>().allbuildingTasksModel
                    : widget.selectedIndex == 4
                        ? context.read<WorkLocationCubit>().allfloorTasksModel
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationCubit>()
                                .allSectionTasksModel
                            : context
                                .read<WorkLocationCubit>()
                                .allPointTasksModel;

    if (taskModel?.data?.data == null || taskModel!.data!.data!.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
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
                  buildTaskCardItem(context, index, widget.selectedIndex),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget attendanceDetails() {
    final attendanceData = widget.selectedIndex == 0
        ? context
            .read<WorkLocationCubit>()
            .attendanceHistoryAreaModel
            ?.data
            ?.data
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationCubit>()
                .attendanceHistoryCityModel
                ?.data
                ?.data
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationCubit>()
                    .attendanceHistoryOrganizationModel
                    ?.data
                    ?.data
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationCubit>()
                        .attendanceHistoryBuildingModel
                        ?.data
                        ?.data
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationCubit>()
                            .attendanceHistoryFloorModel
                            ?.data
                            ?.data
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationCubit>()
                                .attendanceHistorySectionModel
                                ?.data
                                ?.data
                            : context
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
    return SingleChildScrollView(
      child: Column(
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
                  buildAttendanceCardItem(context, index, widget.selectedIndex),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget leavesDetails() {
    final attendanceData = widget.selectedIndex == 0
        ? context
            .read<WorkLocationCubit>()
            .attendanceLeavesAreaModel
            ?.data
            ?.leaves
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationCubit>()
                .attendanceLeavesCityModel
                ?.data
                ?.leaves
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationCubit>()
                    .attendanceLeavesOrganizationModel
                    ?.data
                    ?.leaves
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationCubit>()
                        .attendanceLeavesBuildingModel
                        ?.data
                        ?.leaves
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationCubit>()
                            .attendanceLeavesFloorModel
                            ?.data
                            ?.leaves
                        : widget.selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .attendanceLeavesSectionModel
                                ?.data
                                ?.leaves
                            : context
                                .read<WorkLocationCubit>()
                                .attendanceLeavesPointModel
                                ?.data
                                ?.leaves;

    if (attendanceData == null || attendanceData.isEmpty) {
      return Center(
        child: Text(
          "There's no data",
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
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
                  buildLeavesCardItem(context, index, widget.selectedIndex),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
