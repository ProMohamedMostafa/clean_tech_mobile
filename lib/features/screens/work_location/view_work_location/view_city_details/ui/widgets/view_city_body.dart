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
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_states.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class CityDetailsScreenBody extends StatefulWidget {
  final int id;
  const CityDetailsScreenBody({super.key, required this.id});

  @override
  State<CityDetailsScreenBody> createState() => _CityDetailsScreenBodyState();
}

class _CityDetailsScreenBodyState extends State<CityDetailsScreenBody> {
  @override
  void initState() {
    context.read<WorkLocationCubit>().getCityDetails(widget.id);
    context.read<WorkLocationCubit>().getCityManagersDetails(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "City details",
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: customBackButton(context),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editCityScreen, arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<WorkLocationCubit, WorkLocationState>(
        listener: (context, state) {
          if (state is CityDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.workLocationScreen);
          }
          if (state is CityDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return (context.read<WorkLocationCubit>().cityManagersDetailsModel ==
                      null ||
                  context.read<WorkLocationCubit>().cityDetailsModel == null)
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
                                .read<WorkLocationCubit>()
                                .cityDetailsModel!
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
                                .read<WorkLocationCubit>()
                                .cityDetailsModel!
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
                                .read<WorkLocationCubit>()
                                .cityDetailsModel!
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
                                    .read<WorkLocationCubit>()
                                    .cityManagersDetailsModel!
                                    .data!
                                    .managers!
                                    .isEmpty
                                ? Text("No Managers")
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: context
                                        .read<WorkLocationCubit>()
                                        .cityManagersDetailsModel!
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
                                    .read<WorkLocationCubit>()
                                    .cityManagersDetailsModel!
                                    .data!
                                    .supervisors!
                                    .isEmpty
                                ? Text("No Supervisors")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: context
                                        .read<WorkLocationCubit>()
                                        .cityManagersDetailsModel!
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
                                    .read<WorkLocationCubit>()
                                    .cityManagersDetailsModel!
                                    .data!
                                    .cleaners!
                                    .isEmpty
                                ? Text("No Cleaners")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: context
                                        .read<WorkLocationCubit>()
                                        .cityManagersDetailsModel!
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
                        state is CityDeleteLoadingState
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
                                        .read<WorkLocationCubit>()
                                        .deleteCity(widget.id);
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
