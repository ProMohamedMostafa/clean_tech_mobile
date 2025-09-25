import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/widget/filter_top_widget.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/data/models/filter_location.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/feedback_overview/logic/cubit/feedback_overview_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';

class FilterLocationDialog extends StatelessWidget {
  final Function(FilterLocationModel) onPressed;
  const FilterLocationDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        insetPadding: EdgeInsets.all(20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocProvider.value(
            value: context.read<FeedbackOverviewCubit>(),
            child: BlocBuilder<FeedbackOverviewCubit, FeedbackOverviewState>(
              builder: (context, state) {
                final cubit = context.read<FeedbackOverviewCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Header(),
                    Text(
                      S.of(context).workLocation,
                      style: TextStyles.font16BlackRegular,
                    ),
                    CustomDropDownList(
                      hint: S.of(context).select_work_location,
                      controller: cubit.levelController,
                      color: AppColor.primaryColor,
                      items: cubit.levelOrder,
                      onChanged: (value) {
                        cubit.setSelectedLevel(value!);
                      },
                      suffixIcon: IconBroken.arrowDown2,
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(10),
                    if (cubit.shouldShow('Area')) ...[
                      _buildDropdown(
                        context,
                        title: S.of(context).Area,
                        hint: S.of(context).selectArea,
                        controller: cubit.areaController,
                        items: cubit.areaItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedArea = cubit.areaListModel?.data?.data
                              ?.firstWhere((area) =>
                                  area.name == cubit.areaController.text)
                              .id
                              ?.toString();

                          if (selectedArea != null) {
                            cubit.areaIdController.text = selectedArea;
                          }
                          cubit.getCity();
                        },
                      ),
                    ],
                    if (cubit.shouldShow('City')) ...[
                      _buildDropdown(
                        context,
                        title: S.of(context).City,
                        hint: S.of(context).selectCity,
                        controller: cubit.cityController,
                        items: cubit.cityItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedCity = cubit.cityModel?.data?.data
                              ?.firstWhere(
                                (city) =>
                                    city.name == cubit.cityController.text,
                              )
                              .id
                              ?.toString();

                          if (selectedCity != null) {
                            cubit.cityIdController.text = selectedCity;
                          }
                          cubit.getOrganization();
                        },
                      ),
                    ],
                    if (cubit.shouldShow('Organization')) ...[
                      _buildDropdown(
                        context,
                        title: S.of(context).Organization,
                        hint: S.of(context).selectOrganizations,
                        controller: cubit.organizationController,
                        items: cubit.organizationItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedOrg =
                              cubit.organizationModel?.data?.data
                                  ?.firstWhere(
                                    (org) =>
                                        org.name ==
                                        cubit.organizationController.text,
                                  )
                                  .id
                                  ?.toString();

                          if (selectedOrg != null) {
                            cubit.organizationIdController.text = selectedOrg;
                          }
                          cubit.getBuilding();
                        },
                      ),
                    ],
                    if (cubit.shouldShow('Building')) ...[
                      _buildDropdown(
                        context,
                        title: S.of(context).Building,
                        hint: S.of(context).selectBuilding,
                        controller: cubit.buildingController,
                        items: cubit.buildingItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedBuilding = cubit
                              .buildingModel?.data?.data
                              ?.firstWhere(
                                (bld) =>
                                    bld.name == cubit.buildingController.text,
                              )
                              .id
                              ?.toString();

                          if (selectedBuilding != null) {
                            cubit.buildingIdController.text = selectedBuilding;
                          }
                          cubit.getFloor();
                        },
                      ),
                    ],
                    if (cubit.shouldShow('Floor')) ...[
                      _buildDropdown(
                        context,
                        title: S.of(context).Floor,
                        hint: S.of(context).selectFloor,
                        controller: cubit.floorController,
                        items: cubit.floorItem
                            .map((e) => e.name ?? 'Unknown')
                            .toList(),
                        onChanged: (value) {
                          final selectedFloor = cubit.floorModel?.data?.data
                              ?.firstWhere(
                                (floor) =>
                                    floor.name == cubit.floorController.text,
                              )
                              .id
                              ?.toString();

                          if (selectedFloor != null) {
                            cubit.floorIdController.text = selectedFloor;
                          }
                        },
                      ),
                    ],
                    verticalSpace(10),
                    Center(
                      child: DefaultElevatedButton(
                        name: S.of(context).doneButton2,
                        onPressed: () {
                          onPressed(FilterLocationModel(
                            areaId: cubit.areaIdController.text.isNotEmpty
                                ? _tryParseInt(cubit.areaIdController.text)
                                : null,
                            cityId: cubit.cityIdController.text.isNotEmpty
                                ? _tryParseInt(cubit.cityIdController.text)
                                : null,
                            organizationId:
                                cubit.organizationIdController.text.isNotEmpty
                                    ? _tryParseInt(
                                        cubit.organizationIdController.text)
                                    : null,
                            buildingId: cubit
                                    .buildingIdController.text.isNotEmpty
                                ? _tryParseInt(cubit.buildingIdController.text)
                                : null,
                            floorId: cubit.floorIdController.text.isNotEmpty
                                ? _tryParseInt(cubit.floorIdController.text)
                                : null,
                          ));
                          context.pop();
                        },
                        color: AppColor.primaryColor,
                        textStyles: TextStyles.font20Whitesemimedium,
                      ),
                    ),
                    verticalSpace(5),
                  ],
                );
              },
            ),
          ),
        )));
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String title,
    required String hint,
    required TextEditingController controller,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.font16BlackRegular),
        CustomDropDownList(
          hint: hint,
          controller: controller,
          items: items,
          onChanged: onChanged,
          suffixIcon: IconBroken.arrowDown2,
          keyboardType: TextInputType.text,
        ),
        verticalSpace(10),
      ],
    );
  }
}

int? _tryParseInt(String value) {
  if (value.isEmpty) return null;
  return int.tryParse(value);
}
