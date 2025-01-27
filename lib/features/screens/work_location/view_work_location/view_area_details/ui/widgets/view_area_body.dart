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

class AreaDetailsScreenBody extends StatefulWidget {
  final int id;
  const AreaDetailsScreenBody({super.key, required this.id});

  @override
  State<AreaDetailsScreenBody> createState() => _AreaDetailsScreenBodyState();
}

class _AreaDetailsScreenBodyState extends State<AreaDetailsScreenBody> {
  @override
  void initState() {
    context.read<OrganizationsCubit>().getAreaDetails(widget.id);
    context.read<OrganizationsCubit>().getAreaManagersDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Area details",
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editAreaScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<OrganizationsCubit, OrganizationsState>(
        listener: (context, state) {
          if (state is AreaDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.organizationsScreen);
          }
          if (state is AreaDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return (context.read<OrganizationsCubit>().areaManagersDetailsModel ==
                      null ||
                  context.read<OrganizationsCubit>().areaDetailsModel == null)
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
                        rowDetailsBuild(
                            context,
                            "Country Name",
                            context
                                .read<OrganizationsCubit>()
                                .areaDetailsModel!
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
                                .areaDetailsModel!
                                .data!
                                .name!),
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
                                    .areaManagersDetailsModel!
                                    .data!
                                    .managers!
                                    .isEmpty
                                ? Text("No Managers")
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: context
                                        .read<OrganizationsCubit>()
                                        .areaManagersDetailsModel!
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
                                    .areaManagersDetailsModel!
                                    .data!
                                    .supervisors!
                                    .isEmpty
                                ? Text("No Supervisors")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: context
                                        .read<OrganizationsCubit>()
                                        .areaManagersDetailsModel!
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
                                    .areaManagersDetailsModel!
                                    .data!
                                    .cleaners!
                                    .isEmpty
                                ? Text("No Cleaners")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: context
                                        .read<OrganizationsCubit>()
                                        .areaManagersDetailsModel!
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
                        verticalSpace(15),
                        state is AreaDeleteLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ))
                            : DefaultElevatedButton(
                                name: S.of(context).deleteButton,
                                onPressed: () {
                                  showCustomDialog(
                                      context, S.of(context).deleteMessage, () {
                                    context
                                        .read<OrganizationsCubit>()
                                        .deleteArea(widget.id);
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
