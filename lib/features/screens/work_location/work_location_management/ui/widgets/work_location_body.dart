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
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/delete_work_location_list.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_filter_search_build.dart';

class OrganizationsBody extends StatefulWidget {
  final int selectedIndex;
  const OrganizationsBody({super.key, required this.selectedIndex});

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
    "Sections",
    "Points",
  ];
  @override
  void initState() {
    super.initState();
    context.read<WorkLocationCubit>().initialize(widget.selectedIndex);
    fetchData();
  }

  void fetchData() {
    final workLocationCubit = context.read<WorkLocationCubit>();

    switch (widget.selectedIndex) {
      case 0:
        workLocationCubit.getArea();
        workLocationCubit.getAllDeletedArea();
        workLocationCubit.getNationality();
        break;
      case 1:
        workLocationCubit.getCity();
        workLocationCubit.getAllDeletedCity();
        workLocationCubit.getNationality();
        break;
      case 2:
        workLocationCubit.getOrganization();
        workLocationCubit.getAllDeletedOrganization();
        workLocationCubit.getArea();
        break;
      case 3:
        workLocationCubit.getBuilding();
        workLocationCubit.getAllDeletedBuilding();
        workLocationCubit.getCity();
        break;
      case 4:
        workLocationCubit.getFloor();
        workLocationCubit.getAllDeletedFloor();
        workLocationCubit.getOrganization();
        break;
      case 5:
        workLocationCubit.getSection();
        workLocationCubit.getAllDeletedSection();
        workLocationCubit.getBuilding();
        break;
      case 6:
        workLocationCubit.getPoint();
        workLocationCubit.getAllDeletedPoint();
        workLocationCubit.getFloor();
        break;
      default:
        break;
    }
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Work Location'),
      ),
      floatingActionButton: role == 'Admin'
          ? Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: 57.h,
                width: 57.w,
                child: ElevatedButton(
                  onPressed: () {
                    widget.selectedIndex == 0
                        ? context.pushNamed(Routes.addAreaScreen)
                        : widget.selectedIndex == 1
                            ? context.pushNamed(Routes.addCityScreen)
                            : widget.selectedIndex == 2
                                ? context.pushNamed(
                                    Routes.addOrganizationScreen)
                                : widget.selectedIndex == 3
                                    ? context
                                        .pushNamed(Routes.addBuildingScreen)
                                    : widget.selectedIndex == 4
                                        ? context
                                            .pushNamed(Routes.addFloorScreen)
                                        : widget.selectedIndex == 5
                                            ? context.pushNamed(
                                                Routes.addSectionScreen)
                                            : context.pushNamed(
                                                Routes.addPointScreen);
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
            )
          : SizedBox.shrink(),
      body: BlocConsumer<WorkLocationCubit, WorkLocationState>(
        listener: (context, state) {
          if (state is AreaErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is AreaDeleteSuccessState) {
            toast(text: state.deleteAreaModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedArea();
          }
          if (state is CityErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is CityDeleteSuccessState) {
            toast(text: state.deleteCityModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedCity();
          }
          if (state is OrganizationErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is OrganizationDeleteSuccessState) {
            toast(
                text: state.deleteOrganizationModel.message!,
                color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedOrganization();
          }
          if (state is BuildingErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is BuildingDeleteSuccessState) {
            toast(text: state.deleteBuildingModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedBuilding();
          }
          if (state is FloorErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedFloor();
          }
          if (state is SectionErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is SectionDeleteSuccessState) {
            toast(text: state.deleteSectionModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedSection();
          }
          if (state is PointErrorState) {
            toast(text: state.error, color: Colors.red);
          }
          if (state is PointDeleteSuccessState) {
            toast(text: state.deletePointModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedPoint();
          }

          if (state is DeleteForceAreaSuccessState) {
            toast(text: state.message, color: Colors.blue);

            context.read<WorkLocationCubit>().getAllDeletedArea();
            context.read<WorkLocationCubit>().getArea();
          }
          if (state is DeleteRestoreAreaSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is DeleteForceCitySuccessState) {
            toast(text: state.message, color: Colors.blue);

            context.read<WorkLocationCubit>().getAllDeletedCity();
            context.read<WorkLocationCubit>().getCity();
          }
          if (state is DeleteRestoreCitySuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is DeleteForceOrganizationSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedOrganization();
            context.read<WorkLocationCubit>().getOrganization();
          }
          if (state is DeleteRestoreOrganizationSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is DeleteForceBuildingSuccessState) {
            toast(text: state.message, color: Colors.blue);

            context.read<WorkLocationCubit>().getAllDeletedBuilding();
            context.read<WorkLocationCubit>().getBuilding();
          }

          if (state is DeleteRestoreBuildingSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is DeleteForceFloorSuccessState) {
            toast(text: state.message, color: Colors.blue);

            context.read<WorkLocationCubit>().getAllDeletedFloor();
            context.read<WorkLocationCubit>().getFloor();
          }
          if (state is DeleteRestoreFloorSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is DeleteForceSectionSuccessState) {
            toast(text: state.message, color: Colors.blue);

            context.read<WorkLocationCubit>().getAllDeletedSection();
            context.read<WorkLocationCubit>().getSection();
          }
          if (state is DeleteRestoreSectionSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }

          if (state is DeleteForcePointSuccessState) {
            toast(text: state.message, color: Colors.blue);

            context.read<WorkLocationCubit>().getAllDeletedPoint();
            context.read<WorkLocationCubit>().getPoint();
          }
          if (state is DeleteRestorePointSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (widget.selectedIndex == 0 &&
                    context.read<WorkLocationCubit>().areaModel == null &&
                    context.read<WorkLocationCubit>().deletedAreaList ==
                        null) ||
                (widget.selectedIndex == 1 &&
                    context.read<WorkLocationCubit>().cityModel == null &&
                    context.read<WorkLocationCubit>().deletedCityList ==
                        null) ||
                (widget.selectedIndex == 2 &&
                    context.read<WorkLocationCubit>().organizationModel ==
                        null &&
                    context.read<WorkLocationCubit>().deletedOrganizationList ==
                        null) ||
                (widget.selectedIndex == 3 &&
                    context.read<WorkLocationCubit>().buildingModel == null &&
                    context.read<WorkLocationCubit>().deletedBuildingList ==
                        null) ||
                (widget.selectedIndex == 4 &&
                    context.read<WorkLocationCubit>().floorModel == null &&
                    context.read<WorkLocationCubit>().deletedFloorList ==
                        null) ||
                (widget.selectedIndex == 5 &&
                    context.read<WorkLocationCubit>().sectionModel == null &&
                    context.read<WorkLocationCubit>().deletedSectionList ==
                        null) ||
                (widget.selectedIndex == 6 &&
                    context.read<WorkLocationCubit>().pointModel == null &&
                    context.read<WorkLocationCubit>().deletedPointList == null),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    organizationsFilterAndDeleteBuild(
                        context,
                        context.read<WorkLocationCubit>(),
                        widget.selectedIndex),
                    verticalSpace(15),
                    Center(
                      child: SizedBox(
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
                              itemCount: 2,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                    width: gap); // 10px gap between containers
                              },
                              itemBuilder: (context, index) {
                                bool isSelected = selectedIndex == index;
                                int getListLength(int index) {
                                  final workLocationCubit =
                                      context.read<WorkLocationCubit>();

                                  if (index == 0) {
                                    switch (widget.selectedIndex) {
                                      case 0:
                                        return workLocationCubit.areaModel?.data
                                                ?.areas?.length ??
                                            0;
                                      case 1:
                                        return workLocationCubit.cityModel?.data
                                                ?.data?.length ??
                                            0;
                                      case 2:
                                        return workLocationCubit
                                                .organizationModel
                                                ?.data
                                                ?.data
                                                ?.length ??
                                            0;
                                      case 3:
                                        return workLocationCubit.buildingModel
                                                ?.data?.data?.length ??
                                            0;
                                      case 4:
                                        return workLocationCubit.floorModel
                                                ?.data?.data?.length ??
                                            0;
                                      case 5:
                                        return workLocationCubit.sectionModel
                                                ?.data?.data?.length ??
                                            0;
                                      case 6:
                                        return workLocationCubit.pointModel
                                                ?.data?.data?.length ??
                                            0;
                                      default:
                                        return 0;
                                    }
                                  } else if (index == 1) {
                                    switch (widget.selectedIndex) {
                                      case 0:
                                        return workLocationCubit.deletedAreaList
                                                ?.data?.length ??
                                            0;
                                      case 1:
                                        return workLocationCubit.deletedCityList
                                                ?.data?.length ??
                                            0;
                                      case 2:
                                        return workLocationCubit
                                                .deletedOrganizationList
                                                ?.data
                                                ?.length ??
                                            0;
                                      case 3:
                                        return workLocationCubit
                                                .deletedBuildingList
                                                ?.data
                                                ?.length ??
                                            0;
                                      case 4:
                                        return workLocationCubit
                                                .deletedFloorList
                                                ?.data
                                                ?.length ??
                                            0;
                                      case 5:
                                        return workLocationCubit
                                                .deletedSectionList
                                                ?.data
                                                ?.length ??
                                            0;
                                      case 6:
                                        return workLocationCubit
                                                .deletedPointList
                                                ?.data
                                                ?.length ??
                                            0;
                                      default:
                                        return 0;
                                    }
                                  }
                                  return 0;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 3),
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
                                          "${getListLength(index)}",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: isSelected
                                                ? Colors.white
                                                : AppColor.primaryColor,
                                          ),
                                        ),
                                        horizontalSpace(5),
                                        Flexible(
                                          child: Text(
                                            index == 0
                                                ? "Total ${tapList[widget.selectedIndex]}"
                                                : "Deleted ${tapList[widget.selectedIndex]}",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              overflow: TextOverflow.ellipsis,
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColor.primaryColor,
                                            ),
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
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    if (selectedIndex == 0) ...[
                      Expanded(
                        child: (widget.selectedIndex == 0
                                ? state is AreaLoadingState &&
                                    (context
                                            .read<WorkLocationCubit>()
                                            .areaModel ==
                                        null)
                                : widget.selectedIndex == 1
                                    ? state is CityLoadingState &&
                                        (context
                                                .read<WorkLocationCubit>()
                                                .cityModel ==
                                            null)
                                    : widget.selectedIndex == 2
                                        ? state is OrganizationLoadingState &&
                                            (context
                                                    .read<WorkLocationCubit>()
                                                    .organizationModel ==
                                                null)
                                        : widget.selectedIndex == 3
                                            ? state is BuildingLoadingState &&
                                                (context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .buildingModel ==
                                                    null)
                                            : widget.selectedIndex == 4
                                                ? state is FloorLoadingState &&
                                                    (context
                                                            .read<
                                                                WorkLocationCubit>()
                                                            .floorModel ==
                                                        null)
                                                : widget.selectedIndex == 5
                                                    ? state is SectionLoadingState &&
                                                        (context
                                                                .read<
                                                                    WorkLocationCubit>()
                                                                .sectionModel ==
                                                            null)
                                                    : state is PointLoadingState &&
                                                        (context
                                                                .read<WorkLocationCubit>()
                                                                .pointModel ==
                                                            null))
                            ? Center(child: CircularProgressIndicator(color: AppColor.primaryColor))
                            : organizationDetailsBuild(context, widget.selectedIndex),
                      ),
                      verticalSpace(10),
                    ],
                    if (selectedIndex == 1) ...[
                      Expanded(
                        child: (widget.selectedIndex == 0
                                ? state is DeletedAreaLoadingState &&
                                    (context
                                            .read<WorkLocationCubit>()
                                            .deletedAreaList ==
                                        null)
                                : widget.selectedIndex == 1
                                    ? state is DeletedCityLoadingState &&
                                        (context
                                                .read<WorkLocationCubit>()
                                                .deletedCityList ==
                                            null)
                                    : widget.selectedIndex == 2
                                        ? state is DeletedOrganizationLoadingState &&
                                            (context
                                                    .read<WorkLocationCubit>()
                                                    .deletedOrganizationList ==
                                                null)
                                        : widget.selectedIndex == 3
                                            ? state is DeletedBuildingLoadingState &&
                                                (context
                                                        .read<
                                                            WorkLocationCubit>()
                                                        .deletedBuildingList ==
                                                    null)
                                            : widget.selectedIndex == 4
                                                ? state is DeletedFloorLoadingState &&
                                                    (context
                                                            .read<
                                                                WorkLocationCubit>()
                                                            .deletedFloorList ==
                                                        null)
                                                : widget.selectedIndex == 5
                                                    ? state is DeletedSectionLoadingState &&
                                                        (context
                                                                .read<
                                                                    WorkLocationCubit>()
                                                                .deletedSectionList ==
                                                            null)
                                                    : state is DeletedPointLoadingState &&
                                                        (context
                                                                .read<WorkLocationCubit>()
                                                                .deletedPointList ==
                                                            null))
                            ? Center(child: CircularProgressIndicator(color: AppColor.primaryColor))
                            : deleteOrganizationListBuild(context, widget.selectedIndex),
                      ),
                      verticalSpace(10),
                    ]
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
