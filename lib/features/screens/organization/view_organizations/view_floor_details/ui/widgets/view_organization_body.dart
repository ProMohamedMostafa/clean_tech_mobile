import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/organization/view_organizations/view_area_details/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_states.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FloorDetailsScreenBody extends StatefulWidget {
  final int id;
  const FloorDetailsScreenBody({super.key, required this.id});

  @override
  State<FloorDetailsScreenBody> createState() =>
      _FloorDetailsScreenBodyState();
}

class _FloorDetailsScreenBodyState extends State<FloorDetailsScreenBody> {
  @override
  void initState() {
    context.read<OrganizationsCubit>().getFloorDetails(widget.id);

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
                // context.pushNamed(Routes.editUserScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<OrganizationsCubit, OrganizationsState>(
        listener: (context, state) {
          // if (state is UserDeleteInDetailsSuccessState) {
          //   toast(
          //       text: state.deleteUserDetailsModel.message!,
          //       color: Colors.blue);
          //   context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          // }
          // if (state is UserDeleteInDetailsErrorState) {
          //   toast(text: state.error, color: Colors.red);
          // }
        },
        builder: (context, state) {
          return state is FloorDetailsLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        verticalSpace(25),
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
                            "Manager Name",
                            context
                                    .read<OrganizationsCubit>()
                                    .floorDetailsModel!
                                    .data!
                                    .managers!
                                    .isEmpty
                                ? ""
                                : context
                                    .read<OrganizationsCubit>()
                                    .floorDetailsModel!
                                    .data!
                                    .managers
                                    .toString()),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
                        verticalSpace(15),
                        DefaultElevatedButton(
                            name: S.of(context).deleteButton,
                            onPressed: () {
                              showCustomDialog(
                                  context, S.of(context).deleteMessage, () {
                                // context
                                //     .read<UserManagementCubit>()
                                //     .userDeleteInDetails(widget.id);
                              });
                            },
                            color: AppColor.primaryColor,
                            height: 48,
                            width: double.infinity,
                            textStyles: TextStyles.font20Whitesemimedium),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
