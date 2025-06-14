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
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/attendance_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/cleaner_item_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/leaves_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/manager_item_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/shift_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/supervisor_item_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/ui/widgets/task_list_item_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/area_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/building_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/city_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/floor_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/organization_tree_model.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/data/model/section_tree_model.dart';
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
      context.read<WorkLocationDetailsCubit>().getAreaUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getareaTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistoryArea(widget.id);
      context.read<WorkLocationDetailsCubit>().getAllLeavesArea(widget.id);
      context.read<WorkLocationDetailsCubit>().getAreatree(widget.id);
    }
    if (widget.selectedIndex == 1) {
      context.read<WorkLocationDetailsCubit>().getCityUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getCityTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistoryCity(widget.id);
      context.read<WorkLocationDetailsCubit>().getAllLeavesCity(widget.id);
      context.read<WorkLocationDetailsCubit>().getCitytree(widget.id);
    }
    if (widget.selectedIndex == 2) {
      context
          .read<WorkLocationDetailsCubit>()
          .getOrganizationUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getorganizationTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistoryOrganization(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAllLeavesOrganization(widget.id);
      context.read<WorkLocationDetailsCubit>().getOrganizationtree(widget.id);
    }
    if (widget.selectedIndex == 3) {
      context
          .read<WorkLocationDetailsCubit>()
          .getBuildingUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getbuildingTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistoryBuilding(widget.id);
      context.read<WorkLocationDetailsCubit>().getAllLeavesBuilding(widget.id);
      context.read<WorkLocationDetailsCubit>().getBuildingtree(widget.id);
    }
    if (widget.selectedIndex == 4) {
      context.read<WorkLocationDetailsCubit>().getFloorUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getfloorTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistoryFloor(widget.id);
      context.read<WorkLocationDetailsCubit>().getAllLeavesFloor(widget.id);
      context.read<WorkLocationDetailsCubit>().getFloortree(widget.id);
    }
    if (widget.selectedIndex == 5) {
      context
          .read<WorkLocationDetailsCubit>()
          .getSectionUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getSectionTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistorySection(widget.id);
      context.read<WorkLocationDetailsCubit>().getAllLeavesSection(widget.id);
      context.read<WorkLocationDetailsCubit>().getSectiontree(widget.id);
    }
    if (widget.selectedIndex == 6) {
      context.read<WorkLocationDetailsCubit>().getPointUsersDetails(widget.id);
      context.read<WorkLocationDetailsCubit>().getPointTasks(widget.id);
      context
          .read<WorkLocationDetailsCubit>()
          .getAttendanceHistoryPoint(widget.id);
      context.read<WorkLocationDetailsCubit>().getAllLeavesPoint(widget.id);
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
      WorkLocationDetailsCubit cubit, int selectedIndex) {
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
      WorkLocationDetailsCubit cubit, int selectedIndex) {
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
      WorkLocationDetailsCubit cubit, int selectedIndex) {
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
      WorkLocationDetailsCubit cubit, int selectedIndex) {
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
      WorkLocationDetailsCubit cubit, int selectedIndex) {
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
      WorkLocationDetailsCubit cubit, int selectedIndex) {
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
        ),
        leading: CustomBackButton(),
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
          if (role == 'Admin') ...[
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
          ]
        ],
      ),
      body: BlocConsumer<WorkLocationDetailsCubit, WorkLocationDetailsState>(
        listener: (context, state) {
          if (state is AreaDeleteSuccessState) {
            toast(text: state.deleteAreaModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 0);
          }
          if (state is AreaDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is CityDeleteSuccessState) {
            toast(text: state.deleteCityModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 1);
          }
          if (state is CityDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is OrganizationDeleteSuccessState) {
            toast(
                text: state.deleteOrganizationModel.message!,
                color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 2);
          }
          if (state is OrganizationDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is BuildingDeleteSuccessState) {
            toast(text: state.deleteBuildingModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 3);
          }
          if (state is BuildingDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 4);
          }
          if (state is FloorDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is SectionDeleteSuccessState) {
            toast(text: state.deleteSectionModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 5);
          }
          if (state is SectionDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is PointDeleteSuccessState) {
            toast(text: state.deletePointModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen,
                arguments: 6);
          }
          if (state is PointDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if ((widget.selectedIndex == 0 &&
                  (context.read<WorkLocationDetailsCubit>().areaUsersDetailsModel == null ||
                      context
                              .read<WorkLocationDetailsCubit>()
                              .areaTreeModel ==
                          null)) ||
              (widget.selectedIndex == 1 &&
                  (context.read<WorkLocationDetailsCubit>().cityUsersDetailsModel == null ||
                      context.read<WorkLocationDetailsCubit>().cityTreeModel ==
                          null)) ||
              (widget.selectedIndex == 2 &&
                  (context.read<WorkLocationDetailsCubit>().organizationUsersShiftDetailsModel == null ||
                      context.read<WorkLocationDetailsCubit>().organizationTreeModel ==
                          null)) ||
              (widget.selectedIndex == 3 &&
                  (context.read<WorkLocationDetailsCubit>().buildingUsersShiftDetailsModel == null ||
                      context.read<WorkLocationDetailsCubit>().buildingTreeModel ==
                          null)) ||
              (widget.selectedIndex == 4 &&
                  (context.read<WorkLocationDetailsCubit>().floorUsersShiftDetailsModel == null ||
                      context.read<WorkLocationDetailsCubit>().floorTreeModel ==
                          null)) ||
              (widget.selectedIndex == 5 &&
                  (context.read<WorkLocationDetailsCubit>().sectionUsersShiftDetailsModel == null ||
                      context.read<WorkLocationDetailsCubit>().sectionTreeModel ==
                          null)) ||
              (widget.selectedIndex == 6 &&
                  (context.read<WorkLocationDetailsCubit>().pointUsersDetailsModel ==
                      null))) {
            return Loading();
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
                  if (role == 'Admin') ...[
                    DefaultElevatedButton(
                        name: S.of(context).deleteButton,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return PopUpMeassage(
                                    title: 'delete',
                                    body: widget.selectedIndex == 0
                                        ? "area"
                                        : widget.selectedIndex == 1
                                            ? "city"
                                            : widget.selectedIndex == 2
                                                ? "organization"
                                                : widget.selectedIndex == 3
                                                    ? "building"
                                                    : widget.selectedIndex == 4
                                                        ? "floor"
                                                        : widget.selectedIndex ==
                                                                5
                                                            ? "section"
                                                            : "point",
                                    onPressed: () {
                                      widget.selectedIndex == 0
                                          ? context
                                              .read<WorkLocationDetailsCubit>()
                                              .deleteArea(widget.id)
                                          : widget.selectedIndex == 1
                                              ? context
                                                  .read<
                                                      WorkLocationDetailsCubit>()
                                                  .deleteCity(widget.id)
                                              : widget.selectedIndex == 2
                                                  ? context
                                                      .read<
                                                          WorkLocationDetailsCubit>()
                                                      .deleteOrganization(
                                                          widget.id)
                                                  : widget.selectedIndex == 3
                                                      ? context
                                                          .read<
                                                              WorkLocationDetailsCubit>()
                                                          .deleteBuilding(
                                                              widget.id)
                                                      : widget.selectedIndex ==
                                                              4
                                                          ? context
                                                              .read<
                                                                  WorkLocationDetailsCubit>()
                                                              .deleteFloor(
                                                                  widget.id)
                                                          : widget.selectedIndex ==
                                                                  5
                                                              ? context
                                                                  .read<WorkLocationDetailsCubit>()
                                                                  .deleteSection(widget.id)
                                                              : context.read<WorkLocationDetailsCubit>().deletePoint(widget.id);
                                    });
                              });
                        },
                        color: Colors.red,
                        height: 48,
                        width: double.infinity,
                        textStyles: TextStyles.font20Whitesemimedium),
                  ],
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
    final workLocationDetailsCubit = context.read<WorkLocationDetailsCubit>();

    List<Map<String, String>> items;
    List<dynamic> filteredList;

    switch (widget.selectedIndex) {
      case 0:
        items = getAreaCountsFromModel(workLocationDetailsCubit.areaTreeModel!);
        filteredList =
            getAreaFilteredList(workLocationDetailsCubit, selectedTreeIndex);
        break;
      case 1:
        items = getCityCountsFromModel(workLocationDetailsCubit.cityTreeModel!);
        filteredList =
            getCityFilteredList(workLocationDetailsCubit, selectedTreeIndex);
        break;
      case 2:
        items = getOrganizationCountsFromModel(
            workLocationDetailsCubit.organizationTreeModel!);
        filteredList = getOrganizationFilteredList(
            workLocationDetailsCubit, selectedTreeIndex);
        break;
      case 3:
        items = getBuildingCountsFromModel(
            workLocationDetailsCubit.buildingTreeModel!);
        filteredList = getBuildingFilteredList(
            workLocationDetailsCubit, selectedTreeIndex);
        break;
      case 4:
        items =
            getFloorCountsFromModel(workLocationDetailsCubit.floorTreeModel!);
        filteredList =
            getFloorFilteredList(workLocationDetailsCubit, selectedTreeIndex);
        break;
      case 5:
        items = getSectionCountsFromModel(
            workLocationDetailsCubit.sectionTreeModel!);
        filteredList =
            getSectionFilteredList(workLocationDetailsCubit, selectedTreeIndex);
        break;
      default:
        items = [];
        filteredList = [];
    }
    final workLocationDetailsModel;

    switch (widget.selectedIndex) {
      case 0:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .areaUsersDetailsModel
            ?.data;
        break;
      case 1:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .cityUsersDetailsModel
            ?.data;
        break;
      case 2:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .organizationUsersShiftDetailsModel
            ?.data;
        break;
      case 3:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .buildingUsersShiftDetailsModel
            ?.data;
        break;
      case 4:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .floorUsersShiftDetailsModel
            ?.data;
        break;
      case 5:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .sectionUsersShiftDetailsModel
            ?.data;
        break;
      case 6:
        workLocationDetailsModel = context
            .read<WorkLocationDetailsCubit>()
            .pointUsersDetailsModel
            ?.data;
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
                    : workLocationDetailsModel.sectionName!,
                color:
                    widget.selectedIndex == 5 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (widget.selectedIndex >= 6) ...[
            rowDetailsBuild(context, "Point", workLocationDetailsModel.name!,
                color:
                    widget.selectedIndex == 6 ? AppColor.primaryColor : null),
            Divider(),
            if (context
                    .read<WorkLocationDetailsCubit>()
                    .pointUsersDetailsModel
                    ?.data
                    ?.isCountable ==
                true) ...[
              rowDetailsBuild(
                context,
                "Capacity",
                context
                    .read<WorkLocationDetailsCubit>()
                    .pointUsersDetailsModel!
                    .data!
                    .capacity!
                    .toString(),
              ),
              Divider(),
              rowDetailsBuild(
                context,
                "Unit",
                context
                    .read<WorkLocationDetailsCubit>()
                    .pointUsersDetailsModel!
                    .data!
                    .unit!,
              ),
              Divider(),
              rowDetailsBuild(
                  context,
                  "Device",
                  context
                      .read<WorkLocationDetailsCubit>()
                      .pointUsersDetailsModel!
                      .data!
                      .deviceName!),
              Divider()
            ],
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
                      final item = filteredList[index];
                      final currentTitle = items[selectedTreeIndex]['title']!;

                      final levelIndex = {
                        'City': 1,
                        'Organization': 2,
                        'Building': 3,
                        'Floor': 4,
                        'Section': 5,
                        'Point': 6,
                      };

                      context.pushNamed(Routes.workLocationDetailsScreen,
                          arguments: {
                            'id': item.id!,
                            'selectedIndex': levelIndex[currentTitle]
                          });
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
            .read<WorkLocationDetailsCubit>()
            .areaUsersDetailsModel!
            .data!
            .users!
            .where((user) => user.role == 'Manager')
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationDetailsCubit>()
                .cityUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                            : widget.selectedIndex == 5
                                ? context
                                    .read<WorkLocationDetailsCubit>()
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
            .read<WorkLocationDetailsCubit>()
            .areaUsersDetailsModel!
            .data!
            .users!
            .where((user) => user.role == 'Supervisor')
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationDetailsCubit>()
                .cityUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Supervisor')
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Supervisor')
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Supervisor')
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Supervisor')
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Supervisor')
                            : widget.selectedIndex == 6
                                ? context
                                    .read<WorkLocationDetailsCubit>()
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
            .read<WorkLocationDetailsCubit>()
            .areaUsersDetailsModel!
            .data!
            .users!
            .where((user) => user.role == 'Cleaner')
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationDetailsCubit>()
                .cityUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Cleaner')
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Cleaner')
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Cleaner')
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .sectionUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Cleaner')
                            : widget.selectedIndex == 6
                                ? context
                                    .read<WorkLocationDetailsCubit>()
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
                    .read<WorkLocationDetailsCubit>()
                    .organizationUsersShiftDetailsModel!
                    .data!
                    .shifts
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .buildingUsersShiftDetailsModel!
                        .data!
                        .shifts
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .floorUsersShiftDetailsModel!
                            .data!
                            .shifts
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationDetailsCubit>()
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
        ? context.read<WorkLocationDetailsCubit>().allareaTasksModel
        : widget.selectedIndex == 1
            ? context.read<WorkLocationDetailsCubit>().allcityTasksModel
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .allorganizationTasksModel
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .allbuildingTasksModel
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .allfloorTasksModel
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .allSectionTasksModel
                            : context
                                .read<WorkLocationDetailsCubit>()
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
            .read<WorkLocationDetailsCubit>()
            .attendanceHistoryAreaModel
            ?.data
            ?.data
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationDetailsCubit>()
                .attendanceHistoryCityModel
                ?.data
                ?.data
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .attendanceHistoryOrganizationModel
                    ?.data
                    ?.data
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .attendanceHistoryBuildingModel
                        ?.data
                        ?.data
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .attendanceHistoryFloorModel
                            ?.data
                            ?.data
                        : widget.selectedIndex == 5
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .attendanceHistorySectionModel
                                ?.data
                                ?.data
                            : context
                                .read<WorkLocationDetailsCubit>()
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
            .read<WorkLocationDetailsCubit>()
            .attendanceLeavesAreaModel
            ?.data
            ?.leaves
        : widget.selectedIndex == 1
            ? context
                .read<WorkLocationDetailsCubit>()
                .attendanceLeavesCityModel
                ?.data
                ?.leaves
            : widget.selectedIndex == 2
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .attendanceLeavesOrganizationModel
                    ?.data
                    ?.leaves
                : widget.selectedIndex == 3
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .attendanceLeavesBuildingModel
                        ?.data
                        ?.leaves
                    : widget.selectedIndex == 4
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .attendanceLeavesFloorModel
                            ?.data
                            ?.leaves
                        : widget.selectedIndex == 4
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .attendanceLeavesSectionModel
                                ?.data
                                ?.leaves
                            : context
                                .read<WorkLocationDetailsCubit>()
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
