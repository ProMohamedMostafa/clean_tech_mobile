import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/organizations_states.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FloorDetailsScreenBody extends StatefulWidget {
  final int id;
  const FloorDetailsScreenBody({super.key, required this.id});

  @override
  State<FloorDetailsScreenBody> createState() => _FloorDetailsScreenBodyState();
}

class _FloorDetailsScreenBodyState extends State<FloorDetailsScreenBody> {
  @override
  void initState() {
    context.read<OrganizationsCubit>().getFloorDetails(widget.id);
    context.read<OrganizationsCubit>().getFloorManagersDetails(widget.id);
    context.read<OrganizationsCubit>().getFloorShiftsDetails(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Floor details",
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editFloorScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<OrganizationsCubit, OrganizationsState>(
        listener: (context, state) {
          if (state is FloorDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
          }
          if (state is FloorDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return (context.read<OrganizationsCubit>().floorDetailsModel ==
                      null ||
                  context
                          .read<OrganizationsCubit>()
                          .floorManagersDetailsModel ==
                      null ||
                  context.read<OrganizationsCubit>().floorShiftsDetailsModel ==
                      null)
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ))
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                          rowDetailsBuild(
                              context,
                              "Country Name",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .countryName!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "Area Name",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .areaName!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "City Name",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .cityName!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "Organization Name",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .organizationName!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "Building Name",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .buildingName!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "Floor Name",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .name!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "Floor Number",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .number!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          rowDetailsBuild(
                              context,
                              "Floor description",
                              context
                                  .read<OrganizationsCubit>()
                                  .floorDetailsModel!
                                  .data!
                                  .description!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Managers Name",
                                style: TextStyles.font14GreyRegular,
                              ),
                              context
                                      .read<OrganizationsCubit>()
                                      .floorManagersDetailsModel!
                                      .data!
                                      .managers!
                                      .isEmpty
                                  ? Text("No Managers")
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: context
                                          .read<OrganizationsCubit>()
                                          .floorManagersDetailsModel!
                                          .data!
                                          .managers!
                                          .map((manager) =>
                                              Text(manager.userName ?? ""))
                                          .toList(),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Supervisors Name",
                                style: TextStyles.font14GreyRegular,
                              ),
                              context
                                      .read<OrganizationsCubit>()
                                      .floorManagersDetailsModel!
                                      .data!
                                      .supervisors!
                                      .isEmpty
                                  ? Text("No Supervisors")
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: context
                                          .read<OrganizationsCubit>()
                                          .floorManagersDetailsModel!
                                          .data!
                                          .supervisors!
                                          .map((supervisor) =>
                                              Text(supervisor.userName ?? ""))
                                          .toList(),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cleaners Name",
                                style: TextStyles.font14GreyRegular,
                              ),
                              context
                                      .read<OrganizationsCubit>()
                                      .floorManagersDetailsModel!
                                      .data!
                                      .cleaners!
                                      .isEmpty
                                  ? Text("No Cleaners")
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: context
                                          .read<OrganizationsCubit>()
                                          .floorManagersDetailsModel!
                                          .data!
                                          .cleaners!
                                          .map((cleaner) =>
                                              Text(cleaner.userName ?? ""))
                                          .toList(),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shifts",
                                style: TextStyles.font14GreyRegular,
                              ),
                              context
                                      .read<OrganizationsCubit>()
                                      .floorShiftsDetailsModel!
                                      .data!
                                      .shifts!
                                      .isEmpty
                                  ? Text("No Shifts")
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: context
                                          .read<OrganizationsCubit>()
                                          .floorShiftsDetailsModel!
                                          .data!
                                          .shifts!
                                          .map((cleaner) =>
                                              Text(cleaner.name ?? ""))
                                          .toList(),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          verticalSpace(15),
                          state is FloorDeleteLoadingState
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ))
                              : DefaultElevatedButton(
                                  name: S.of(context).deleteButton,
                                  onPressed: () {
                                    showCustomDialog(
                                        context, S.of(context).deleteMessage,
                                        () {
                                      context
                                          .read<OrganizationsCubit>()
                                          .deleteFloor(widget.id);
                                    });
                                  },
                                  color: AppColor.primaryColor,
                                  height: 48,
                                  width: double.infinity,
                                  textStyles: TextStyles.font20Whitesemimedium),
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
