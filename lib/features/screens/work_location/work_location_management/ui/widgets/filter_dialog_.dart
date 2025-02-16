import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                          ?.isEmpty ??
                                      true
                                  ? ['No Areas']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .areasModel
                                          ?.data
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
                                          ?.isEmpty ??
                                      true
                                  ? ['No Cities']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .cityyModel
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
                                          ?.isEmpty ??
                                      true
                                  ? ['No organizations']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .organizationsModel
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
                                          ?.isEmpty ??
                                      true
                                  ? ['No building']
                                  : context
                                          .read<WorkLocationCubit>()
                                          .buildingsModel
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
                      if (selectedIndex == 5) ...[
                        Text(
                          'Floor',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: "Select floor",
                          items: context
                                      .read<WorkLocationCubit>()
                                      .floorsModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No floors']
                              : context
                                      .read<WorkLocationCubit>()
                                      .floorsModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedFloor = context
                                .read<WorkLocationCubit>()
                                .floorsModel
                                ?.data
                                ?.firstWhere((floor) =>
                                    floor.name ==
                                    context
                                        .read<WorkLocationCubit>()
                                        .floorController
                                        .text);

                            context
                                .read<WorkLocationCubit>()
                                .getPoints(selectedFloor!.id!);
                            floorId = selectedFloor.id;
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<WorkLocationCubit>().floorController,
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
                                                  : context
                                                      .read<WorkLocationCubit>()
                                                      .getPoint(
                                                        buildingId: buildingId,
                                                        floorId: floorId,
                                                      );
                              context.pop();
                            },
                            color: AppColor.primaryColor,
                            height: 47,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ),
                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
