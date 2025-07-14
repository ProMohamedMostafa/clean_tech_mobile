import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/ui/widgets/work_location_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationBody extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationBody({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final WorkLocationCubit cubit = context.read<WorkLocationCubit>();

    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(selectedIndex == 0
              ? S.of(context).areas
              : selectedIndex == 1
                  ? S.of(context).cities
                  : selectedIndex == 2
                      ? S.of(context).organizations
                      : selectedIndex == 3
                          ? S.of(context).buildings
                          : selectedIndex == 4
                              ? S.of(context).floors
                              : selectedIndex == 5
                                  ? S.of(context).sections
                                  : S.of(context).points)),
      floatingActionButton: role == 'Admin'
          ? floatingActionButton(
              icon: Icons.add_home_outlined,
              onPressed: () async {
                dynamic result;

                switch (selectedIndex) {
                  case 0:
                    result = await context.pushNamed(Routes.addAreaScreen);
                    break;
                  case 1:
                    result = await context.pushNamed(Routes.addCityScreen);
                    break;
                  case 2:
                    result =
                        await context.pushNamed(Routes.addOrganizationScreen);
                    break;
                  case 3:
                    result = await context.pushNamed(Routes.addBuildingScreen);
                    break;
                  case 4:
                    result = await context.pushNamed(Routes.addFloorScreen);
                    break;
                  case 5:
                    result = await context.pushNamed(Routes.addSectionScreen);
                    break;
                  case 6:
                  default:
                    result = await context.pushNamed(Routes.addPointScreen);
                    break;
                }

                if (result == true) {
                  selectedIndex == 0
                      ? cubit.refreshAreas()
                      : selectedIndex == 1
                          ? cubit.refreshCities()
                          : selectedIndex == 2
                              ? cubit.refreshOrganizations()
                              : selectedIndex == 3
                                  ? cubit.refreshBuildings()
                                  : selectedIndex == 4
                                      ? cubit.refreshFloors()
                                      : selectedIndex == 5
                                          ? cubit.refreshSections()
                                          : cubit.refreshPoints();
                }
              },
            )
          : const SizedBox.shrink(),
      body: BlocConsumer<WorkLocationCubit, WorkLocationState>(
        listener: (context, state) {
          if (state is AreaErrorState || state is DeletedAreaErrorState) {
            final errorMessage = state is AreaErrorState
                ? state.error
                : (state as DeletedAreaErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceAreaSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getArea();
            cubit.getAllDeletedArea();
          }
          if (state is DeleteForceAreaErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreAreaSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreAreaErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is AreaDeleteSuccessState) {
            toast(text: state.deleteAreaModel.message!, isSuccess: true);
            cubit.getAllDeletedArea();
          }

          if (state is AreaDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */
          if (state is CityErrorState || state is DeletedCityErrorState) {
            final errorMessage = state is CityErrorState
                ? state.error
                : (state as DeletedCityErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceCitySuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getCity();
            cubit.getAllDeletedCity();
          }
          if (state is DeleteForceCityErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreCitySuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreCityErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is CityDeleteSuccessState) {
            toast(text: state.deleteCityModel.message!, isSuccess: true);
            cubit.getAllDeletedCity();
          }

          if (state is CityDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is OrganizationErrorState ||
              state is DeletedOrganizationErrorState) {
            final errorMessage = state is OrganizationErrorState
                ? state.error
                : (state as DeletedOrganizationErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceOrganizationSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getOrganization();
            cubit.getAllDeletedOrganization();
          }
          if (state is DeleteForceOrganizationErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreOrganizationSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreOrganizationErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is OrganizationDeleteSuccessState) {
            toast(
                text: state.deleteOrganizationModel.message!, isSuccess: true);
            cubit.getAllDeletedOrganization();
          }

          if (state is OrganizationDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */
          if (state is BuildingErrorState ||
              state is DeletedBuildingErrorState) {
            final errorMessage = state is BuildingErrorState
                ? state.error
                : (state as DeletedBuildingErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceBuildingSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getBuilding();
            cubit.getAllDeletedBuilding();
          }
          if (state is DeleteForceBuildingErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreBuildingSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreBuildingErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is BuildingDeleteSuccessState) {
            toast(text: state.deleteBuildingModel.message!, isSuccess: true);
            cubit.getAllDeletedBuilding();
          }

          if (state is BuildingDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */

          if (state is FloorErrorState || state is DeletedFloorErrorState) {
            final errorMessage = state is FloorErrorState
                ? state.error
                : (state as DeletedFloorErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceFloorSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getFloor();
            cubit.getAllDeletedFloor();
          }
          if (state is DeleteForceFloorErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreFloorSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreFloorErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, isSuccess: true);
            cubit.getAllDeletedFloor();
          }

          if (state is FloorDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */
          if (state is FloorErrorState || state is DeletedFloorErrorState) {
            final errorMessage = state is FloorErrorState
                ? state.error
                : (state as DeletedFloorErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceFloorSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getFloor();
            cubit.getAllDeletedFloor();
          }
          if (state is DeleteForceFloorErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreFloorSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreFloorErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is FloorDeleteSuccessState) {
            toast(text: state.deleteFloorModel.message!, isSuccess: true);
            cubit.getAllDeletedFloor();
          }

          if (state is FloorDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */
          if (state is SectionErrorState || state is DeletedSectionErrorState) {
            final errorMessage = state is SectionErrorState
                ? state.error
                : (state as DeletedSectionErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForceSectionSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getSection();
            cubit.getAllDeletedSection();
          }
          if (state is DeleteForceSectionErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreSectionSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreSectionErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is SectionDeleteSuccessState) {
            toast(text: state.deleteSectionModel.message!, isSuccess: true);
            cubit.getAllDeletedSection();
          }

          if (state is SectionDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */
          if (state is PointErrorState || state is DeletedPointErrorState) {
            final errorMessage = state is PointErrorState
                ? state.error
                : (state as DeletedPointErrorState).error;
            toast(text: errorMessage, isSuccess: false);
          }

          if (state is DeleteForcePointSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getPoint();
            cubit.getAllDeletedPoint();
          }
          if (state is DeleteForcePointErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestorePointSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestorePointErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is PointDeleteSuccessState) {
            toast(text: state.deletePointModel.message!, isSuccess: true);
            cubit.getAllDeletedPoint();
          }

          if (state is PointDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          //****************** */
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
                  FilterAndSearchWidget(
                    hintText: S.of(context).find_name_of_work_location,
                    searchController: cubit.searchController,
                    onSearchChanged: (value) {
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
                    onFilterTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return BlocProvider(
                            create: (context) {
                              switch (selectedIndex) {
                                case 0:
                                  return FilterDialogCubit()
                                    ..getCountry(false, true);
                                case 1:
                                  return FilterDialogCubit()
                                    ..getCountry(false, true);
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
                                                          cubit.filterModel =
                                                              data;
                                                          cubit.getSection();
                                                        },
                                                      )
                                                    : FilterDialogWidget(
                                                        index: 'W-p',
                                                        onPressed: (data) {
                                                          cubit.filterModel =
                                                              data;
                                                          cubit.getPoint();
                                                        },
                                                      ),
                          );
                        },
                      );
                    },
                  ),
                  verticalSpace(10),
                  integrationsButtons(
                    selectedIndex: cubit.tapIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.getActiveCount(selectedIndex),
                    firstLabel:
                        "${S.of(context).total} ${cubit.tapList[selectedIndex]}",
                    secondCount: role == 'Admin'
                        ? cubit.getDeletedCount(selectedIndex)
                        : null,
                    secondLabel: role == 'Admin'
                        ? "${S.of(context).deleted} ${cubit.tapList[selectedIndex]}"
                        : null,
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Colors.grey[300],
                    height: 0,
                  ),
                  verticalSpace(10),
                  Expanded(
                      child:
                          WorkLocationListBuild(selectedIndex: selectedIndex)),
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
