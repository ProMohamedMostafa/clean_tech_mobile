import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter_top_widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CustomFilterUserDialog {
  static Future<String?> show({
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        int? areaId;
        int? cityId;
        int? organizationId;
        int? buildingId;
        int? floorId;
        int? sectionId;
        int? pointId;
        int? providerId;
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
                      Text(
                        S.of(context).addUserText12,
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: 'Select Country',
                        items: context
                                    .read<UserManagementCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No countries']
                            : context
                                    .read<UserManagementCubit>()
                                    .nationalityModel
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          context.read<UserManagementCubit>().getArea(context
                              .read<UserManagementCubit>()
                              .countryController
                              .text
                              .toString());
                        },
                        controller: context
                            .read<UserManagementCubit>()
                            .countryController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                      Text(
                        'Area',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select area",
                        items: context
                                    .read<UserManagementCubit>()
                                    .areaModel
                                    ?.data
                                    ?.areas
                                    ?.isEmpty ??
                                true
                            ? ['No Areas']
                            : context
                                    .read<UserManagementCubit>()
                                    .areaModel
                                    ?.data
                                    ?.areas
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedArea = context
                              .read<UserManagementCubit>()
                              .areaModel
                              ?.data
                              ?.areas
                              ?.firstWhere((area) =>
                                  area.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .areaController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getCity(selectedArea!.id!);
                          areaId = selectedArea.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().areaController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'City',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select cities",
                        items: context
                                    .read<UserManagementCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No Cities']
                            : context
                                    .read<UserManagementCubit>()
                                    .cityModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedCity = context
                              .read<UserManagementCubit>()
                              .cityModel
                              ?.data
                              ?.data
                              ?.firstWhere((city) =>
                                  city.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .cityController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getOrganization(selectedCity!.id!);
                          cityId = selectedCity.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().cityController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Organization',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select organizations",
                        items: context
                                    .read<UserManagementCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No organizations']
                            : context
                                    .read<UserManagementCubit>()
                                    .organizationModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedOrganization = context
                              .read<UserManagementCubit>()
                              .organizationModel
                              ?.data
                              ?.data
                              ?.firstWhere((organization) =>
                                  organization.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .organizationController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getBuilding(selectedOrganization!.id!);
                          organizationId = selectedOrganization.id!;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<UserManagementCubit>()
                            .organizationController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Building',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select building",
                        items: context
                                    .read<UserManagementCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No building']
                            : context
                                    .read<UserManagementCubit>()
                                    .buildingModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedBuilding = context
                              .read<UserManagementCubit>()
                              .buildingModel
                              ?.data
                              ?.data
                              ?.firstWhere((building) =>
                                  building.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .buildingController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getFloor(selectedBuilding!.id!);
                          buildingId = selectedBuilding.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<UserManagementCubit>()
                            .buildingController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Floor',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select floor",
                        items: context
                                    .read<UserManagementCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No floors']
                            : context
                                    .read<UserManagementCubit>()
                                    .floorModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedFloor = context
                              .read<UserManagementCubit>()
                              .floorModel
                              ?.data
                              ?.data
                              ?.firstWhere((floor) =>
                                  floor.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .floorController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getPoint(selectedFloor!.id!);
                          floorId = selectedFloor.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().floorController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Section',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select section",
                        items: context
                                    .read<UserManagementCubit>()
                                    .sectionModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No sections']
                            : context
                                    .read<UserManagementCubit>()
                                    .sectionModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedSection = context
                              .read<UserManagementCubit>()
                              .sectionModel
                              ?.data
                              ?.data
                              ?.firstWhere((section) =>
                                  section.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .sectionController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getPoint(selectedSection!.id!);
                          sectionId = selectedSection.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller: context
                            .read<UserManagementCubit>()
                            .sectionController,
                        keyboardType: TextInputType.text,
                      ),
                      verticalSpace(10),
                      Text(
                        'Point',
                        style: TextStyles.font16BlackRegular,
                      ),
                      CustomDropDownList(
                        hint: "Select point",
                        items: context
                                    .read<UserManagementCubit>()
                                    .pointModel
                                    ?.data
                                    ?.data
                                    ?.isEmpty ??
                                true
                            ? ['No point']
                            : context
                                    .read<UserManagementCubit>()
                                    .pointModel
                                    ?.data
                                    ?.data
                                    ?.map((e) => e.name ?? 'Unknown')
                                    .toList() ??
                                [],
                        onPressed: (value) {
                          final selectedPoint = context
                              .read<UserManagementCubit>()
                              .pointModel
                              ?.data
                              ?.data
                              ?.firstWhere((point) =>
                                  point.name ==
                                  context
                                      .read<UserManagementCubit>()
                                      .pointController
                                      .text);

                          context
                              .read<UserManagementCubit>()
                              .getPoint(selectedPoint!.id!);
                          pointId = selectedPoint.id;
                        },
                        suffixIcon: IconBroken.arrowDown2,
                        controller:
                            context.read<UserManagementCubit>().pointController,
                        keyboardType: TextInputType.text,
                      ),
                      if (role == 'Admin') ...[
                        verticalSpace(10),
                        Text(
                          'Provider',
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          hint: 'Select Provider',
                          items: context
                                      .read<UserManagementCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No providers available']
                              : context
                                      .read<UserManagementCubit>()
                                      .providersModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedProvider = context
                                .read<UserManagementCubit>()
                                .pointModel
                                ?.data
                                ?.data
                                ?.firstWhere((provider) =>
                                    provider.name ==
                                    context
                                        .read<UserManagementCubit>()
                                        .providerController
                                        .text);

                            context
                                .read<UserManagementCubit>()
                                .getPoint(selectedProvider!.id!);
                            providerId = selectedProvider.id;
                          },
                          controller: context
                              .read<UserManagementCubit>()
                              .providerController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10)
                      ],
                      if (role != 'Supervisor') ...[
                        Text(
                          S.of(context).addUserText13,
                          style: TextStyles.font16BlackRegular,
                        ),
                        CustomDropDownList(
                          onPressed: (selectedValue) {
                            final selectedId = context
                                .read<UserManagementCubit>()
                                .roleModel
                                ?.data
                                ?.firstWhere(
                                  (role) => role.name == selectedValue,
                                )
                                .id
                                ?.toString();

                            if (selectedId != null) {
                              context
                                  .read<UserManagementCubit>()
                                  .roleIdController
                                  .text = selectedId;
                            }
                          },
                          hint: 'Select Role',
                          items: context
                                      .read<UserManagementCubit>()
                                      .roleModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No roles available']
                              : context
                                      .read<UserManagementCubit>()
                                      .roleModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          controller: context
                              .read<UserManagementCubit>()
                              .roleController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                      ],
                      verticalSpace(20),
                      Center(
                        child: DefaultElevatedButton(
                            name: 'Done',
                            onPressed: () {
                              context
                                  .read<UserManagementCubit>()
                                  .getAllUsersInUserManage(
                                      areaId: areaId,
                                      cityId: cityId,
                                      organizationId: organizationId,
                                      buildingId: buildingId,
                                      floorId: floorId,
                                      sectionId: sectionId,
                                      pointId: pointId,
                                      providerId: providerId);
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
