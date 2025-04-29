import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/delete_work_location_list.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_filter_search_build.dart';

class WorkLocationBody extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationBody({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final WorkLocationCubit cubit = context.read<WorkLocationCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: const Text('Work Location'),
      ),
      floatingActionButton: role == 'Admin'
          ? floatingActionButton(
              icon: Icons.add_home_outlined,
              onPressed: () {
                selectedIndex == 0
                    ? context.pushNamed(Routes.addAreaScreen)
                    : selectedIndex == 1
                        ? context.pushNamed(Routes.addCityScreen)
                        : selectedIndex == 2
                            ? context.pushNamed(Routes.addOrganizationScreen)
                            : selectedIndex == 3
                                ? context.pushNamed(Routes.addBuildingScreen)
                                : selectedIndex == 4
                                    ? context.pushNamed(Routes.addFloorScreen)
                                    : selectedIndex == 5
                                        ? context
                                            .pushNamed(Routes.addSectionScreen)
                                        : context
                                            .pushNamed(Routes.addPointScreen);
              },
            )
          : const SizedBox.shrink(),
      body: BlocConsumer<WorkLocationCubit, WorkLocationState>(
        listener: (context, state) {
          if (state is AreaErrorState || state is DeletedAreaErrorState) {
            final errorMessage = state is AreaErrorState
                ? state.error
                : (state as DeletedAreaErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForceAreaSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getArea();
            context.read<WorkLocationCubit>().getAllDeletedArea();
          }
          if (state is DeleteRestoreAreaSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is AreaDeleteSuccessState) {
            toast(text: state.deleteAreaModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedArea();
          }
          //****************** */
          if (state is CityErrorState || state is DeletedCityErrorState) {
            final errorMessage = state is CityErrorState
                ? state.error
                : (state as DeletedCityErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForceCitySuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getCity();
            context.read<WorkLocationCubit>().getAllDeletedCity();
          }
          if (state is DeleteRestoreCitySuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is CityDeleteSuccessState) {
            toast(text: state.deleteCityModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedCity();
          }
          //****************** */
          if (state is OrganizationErrorState ||
              state is DeletedOrganizationErrorState) {
            final errorMessage = state is OrganizationErrorState
                ? state.error
                : (state as DeletedOrganizationErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForceOrganizationSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getOrganization();
            context.read<WorkLocationCubit>().getAllDeletedOrganization();
          }
          if (state is DeleteRestoreOrganizationSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is OrganizationDeleteSuccessState) {
            toast(
                text: state.deleteOrganizationModel.message!,
                color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedOrganization();
          }
          //****************** */
          if (state is BuildingErrorState ||
              state is DeletedBuildingErrorState) {
            final errorMessage = state is BuildingErrorState
                ? state.error
                : (state as DeletedBuildingErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForceBuildingSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getBuilding();
            context.read<WorkLocationCubit>().getAllDeletedBuilding();
          }
          if (state is DeleteRestoreBuildingSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is BuildingDeleteSuccessState) {
            toast(text: state.deleteBuildingModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedBuilding();
          }
          //****************** */
          if (state is FloorErrorState || state is DeletedFloorErrorState) {
            final errorMessage = state is FloorErrorState
                ? state.error
                : (state as DeletedFloorErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForceFloorSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getFloor();
            context.read<WorkLocationCubit>().getAllDeletedFloor();
          }
          if (state is DeleteRestoreFloorSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedFloor();
          }
           //****************** */
          if (state is SectionErrorState || state is DeletedSectionErrorState) {
            final errorMessage = state is SectionErrorState
                ? state.error
                : (state as DeletedSectionErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForceSectionSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getSection();
            context.read<WorkLocationCubit>().getAllDeletedSection();
          }
          if (state is DeleteRestoreSectionSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is SectionDeleteSuccessState) {
            toast(text: state.deleteSectionModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedSection();
          }
          //****************** */
          if (state is PointErrorState || state is DeletedPointErrorState) {
            final errorMessage = state is PointErrorState
                ? state.error
                : (state as DeletedPointErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          }
          if (state is DeleteForcePointSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<WorkLocationCubit>().getPoint();
            context.read<WorkLocationCubit>().getAllDeletedPoint();
          }
          if (state is DeleteRestorePointSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is PointDeleteSuccessState) {
            toast(text: state.deletePointModel.message!, color: Colors.blue);
            context.read<WorkLocationCubit>().getAllDeletedPoint();
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (selectedIndex == 0 &&
                    context.read<WorkLocationCubit>().areaModel == null &&
                    context.read<WorkLocationCubit>().deletedAreaList ==
                        null) ||
                (selectedIndex == 1 &&
                    context.read<WorkLocationCubit>().cityModel == null &&
                    context.read<WorkLocationCubit>().deletedCityList ==
                        null) ||
                (selectedIndex == 2 &&
                    context.read<WorkLocationCubit>().organizationModel ==
                        null &&
                    context.read<WorkLocationCubit>().deletedOrganizationList ==
                        null) ||
                (selectedIndex == 3 &&
                    context.read<WorkLocationCubit>().buildingModel == null &&
                    context.read<WorkLocationCubit>().deletedBuildingList ==
                        null) ||
                (selectedIndex == 4 &&
                    context.read<WorkLocationCubit>().floorModel == null &&
                    context.read<WorkLocationCubit>().deletedFloorList ==
                        null) ||
                (selectedIndex == 5 &&
                    context.read<WorkLocationCubit>().sectionModel == null &&
                    context.read<WorkLocationCubit>().deletedSectionList ==
                        null) ||
                (selectedIndex == 6 &&
                    context.read<WorkLocationCubit>().pointModel == null &&
                    context.read<WorkLocationCubit>().deletedPointList == null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(selectedIndex: selectedIndex),
                  verticalSpace(10),
                  twoButtonsIntegration(
                    selectedIndex: cubit.tapIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.getActiveCount(selectedIndex),
                    firstLabel: "Total ${cubit.tapList[selectedIndex]}",
                    secondCount: cubit.getDeletedCount(selectedIndex),
                    secondLabel: "Deleted ${cubit.tapList[selectedIndex]}",
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  if (cubit.tapIndex == 0) ...[
                    Expanded(
                      child: (selectedIndex == 0
                              ? state is AreaLoadingState &&
                                  (context.read<WorkLocationCubit>().areaModel ==
                                      null)
                              : selectedIndex == 1
                                  ? state is CityLoadingState &&
                                      (context
                                              .read<WorkLocationCubit>()
                                              .cityModel ==
                                          null)
                                  : selectedIndex == 2
                                      ? state is OrganizationLoadingState &&
                                          (context
                                                  .read<WorkLocationCubit>()
                                                  .organizationModel ==
                                              null)
                                      : selectedIndex == 3
                                          ? state is BuildingLoadingState &&
                                              (context
                                                      .read<WorkLocationCubit>()
                                                      .buildingModel ==
                                                  null)
                                          : selectedIndex == 4
                                              ? state is FloorLoadingState &&
                                                  (context
                                                          .read<
                                                              WorkLocationCubit>()
                                                          .floorModel ==
                                                      null)
                                              : selectedIndex == 5
                                                  ? state is SectionLoadingState &&
                                                      (context
                                                              .read<
                                                                  WorkLocationCubit>()
                                                              .sectionModel ==
                                                          null)
                                                  : state is PointLoadingState &&
                                                      (context
                                                              .read<
                                                                  WorkLocationCubit>()
                                                              .pointModel ==
                                                          null))
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor))
                          : workLocationDetailsBuild(context, selectedIndex),
                    ),
                    verticalSpace(10),
                  ],
                  if (cubit.tapIndex == 1) ...[
                    Expanded(
                      child: (selectedIndex == 0
                              ? state is DeletedAreaLoadingState &&
                                  (context
                                          .read<WorkLocationCubit>()
                                          .deletedAreaList ==
                                      null)
                              : selectedIndex == 1
                                  ? state is DeletedCityLoadingState &&
                                      (context
                                              .read<WorkLocationCubit>()
                                              .deletedCityList ==
                                          null)
                                  : selectedIndex == 2
                                      ? state is DeletedOrganizationLoadingState &&
                                          (context
                                                  .read<WorkLocationCubit>()
                                                  .deletedOrganizationList ==
                                              null)
                                      : selectedIndex == 3
                                          ? state is DeletedBuildingLoadingState &&
                                              (context
                                                      .read<WorkLocationCubit>()
                                                      .deletedBuildingList ==
                                                  null)
                                          : selectedIndex == 4
                                              ? state is DeletedFloorLoadingState &&
                                                  (context
                                                          .read<
                                                              WorkLocationCubit>()
                                                          .deletedFloorList ==
                                                      null)
                                              : selectedIndex == 5
                                                  ? state is DeletedSectionLoadingState &&
                                                      (context
                                                              .read<
                                                                  WorkLocationCubit>()
                                                              .deletedSectionList ==
                                                          null)
                                                  : state is DeletedPointLoadingState &&
                                                      (context
                                                              .read<
                                                                  WorkLocationCubit>()
                                                              .deletedPointList ==
                                                          null))
                          ? Center(child: CircularProgressIndicator(color: AppColor.primaryColor))
                          : deleteWorkLocationListBuild(context, selectedIndex),
                    ),
                    verticalSpace(10),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
