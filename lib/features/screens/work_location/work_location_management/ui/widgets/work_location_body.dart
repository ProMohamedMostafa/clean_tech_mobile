import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/delete_work_location_list.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_list_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_filter_search_build.dart';

class WorkLocationBody extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationBody({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final WorkLocationCubit cubit = context.read<WorkLocationCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
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
            cubit.getArea();
            cubit.getAllDeletedArea();
          }
          if (state is DeleteRestoreAreaSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is AreaDeleteSuccessState) {
            toast(text: state.deleteAreaModel.message!, color: Colors.blue);
            cubit.getAllDeletedArea();
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
            cubit.getCity();
            cubit.getAllDeletedCity();
          }
          if (state is DeleteRestoreCitySuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is CityDeleteSuccessState) {
            toast(text: state.deleteCityModel.message!, color: Colors.blue);
            cubit.getAllDeletedCity();
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
            cubit.getOrganization();
            cubit.getAllDeletedOrganization();
          }
          if (state is DeleteRestoreOrganizationSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is OrganizationDeleteSuccessState) {
            toast(
                text: state.deleteOrganizationModel.message!,
                color: Colors.blue);
            cubit.getAllDeletedOrganization();
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
            cubit.getBuilding();
            cubit.getAllDeletedBuilding();
          }
          if (state is DeleteRestoreBuildingSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is BuildingDeleteSuccessState) {
            toast(text: state.deleteBuildingModel.message!, color: Colors.blue);
            cubit.getAllDeletedBuilding();
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
            cubit.getFloor();
            cubit.getAllDeletedFloor();
          }
          if (state is DeleteRestoreFloorSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, color: Colors.blue);
            cubit.getAllDeletedFloor();
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
            cubit.getSection();
            cubit.getAllDeletedSection();
          }
          if (state is DeleteRestoreSectionSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is SectionDeleteSuccessState) {
            toast(text: state.deleteSectionModel.message!, color: Colors.blue);
            cubit.getAllDeletedSection();
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
            cubit.getPoint();
            cubit.getAllDeletedPoint();
          }
          if (state is DeleteRestorePointSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is PointDeleteSuccessState) {
            toast(text: state.deletePointModel.message!, color: Colors.blue);
            cubit.getAllDeletedPoint();
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: (selectedIndex == 0 &&
                    cubit.areaModel == null &&
                    cubit.deletedAreaList == null) ||
                (selectedIndex == 1 &&
                    cubit.cityModel == null &&
                    cubit.deletedCityList == null) ||
                (selectedIndex == 2 &&
                    cubit.organizationModel == null &&
                    cubit.deletedOrganizationList == null) ||
                (selectedIndex == 3 &&
                    cubit.buildingModel == null &&
                    cubit.deletedBuildingList == null) ||
                (selectedIndex == 4 &&
                    cubit.floorModel == null &&
                    cubit.deletedFloorList == null) ||
                (selectedIndex == 5 &&
                    cubit.sectionModel == null &&
                    cubit.deletedSectionList == null) ||
                (selectedIndex == 6 &&
                    cubit.pointModel == null &&
                    cubit.deletedPointList == null),
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
                    secondCount: role == 'Admin'
                        ? cubit.getDeletedCount(selectedIndex)
                        : null,
                    secondLabel: role == 'Admin'
                        ? "Deleted ${cubit.tapList[selectedIndex]}"
                        : null,
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                    height: 0,
                  ),
                  verticalSpace(10),
                  cubit.tapIndex == 0
                      ? Expanded(
                          child: WorkLocationListBuild(
                              selectedIndex: selectedIndex))
                      : role == 'Admin'
                          ? Expanded(
                              child: DeleteWorkLocationList(
                                  selectedIndex: selectedIndex))
                          : SizedBox.shrink(),
                  verticalSpace(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
