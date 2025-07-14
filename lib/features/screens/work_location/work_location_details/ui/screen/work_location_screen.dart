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
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_leaves/work_location_leaves_details.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_details/work_location_details.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_history/work_location_attendance_details.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_shifts/work_location_shifts.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_tasks/work_location_tasks.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_users/cleaners/work_location_cleaners.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_users/managers/work_location_managers.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_users/supervisors/work_location_supervisors.dart';
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

  @override
  void initState() {
    controller = TabController(length: 8, vsync: this);

    controller.addListener(() {
      final cubit = context.read<WorkLocationDetailsCubit>();

      if (controller.indexIsChanging) return;

      final index = controller.index;

      switch (index) {
        case 5:
          if (widget.selectedIndex == 0) {
            if (cubit.allAreaTasksModel == null) {
              cubit.getAreaTasks(widget.id);
            }
          }
          if (widget.selectedIndex == 1) {
            if (cubit.allCityTasksModel == null) {
              cubit.getCityTasks(widget.id);
            }
          }
          if (widget.selectedIndex == 2) {
            if (cubit.allOrganizationTasksModel == null) {
              cubit.getOrganizationTasks(widget.id);
            }
          }
          if (widget.selectedIndex == 3) {
            if (cubit.allBuildingTasksModel == null) {
              cubit.getBuildingTasks(widget.id);
            }
          }
          if (widget.selectedIndex == 4) {
            if (cubit.allFloorTasksModel == null) {
              cubit.getFloorTasks(widget.id);
            }
          }
          if (widget.selectedIndex == 5) {
            if (cubit.allSectionTasksModel == null) {
              cubit.getSectionTasks(widget.id);
            }
          }
          if (widget.selectedIndex == 6) {
            if (cubit.allPointTasksModel == null) {
              cubit.getPointTasks(widget.id);
            }
          }
          break;
        case 6:
          if (widget.selectedIndex == 0) {
            if (cubit.attendanceHistoryAreaModel == null) {
              cubit.getAttendanceHistoryArea(widget.id);
            }
          }
          if (widget.selectedIndex == 1) {
            if (cubit.attendanceHistoryCityModel == null) {
              cubit.getAttendanceHistoryCity(widget.id);
            }
          }
          if (widget.selectedIndex == 2) {
            if (cubit.attendanceHistoryOrganizationModel == null) {
              cubit.getAttendanceHistoryOrganization(widget.id);
            }
          }
          if (widget.selectedIndex == 3) {
            if (cubit.attendanceHistoryBuildingModel == null) {
              cubit.getAttendanceHistoryBuilding(widget.id);
            }
          }
          if (widget.selectedIndex == 4) {
            if (cubit.attendanceHistoryFloorModel == null) {
              cubit.getAttendanceHistoryFloor(widget.id);
            }
          }
          if (widget.selectedIndex == 5) {
            if (cubit.attendanceHistorySectionModel == null) {
              cubit.getAttendanceHistorySection(widget.id);
            }
          }
          if (widget.selectedIndex == 6) {
            if (cubit.attendanceHistoryPointModel == null) {
              cubit.getAttendanceHistoryPoint(widget.id);
            }
          }
          break;
        case 7:
          if (widget.selectedIndex == 0) {
            if (cubit.attendanceLeavesAreaModel == null) {
              cubit.getAllLeavesArea(widget.id);
            }
          }
          if (widget.selectedIndex == 1) {
            if (cubit.attendanceLeavesCityModel == null) {
              cubit.getAllLeavesCity(widget.id);
            }
          }
          if (widget.selectedIndex == 2) {
            if (cubit.attendanceLeavesOrganizationModel == null) {
              cubit.getAllLeavesOrganization(widget.id);
            }
          }
          if (widget.selectedIndex == 3) {
            if (cubit.attendanceLeavesBuildingModel == null) {
              cubit.getAllLeavesBuilding(widget.id);
            }
          }
          if (widget.selectedIndex == 4) {
            if (cubit.attendanceLeavesFloorModel == null) {
              cubit.getAllLeavesFloor(widget.id);
            }
          }
          if (widget.selectedIndex == 5) {
            if (cubit.attendanceLeavesSectionModel == null) {
              cubit.getAllLeavesSection(widget.id);
            }
          }
          if (widget.selectedIndex == 6) {
            if (cubit.attendanceLeavesPointModel == null) {
              cubit.getAllLeavesPoint(widget.id);
            }
          }
          break;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedIndex == 0
              ? S.of(context).area_details
              : widget.selectedIndex == 1
                  ? S.of(context).city_details
                  : widget.selectedIndex == 2
                      ? S.of(context).organization_details
                      : widget.selectedIndex == 3
                          ? S.of(context).building_details
                          : widget.selectedIndex == 4
                              ? S.of(context).floor_details
                              : widget.selectedIndex == 5
                                  ? S.of(context).section_details
                                  : S.of(context).point_details,
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
                onPressed: () async {
                  final route = widget.selectedIndex == 0
                      ? Routes.editAreaScreen
                      : widget.selectedIndex == 1
                          ? Routes.editCityScreen
                          : widget.selectedIndex == 2
                              ? Routes.editOrganizationScreen
                              : widget.selectedIndex == 3
                                  ? Routes.editBuildingScreen
                                  : widget.selectedIndex == 4
                                      ? Routes.editFloorScreen
                                      : widget.selectedIndex == 5
                                          ? Routes.editSectionScreen
                                          : Routes.editPointScreen;

                  final result =
                      await context.pushNamed(route, arguments: widget.id);

                  if (result == true) {
                    widget.selectedIndex == 0
                        ? cubit.getAreaUsersDetails(widget.id)
                        : widget.selectedIndex == 1
                            ? cubit.getCityUsersDetails(widget.id)
                            : widget.selectedIndex == 2
                                ? cubit.getOrganizationUsersDetails(widget.id)
                                : widget.selectedIndex == 3
                                    ? cubit.getBuildingUsersDetails(widget.id)
                                    : widget.selectedIndex == 4
                                        ? cubit.getFloorUsersDetails(widget.id)
                                        : widget.selectedIndex == 5
                                            ? cubit.getSectionUsersDetails(
                                                widget.id)
                                            : cubit.getPointUsersDetails(
                                                widget.id);
                  }
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
            toast(text: state.deleteAreaModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is AreaDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is CityDeleteSuccessState) {
            toast(text: state.deleteCityModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is CityDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is OrganizationDeleteSuccessState) {
            toast(
                text: state.deleteOrganizationModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is OrganizationDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is BuildingDeleteSuccessState) {
            toast(text: state.deleteBuildingModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is BuildingDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is FloorDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is SectionDeleteSuccessState) {
            toast(text: state.deleteSectionModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is SectionDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is PointDeleteSuccessState) {
            toast(text: state.deletePointModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is PointDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if ((widget.selectedIndex == 0 &&
                  (cubit.areaUsersDetailsModel == null ||
                      cubit.areaTreeModel == null)) ||
              (widget.selectedIndex == 1 &&
                  (cubit.cityUsersDetailsModel == null ||
                      cubit.cityTreeModel == null)) ||
              (widget.selectedIndex == 2 &&
                  (cubit.organizationUsersShiftDetailsModel == null ||
                      cubit.organizationTreeModel == null)) ||
              (widget.selectedIndex == 3 &&
                  (cubit.buildingUsersShiftDetailsModel == null ||
                      cubit.buildingTreeModel == null)) ||
              (widget.selectedIndex == 4 &&
                  (cubit.floorUsersShiftDetailsModel == null ||
                      cubit.floorTreeModel == null)) ||
              (widget.selectedIndex == 5 &&
                  (cubit.sectionUsersShiftDetailsModel == null ||
                      cubit.sectionTreeModel == null)) ||
              (widget.selectedIndex == 6 &&
                  (cubit.pointUsersDetailsModel == null))) {
            return Loading();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: double.infinity,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final shiftLabels = [
                        S.of(context).workLocation,
                        S.of(context).managers,
                        S.of(context).supervisors,
                        S.of(context).cleaners,
                        S.of(context).shifts,
                        S.of(context).tasks,
                        S.of(context).attendance,
                        S.of(context).leaves,
                      ];
                      return TabBar(
                        controller: controller,
                        tabAlignment: TabAlignment.center,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColor.primaryColor,
                        ),
                        tabs: List.generate(shiftLabels.length, (index) {
                          return Tab(
                            child: Text(
                              shiftLabels[index],
                              style: TextStyle(
                                color: controller.index == index
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                verticalSpace(10),
                Expanded(
                  child: TabBarView(controller: controller, children: [
                    WorkLocationDetails(selectedIndex: widget.selectedIndex),
                    WorkLocationManagers(selectedIndex: widget.selectedIndex),
                    WorkLocationSupervisors(
                        selectedIndex: widget.selectedIndex),
                    WorkLocationCleaners(selectedIndex: widget.selectedIndex),
                    WorkLocationShifts(selectedIndex: widget.selectedIndex),
                    WorkLocationTasks(selectedIndex: widget.selectedIndex),
                    WorkLocationAttendanceDetails(
                        selectedIndex: widget.selectedIndex),
                    WorkLocationLeavesDetails(
                        selectedIndex: widget.selectedIndex)
                  ]),
                ),
                verticalSpace(15),
                if (role == 'Admin')
                  DefaultElevatedButton(
                      name: S.of(context).deleteButton,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return PopUpMessage(
                                  title: S.of(context).TitleDelete,
                                  body: widget.selectedIndex == 0
                                      ? S.of(context).areaBody
                                      : widget.selectedIndex == 1
                                          ? S.of(context).cityBody
                                          : widget.selectedIndex == 2
                                              ? S.of(context).organizationBody
                                              : widget.selectedIndex == 3
                                                  ? S.of(context).buildingBody
                                                  : widget.selectedIndex == 4
                                                      ? S.of(context).floorBody
                                                      : widget.selectedIndex ==
                                                              5
                                                          ? S
                                                              .of(context)
                                                              .sectionBody
                                                          : S
                                                              .of(context)
                                                              .pointBody,
                                  onPressed: () {
                                    widget.selectedIndex == 0
                                        ? cubit.deleteArea(widget.id)
                                        : widget.selectedIndex == 1
                                            ? cubit.deleteCity(widget.id)
                                            : widget.selectedIndex == 2
                                                ? cubit.deleteOrganization(
                                                    widget.id)
                                                : widget.selectedIndex == 3
                                                    ? cubit.deleteBuilding(
                                                        widget.id)
                                                    : widget.selectedIndex == 4
                                                        ? cubit.deleteFloor(
                                                            widget.id)
                                                        : widget.selectedIndex ==
                                                                5
                                                            ? cubit
                                                                .deleteSection(
                                                                    widget.id)
                                                            : cubit.deletePoint(
                                                                widget.id);
                                  });
                            });
                      },
                      color: Colors.red,
                      textStyles: TextStyles.font20Whitesemimedium),
                verticalSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
