import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter_top_widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CustomFilterWorkLocationDialog {
  static Future<String?> show(
      {required BuildContext context, selectedIndex}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        int? areaId;
        int? cityId;
        int? organizationId;
        int? buildingId;
        int? floorId;
        int? sectionId;
        return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      if (selectedIndex == 0 || selectedIndex == 1) ...[
                        Text(
                          S.of(context).addUserText12,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Country',
                          items: context
                                      .read<WorkLocationCubit>()
                                      .nationalityModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No countries']
                              : context
                                      .read<WorkLocationCubit>()
                                      .nationalityModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            context.read<WorkLocationCubit>().getAreas(context
                                .read<WorkLocationCubit>()
                                .countryController
                                .text
                                .toString());
                          },
                          controller: context
                              .read<WorkLocationCubit>()
                              .countryController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                      ],
                      if (selectedIndex == 1 || selectedIndex == 2) ...[
                        Text(
                          'Area',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select area",
                          items: selectedIndex == 1
                              ? context
                                          .read<WorkLocationCubit>()
                                          .areasModel
                                          ?.data
                                          ?.areas
                                          ?.isEmpty ??
                                      true
                                  ? ['No Areas']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .areasModel
                                          ?.data
                                          ?.areas
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      []
                              : context
                                          .read<WorkLocationCubit>()
                                          .areaModel
                                          ?.data
                                          ?.areas
                                          ?.isEmpty ??
                                      true
                                  ? ['No Areas']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .areaModel
                                          ?.data
                                          ?.areas
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                          onPressed: (value) {
                            final selectedArea = selectedIndex == 1
                                ? context
                                    .read<WorkLocationCubit>()
                                    .areasModel
                                    ?.data
                                    ?.areas
                                    ?.firstWhere((area) =>
                                        area.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .areaController
                                            .text)
                                    .id
                                : context
                                    .read<WorkLocationCubit>()
                                    .areaModel
                                    ?.data
                                    ?.areas
                                    ?.firstWhere((area) =>
                                        area.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .areaController
                                            .text)
                                    .id;

                            context
                                .read<WorkLocationCubit>()
                                .getCityy(selectedArea!);
                            areaId = selectedArea;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<WorkLocationCubit>().areaController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (selectedIndex == 2 || selectedIndex == 3) ...[
                        Text(
                          'City',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select cities",
                          items: selectedIndex == 2
                              ? context
                                          .read<WorkLocationCubit>()
                                          .cityyModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No Cities']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .cityyModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      []
                              : context
                                          .read<WorkLocationCubit>()
                                          .cityModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No Cities']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .cityModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                          onPressed: (value) {
                            final selectedCity = selectedIndex == 2
                                ? context
                                    .read<WorkLocationCubit>()
                                    .cityyModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((city) =>
                                        city.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .cityController
                                            .text)
                                    .id
                                : context
                                    .read<WorkLocationCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((city) =>
                                        city.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .cityController
                                            .text)
                                    .id;

                            context
                                .read<WorkLocationCubit>()
                                .getOrganizations(selectedCity!);
                            cityId = selectedCity;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<WorkLocationCubit>().cityController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (selectedIndex == 3 || selectedIndex == 4) ...[
                        Text(
                          'Organization',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select organizations",
                          items: selectedIndex == 3
                              ? context
                                          .read<WorkLocationCubit>()
                                          .organizationsModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No organizations']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .organizationsModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      []
                              : context
                                          .read<WorkLocationCubit>()
                                          .organizationModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No organizations']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .organizationModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                          onPressed: (value) {
                            final selectedOrganization = selectedIndex == 3
                                ? context
                                    .read<WorkLocationCubit>()
                                    .organizationsModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((organization) =>
                                        organization.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .organizationController
                                            .text)
                                    .id
                                : context
                                    .read<WorkLocationCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((organization) =>
                                        organization.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .organizationController
                                            .text)
                                    .id;

                            context
                                .read<WorkLocationCubit>()
                                .getBuildings(selectedOrganization!);
                            organizationId = selectedOrganization;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<WorkLocationCubit>()
                              .organizationController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (selectedIndex == 4 || selectedIndex == 5) ...[
                        Text(
                          'Building',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select building",
                          items: selectedIndex == 4
                              ? context
                                          .read<WorkLocationCubit>()
                                          .buildingsModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No building']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .buildingsModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      []
                              : context
                                          .read<WorkLocationCubit>()
                                          .buildingModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No building']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .buildingModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                          onPressed: (value) {
                            final selectedBuilding = selectedIndex == 4
                                ? context
                                    .read<WorkLocationCubit>()
                                    .buildingsModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((building) =>
                                        building.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .buildingController
                                            .text)
                                    .id
                                : context
                                    .read<WorkLocationCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((building) =>
                                        building.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .buildingController
                                            .text)
                                    .id;

                            context
                                .read<WorkLocationCubit>()
                                .getFloors(selectedBuilding!);
                            buildingId = selectedBuilding;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<WorkLocationCubit>()
                              .buildingController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (selectedIndex == 5 || selectedIndex == 6) ...[
                        Text(
                          'Floor',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select floor",
                          items: selectedIndex == 5
                              ? context
                                          .read<WorkLocationCubit>()
                                          .floorsModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No floor']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .floorsModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      []
                              : context
                                          .read<WorkLocationCubit>()
                                          .floorModel
                                          ?.data
                                          ?.data
                                          ?.isEmpty ??
                                      true
                                  ? ['No floor']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .floorModel
                                          ?.data
                                          ?.data
                                          ?.map((e) => e.name ?? 'Unknown')
                                          .toList() ??
                                      [],
                          onPressed: (value) {
                            final selectedFloor = selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .floorsModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((floor) =>
                                        floor.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .floorController
                                            .text)
                                    .id
                                : context
                                    .read<WorkLocationCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.firstWhere((floor) =>
                                        floor.name ==
                                        context
                                            .read<WorkLocationCubit>()
                                            .floorController
                                            .text)
                                    .id;

                            context
                                .read<WorkLocationCubit>()
                                .getFloors(selectedFloor!);
                            floorId = selectedFloor;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<WorkLocationCubit>().floorController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                      ],
                      if (selectedIndex == 6) ...[
                        Text(
                          'Section',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select section",
                          items: context
                                      .read<WorkLocationCubit>()
                                      .sectionsModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No section']
                              : context
                                      .read<WorkLocationCubit>()
                                      .sectionModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedSection = context
                                .read<WorkLocationCubit>()
                                .sectionsModel
                                ?.data
                                ?.data
                                ?.firstWhere((section) =>
                                    section.name ==
                                    context
                                        .read<WorkLocationCubit>()
                                        .sectionController
                                        .text);

                            context
                                .read<WorkLocationCubit>()
                                .getPoints(selectedSection!.id!);
                            sectionId = selectedSection.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<WorkLocationCubit>()
                              .sectionController,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              selectedIndex == 0
                                  ? context.read<WorkLocationCubit>().getArea(
                                        country: context
                                            .read<WorkLocationCubit>()
                                            .countryController
                                            .text,
                                      )
                                  : selectedIndex == 1
                                      ? context
                                          .read<WorkLocationCubit>()
                                          .getCity(
                                            country: context
                                                .read<WorkLocationCubit>()
                                                .countryController
                                                .text,
                                            areaId: areaId,
                                          )
                                      : selectedIndex == 2
                                          ? context
                                              .read<WorkLocationCubit>()
                                              .getOrganization(
                                                areaId: areaId,
                                                cityId: cityId,
                                              )
                                          : selectedIndex == 3
                                              ? context
                                                  .read<WorkLocationCubit>()
                                                  .getBuilding(
                                                    cityId: cityId,
                                                    organizationId:
                                                        organizationId,
                                                  )
                                              : selectedIndex == 4
                                                  ? context
                                                      .read<WorkLocationCubit>()
                                                      .getFloor(
                                                        organizationId:
                                                            organizationId,
                                                        buildingId: buildingId,
                                                      )
                                                  : selectedIndex == 5
                                                      ? context
                                                          .read<
                                                              WorkLocationCubit>()
                                                          .getSection(
                                                            buildingId:
                                                                buildingId,
                                                            floorId: floorId,
                                                          )
                                                      : context
                                                          .read<
                                                              WorkLocationCubit>()
                                                          .getPoint(
                                                            floorId: floorId,
                                                            sectionId:
                                                                sectionId,
                                                          );
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
