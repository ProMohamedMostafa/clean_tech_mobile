import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';

class EditShiftBody extends StatefulWidget {
  final int id;
  const EditShiftBody({super.key, required this.id});

  @override
  State<EditShiftBody> createState() => _EditShiftBodyState();
}

class _EditShiftBodyState extends State<EditShiftBody> {
  @override
  void initState() {
    context.read<EditShiftCubit>().getShiftDetails(widget.id);
    context.read<EditShiftCubit>().getShiftLevelDetails(widget.id);
    context.read<EditShiftCubit>().getOrganization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Shift",
          ),
          leading: customBackButton(context),
        ),
        body: BlocConsumer<EditShiftCubit, EditShiftState>(
          listener: (context, state) {
            if (state is EditShiftSuccessState) {
              toast(
                  text: state.editShiftDetailsModel.message!,
                  color: Colors.blue);
              context.pushNamedAndRemoveLastTwo(Routes.shiftScreen);
            }
            if (state is EditShiftErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditShiftCubit>();
            if (cubit.shiftDetailsModel == null ||
                cubit.shiftLevelDetailsModel == null) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor),
              );
            }

            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: context.read<EditShiftCubit>().formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shift Name",
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: context
                              .read<EditShiftCubit>()
                              .shiftDetailsModel!
                              .data!
                              .name!,
                          controller: context
                              .read<EditShiftCubit>()
                              .shiftNameController,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .startDate!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .startDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .startDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                            horizontalSpace(10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .endDate!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .endDateController,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    final selectedDate =
                                        await CustomDatePicker.show(
                                            context: context);

                                    if (selectedDate != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .endDateController
                                          .text = selectedDate;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Time",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .startTime!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .startTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .startTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start time is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                            horizontalSpace(10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Time",
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                CustomTextFormField(
                                  onlyRead: true,
                                  hint: context
                                      .read<EditShiftCubit>()
                                      .shiftDetailsModel!
                                      .data!
                                      .endTime!,
                                  controller: context
                                      .read<EditShiftCubit>()
                                      .endTimeController,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    final selectedTime =
                                        await CustomTimePicker.show(
                                            context: context);

                                    if (selectedTime != null &&
                                        context.mounted) {
                                      context
                                          .read<EditShiftCubit>()
                                          .endTimeController
                                          .text = selectedTime;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(10),
                        Text(
                          'Organization',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.organizations![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .allOrganizationModel
                                      ?.data
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No organizations']
                              : context
                                      .read<EditShiftCubit>()
                                      .allOrganizationModel
                                      ?.data
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedOrganization = context
                                .read<EditShiftCubit>()
                                .allOrganizationModel
                                ?.data
                                ?.data
                                ?.firstWhere((organization) =>
                                    organization.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .organizationController
                                        .text);

                            context
                                .read<EditShiftCubit>()
                                .getBuilding(selectedOrganization!.id!);
                            context
                                .read<EditShiftCubit>()
                                .organizationIdController
                                .text = selectedOrganization.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller: context
                              .read<EditShiftCubit>()
                              .organizationController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(15),
                        Text(
                          'Building',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.buildings![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No building']
                              : context
                                      .read<EditShiftCubit>()
                                      .buildingModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedBuilding = context
                                .read<EditShiftCubit>()
                                .buildingModel
                                ?.data
                                ?.firstWhere((building) =>
                                    building.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .buildingController
                                        .text);
                            context
                                .read<EditShiftCubit>()
                                .getFloor(selectedBuilding!.id!);
                            context
                                .read<EditShiftCubit>()
                                .buildingIdController
                                .text = selectedBuilding.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<EditShiftCubit>().buildingController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          'Floor',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.floors![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .floorModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No floors']
                              : context
                                      .read<EditShiftCubit>()
                                      .floorModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedFloor = context
                                .read<EditShiftCubit>()
                                .floorModel
                                ?.data
                                ?.firstWhere((floor) =>
                                    floor.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .floorController
                                        .text);

                            context
                                .read<EditShiftCubit>()
                                .getPoints(selectedFloor!.id!);
                            context
                                .read<EditShiftCubit>()
                                .floorIdController
                                .text = selectedFloor.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<EditShiftCubit>().floorController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(10),
                        Text(
                          'Point',
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: context
                                  .read<EditShiftCubit>()
                                  .shiftLevelDetailsModel!
                                  .data
                                  ?.points![0]
                                  .name
                                  .toString() ??
                              '',
                          items: context
                                      .read<EditShiftCubit>()
                                      .pointModel
                                      ?.data
                                      ?.isEmpty ??
                                  true
                              ? ['No point']
                              : context
                                      .read<EditShiftCubit>()
                                      .pointModel
                                      ?.data
                                      ?.map((e) => e.name ?? 'Unknown')
                                      .toList() ??
                                  [],
                          onPressed: (value) {
                            final selectedPoint = context
                                .read<EditShiftCubit>()
                                .pointModel
                                ?.data
                                ?.firstWhere((point) =>
                                    point.name ==
                                    context
                                        .read<EditShiftCubit>()
                                        .pointController
                                        .text);

                            context
                                .read<EditShiftCubit>()
                                .getPoints(selectedPoint!.id!);
                            context
                                .read<EditShiftCubit>()
                                .pointIdController
                                .text = selectedPoint.id!.toString();
                          },
                          suffixIcon: IconBroken.arrowDown2,
                          controller:
                              context.read<EditShiftCubit>().pointController,
                          isRead: false,
                          keyboardType: TextInputType.text,
                        ),
                        verticalSpace(20),
                        state is EditShiftLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Edit",
                                    onPressed: () {
                                      showCustomDialog(context,
                                          "Are you Sure you want save the edit of this shift ?",
                                          () {
                                        context
                                            .read<EditShiftCubit>()
                                            .editShift(widget.id);
                                        context.pop();
                                      });
                                    },
                                    color: AppColor.primaryColor,
                                    height: 47,
                                    width: double.infinity,
                                    textStyles:
                                        TextStyles.font20Whitesemimedium),
                              ),
                        verticalSpace(30),
                      ])),
            )));
          },
        ));
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';
// import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
// import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
// import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
// import 'package:smart_cleaning_application/core/routing/routes.dart';
// import 'package:smart_cleaning_application/core/theming/colors/color.dart';
// import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
// import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
// import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
// import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
// import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/building_model.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/floor_model.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/points_model.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_time_picker.dart';
// import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_cubit.dart';
// import 'package:smart_cleaning_application/features/screens/shift/edit_shift/logic/edit_shift_state.dart';

// import '../../../../integrations/data/models/all_organization_model.dart';

// class EditShiftBody extends StatefulWidget {
//   final int id;
//   const EditShiftBody({super.key, required this.id});

//   @override
//   State<EditShiftBody> createState() => _EditShiftBodyState();
// }

// class _EditShiftBodyState extends State<EditShiftBody> {
//   List<int> organizationsIds = [];
//   List<int> buildingsIds = [];
//   List<int> floorsIds = [];
//   List<int> pointsIds = [];
//   @override
//   void initState() {
//     context.read<EditShiftCubit>().getShiftDetails(widget.id);
//     context.read<EditShiftCubit>().getShiftLevelDetails(widget.id);
//     context.read<EditShiftCubit>().getOrganization();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Edit Shift",
//           ),
//           leading: customBackButton(context),
//         ),
//         body: BlocConsumer<EditShiftCubit, EditShiftState>(
//           listener: (context, state) {
//             if (state is EditShiftSuccessState) {
//               toast(
//                   text: state.editShiftDetailsModel.message!,
//                   color: Colors.blue);
//               context.pushNamedAndRemoveLastTwo(Routes.shiftScreen);
//             }
//             if (state is EditShiftErrorState) {
//               toast(text: state.error, color: Colors.red);
//             }
//           },
//           builder: (context, state) {
//             final cubit = context.read<EditShiftCubit>();
//             if (cubit.shiftDetailsModel == null) {
//               return const Center(
//                 child: CircularProgressIndicator(color: AppColor.primaryColor),
//               );
//             }

//             return SafeArea(
//                 child: SingleChildScrollView(
//                     child: Form(
//               key: context.read<EditShiftCubit>().formKey,
//               child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Shift Name",
//                           style: TextStyles.font16BlackRegular,
//                         ),
//                         verticalSpace(5),
//                         CustomTextFormField(
//                           onlyRead: false,
//                           hint: context
//                               .read<EditShiftCubit>()
//                               .shiftDetailsModel!
//                               .data!
//                               .name!,
//                           controller: context
//                               .read<EditShiftCubit>()
//                               .shiftNameController,
//                           keyboardType: TextInputType.text,
//                         ),
//                         verticalSpace(10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Start Date",
//                                   style: TextStyles.font16BlackRegular,
//                                 ),
//                                 verticalSpace(5),
//                                 CustomTextFormField(
//                                   onlyRead: true,
//                                   hint: context
//                                       .read<EditShiftCubit>()
//                                       .shiftDetailsModel!
//                                       .data!
//                                       .startDate!,
//                                   controller: context
//                                       .read<EditShiftCubit>()
//                                       .startDateController,
//                                   suffixIcon: Icons.calendar_today,
//                                   suffixPressed: () async {
//                                     final selectedDate =
//                                         await CustomDatePicker.show(
//                                             context: context);

//                                     if (selectedDate != null &&
//                                         context.mounted) {
//                                       context
//                                           .read<EditShiftCubit>()
//                                           .startDateController
//                                           .text = selectedDate;
//                                     }
//                                   },
//                                   keyboardType: TextInputType.none,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Start date is required";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             )),
//                             horizontalSpace(10),
//                             Expanded(
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "End Date",
//                                   style: TextStyles.font16BlackRegular,
//                                 ),
//                                 verticalSpace(5),
//                                 CustomTextFormField(
//                                   onlyRead: true,
//                                   hint: context
//                                       .read<EditShiftCubit>()
//                                       .shiftDetailsModel!
//                                       .data!
//                                       .endDate!,
//                                   controller: context
//                                       .read<EditShiftCubit>()
//                                       .endDateController,
//                                   suffixIcon: Icons.calendar_today,
//                                   suffixPressed: () async {
//                                     final selectedDate =
//                                         await CustomDatePicker.show(
//                                             context: context);

//                                     if (selectedDate != null &&
//                                         context.mounted) {
//                                       context
//                                           .read<EditShiftCubit>()
//                                           .endDateController
//                                           .text = selectedDate;
//                                     }
//                                   },
//                                   keyboardType: TextInputType.none,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Start date is required";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             )),
//                           ],
//                         ),
//                         verticalSpace(10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Start Time",
//                                   style: TextStyles.font16BlackRegular,
//                                 ),
//                                 verticalSpace(5),
//                                 CustomTextFormField(
//                                   onlyRead: true,
//                                   hint: context
//                                       .read<EditShiftCubit>()
//                                       .shiftDetailsModel!
//                                       .data!
//                                       .startTime!,
//                                   controller: context
//                                       .read<EditShiftCubit>()
//                                       .startTimeController,
//                                   suffixIcon: Icons.timer_sharp,
//                                   suffixPressed: () async {
//                                     final selectedTime =
//                                         await CustomTimePicker.show(
//                                             context: context);

//                                     if (selectedTime != null &&
//                                         context.mounted) {
//                                       context
//                                           .read<EditShiftCubit>()
//                                           .startTimeController
//                                           .text = selectedTime;
//                                     }
//                                   },
//                                   keyboardType: TextInputType.none,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Start time is required";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             )),
//                             horizontalSpace(10),
//                             Expanded(
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "End Time",
//                                   style: TextStyles.font16BlackRegular,
//                                 ),
//                                 verticalSpace(5),
//                                 CustomTextFormField(
//                                   onlyRead: true,
//                                   hint: context
//                                       .read<EditShiftCubit>()
//                                       .shiftDetailsModel!
//                                       .data!
//                                       .endTime!,
//                                   controller: context
//                                       .read<EditShiftCubit>()
//                                       .endTimeController,
//                                   suffixIcon: Icons.timer_sharp,
//                                   suffixPressed: () async {
//                                     final selectedTime =
//                                         await CustomTimePicker.show(
//                                             context: context);

//                                     if (selectedTime != null &&
//                                         context.mounted) {
//                                       context
//                                           .read<EditShiftCubit>()
//                                           .endTimeController
//                                           .text = selectedTime;
//                                     }
//                                   },
//                                   keyboardType: TextInputType.none,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Start date is required";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             )),
//                           ],
//                         ),
//                         verticalSpace(10),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : Text(
//                                 'Organization',
//                                 style: TextStyles.font16BlackRegular,
//                               ),
//                         verticalSpace(5),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : MultiDropdown<OrganizationData>(
//                                 items: context
//                                             .read<EditShiftCubit>()
//                                             .allOrganizationModel
//                                             ?.data
//                                             ?.data
//                                             ?.isEmpty ??
//                                         true
//                                     ? [
//                                         DropdownItem(
//                                           label: 'No organizations',
//                                           value: OrganizationData(
//                                               id: null,
//                                               name: 'No organizations'),
//                                         )
//                                       ]
//                                     : context
//                                         .read<EditShiftCubit>()
//                                         .allOrganizationModel!
//                                         .data!
//                                         .data!
//                                         .map((organization) => DropdownItem(
//                                               label: organization.name!,
//                                               value: organization,
//                                             ))
//                                         .toList(),
//                                 controller: context
//                                     .read<EditShiftCubit>()
//                                     .organizationsController,
//                                 enabled: true,
//                                 chipDecoration: ChipDecoration(
//                                   backgroundColor: Colors.grey[300],
//                                   wrap: true,
//                                   runSpacing: 5,
//                                   spacing: 5,
//                                 ),
//                                 fieldDecoration: FieldDecoration(
//                                   hintText: context
//                                       .read<EditShiftCubit>()
//                                       .shiftLevelDetailsModel!
//                                       .data!
//                                       .organizations!
//                                       .map((organization) => organization.name)
//                                       .join(', '),
//                                   suffixIcon: Icon(IconBroken.arrowDown2),
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.sp,
//                                       color: AppColor.thirdColor),
//                                   showClearIcon: false,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoration: const DropdownDecoration(
//                                   maxHeight: 200,
//                                 ),
//                                 dropdownItemDecoration: DropdownItemDecoration(
//                                   selectedIcon: const Icon(Icons.check_box,
//                                       color: Colors.blue),
//                                 ),
//                                 onSelectionChange: (selectedItems) {
//                                   organizationsIds = selectedItems
//                                       .map((item) => (item).id!)
//                                       .toList();
//                                 },
//                               ),
//                         verticalSpace(10),
//                         CustomDropDownList(
//                           hint: "Select organizations",
//                           items: context
//                                       .read<EditShiftCubit>()
//                                       .allOrganizationModel
//                                       ?.data
//                                       ?.data
//                                       ?.isEmpty ??
//                                   true
//                               ? ['No organizations']
//                               : context
//                                       .read<EditShiftCubit>()
//                                       .allOrganizationModel
//                                       ?.data
//                                       ?.data
//                                       ?.map((e) => e.name ?? 'Unknown')
//                                       .toList() ??
//                                   [],
//                           onPressed: (value) {
//                             final selectedOrganization = context
//                                 .read<EditShiftCubit>()
//                                 .allOrganizationModel
//                                 ?.data
//                                 ?.data
//                                 ?.firstWhere((organization) =>
//                                     organization.name ==
//                                     context
//                                         .read<EditShiftCubit>()
//                                         .organizationController
//                                         .text);

//                             context
//                                 .read<EditShiftCubit>()
//                                 .getBuilding(selectedOrganization!.id!);
//                             context
//                                 .read<EditShiftCubit>()
//                                 .organizationIdController
//                                 .text = selectedOrganization.id!.toString();
//                             setState(() {});
//                           },
//                           suffixIcon: IconBroken.arrowDown2,
//                           controller: context
//                               .read<EditShiftCubit>()
//                               .organizationController,
//                           isRead: false,
//                           keyboardType: TextInputType.text,
//                         ),
//                         verticalSpace(10),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : Text(
//                                 'Building',
//                                 style: TextStyles.font16BlackRegular,
//                               ),
//                         verticalSpace(5),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : MultiDropdown<BuildingData>(
//                                 items: context
//                                             .read<EditShiftCubit>()
//                                             .buildingModel
//                                             ?.data
//                                             ?.isEmpty ??
//                                         true
//                                     ? [
//                                         DropdownItem(
//                                           label: 'No building',
//                                           value: BuildingData(
//                                               id: null, name: 'No building'),
//                                         )
//                                       ]
//                                     : context
//                                         .read<EditShiftCubit>()
//                                         .buildingModel!
//                                         .data!
//                                         .map((building) => DropdownItem(
//                                               label: building.name!,
//                                               value: building,
//                                             ))
//                                         .toList(),
//                                 controller: context
//                                     .read<EditShiftCubit>()
//                                     .buildingsController,
//                                 enabled: true,
//                                 chipDecoration: ChipDecoration(
//                                   backgroundColor: Colors.grey[300],
//                                   wrap: true,
//                                   runSpacing: 5,
//                                   spacing: 5,
//                                 ),
//                                 fieldDecoration: FieldDecoration(
//                                   hintText: context
//                                       .read<EditShiftCubit>()
//                                       .shiftLevelDetailsModel!
//                                       .data!
//                                       .buildings!
//                                       .map((building) => building.name)
//                                       .join(', '),
//                                   suffixIcon: Icon(IconBroken.arrowDown2),
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.sp,
//                                       color: AppColor.thirdColor),
//                                   showClearIcon: false,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoration: const DropdownDecoration(
//                                   maxHeight: 200,
//                                 ),
//                                 dropdownItemDecoration: DropdownItemDecoration(
//                                   selectedIcon: const Icon(Icons.check_box,
//                                       color: Colors.blue),
//                                 ),
//                                 onSelectionChange: (selectedItems) {
//                                   buildingsIds = selectedItems
//                                       .map((item) => (item).id!)
//                                       .toList();
//                                 },
//                               ),

//                         // CustomDropDownList(
//                         //   hint: "Select building",
//                         //   items: context
//                         //               .read<EditShiftCubit>()
//                         //               .buildingModel
//                         //               ?.data
//                         //               ?.isEmpty ??
//                         //           true
//                         //       ? ['No building']
//                         //       : context
//                         //               .read<EditShiftCubit>()
//                         //               .buildingModel
//                         //               ?.data
//                         //               ?.map((e) => e.name ?? 'Unknown')
//                         //               .toList() ??
//                         //           [],
//                         //   onPressed: (value) {
//                         //     final selectedBuilding = context
//                         //         .read<EditShiftCubit>()
//                         //         .buildingModel
//                         //         ?.data
//                         //         ?.firstWhere((building) =>
//                         //             building.name ==
//                         //             context
//                         //                 .read<EditShiftCubit>()
//                         //                 .buildingController
//                         //                 .text);
//                         //     context
//                         //         .read<EditShiftCubit>()
//                         //         .getFloor(selectedBuilding!.id!);
//                         //     context
//                         //         .read<EditShiftCubit>()
//                         //         .buildingIdController
//                         //         .text = selectedBuilding.id!.toString();
//                         //   },
//                         //   suffixIcon: IconBroken.arrowDown2,
//                         //   controller:
//                         //       context.read<EditShiftCubit>().buildingController,
//                         //   isRead: false,
//                         //   keyboardType: TextInputType.text,
//                         // ),
//                         verticalSpace(10),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : Text(
//                                 'Floor',
//                                 style: TextStyles.font16BlackRegular,
//                               ),
//                         verticalSpace(5),

//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : MultiDropdown<FloorData>(
//                                 items: context
//                                             .read<EditShiftCubit>()
//                                             .floorModel
//                                             ?.data
//                                             ?.isEmpty ??
//                                         true
//                                     ? [
//                                         DropdownItem(
//                                           label: 'No floor',
//                                           value: FloorData(
//                                               id: null, name: 'No floor'),
//                                         )
//                                       ]
//                                     : context
//                                         .read<EditShiftCubit>()
//                                         .floorModel!
//                                         .data!
//                                         .map((floor) => DropdownItem(
//                                               label: floor.name!,
//                                               value: floor,
//                                             ))
//                                         .toList(),
//                                 controller: context
//                                     .read<EditShiftCubit>()
//                                     .floorsController,
//                                 enabled: true,
//                                 chipDecoration: ChipDecoration(
//                                   backgroundColor: Colors.grey[300],
//                                   wrap: true,
//                                   runSpacing: 5,
//                                   spacing: 5,
//                                 ),
//                                 fieldDecoration: FieldDecoration(
//                                   hintText: context
//                                       .read<EditShiftCubit>()
//                                       .shiftLevelDetailsModel!
//                                       .data!
//                                       .floors!
//                                       .map((floor) => floor.name)
//                                       .join(', '),
//                                   suffixIcon: Icon(IconBroken.arrowDown2),
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.sp,
//                                       color: AppColor.thirdColor),
//                                   showClearIcon: false,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoration: const DropdownDecoration(
//                                   maxHeight: 200,
//                                 ),
//                                 dropdownItemDecoration: DropdownItemDecoration(
//                                   selectedIcon: const Icon(Icons.check_box,
//                                       color: Colors.blue),
//                                 ),
//                                 onSelectionChange: (selectedItems) {
//                                   floorsIds = selectedItems
//                                       .map((item) => (item).id!)
//                                       .toList();
//                                 },
//                               ),

//                         // CustomDropDownList(
//                         //   hint: "Select floor",
//                         //   items: context
//                         //               .read<EditShiftCubit>()
//                         //               .floorModel
//                         //               ?.data
//                         //               ?.isEmpty ??
//                         //           true
//                         //       ? ['No floors']
//                         //       : context
//                         //               .read<EditShiftCubit>()
//                         //               .floorModel
//                         //               ?.data
//                         //               ?.map((e) => e.name ?? 'Unknown')
//                         //               .toList() ??
//                         //           [],
//                         //   onPressed: (value) {
//                         //     final selectedFloor = context
//                         //         .read<EditShiftCubit>()
//                         //         .floorModel
//                         //         ?.data
//                         //         ?.firstWhere((floor) =>
//                         //             floor.name ==
//                         //             context
//                         //                 .read<EditShiftCubit>()
//                         //                 .floorController
//                         //                 .text);

//                         //     context
//                         //         .read<EditShiftCubit>()
//                         //         .getPoints(selectedFloor!.id!);
//                         //     context
//                         //         .read<EditShiftCubit>()
//                         //         .floorIdController
//                         //         .text = selectedFloor.id!.toString();
//                         //   },
//                         //   suffixIcon: IconBroken.arrowDown2,
//                         //   controller:
//                         //       context.read<EditShiftCubit>().floorController,
//                         //   isRead: false,
//                         //   keyboardType: TextInputType.text,
//                         // ),
//                         verticalSpace(10),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : Text(
//                                 'Point',
//                                 style: TextStyles.font16BlackRegular,
//                               ),
//                         verticalSpace(5),
//                         context
//                                     .read<EditShiftCubit>()
//                                     .shiftLevelDetailsModel!
//                                     .data!
//                                     .floors ==
//                                 null
//                             ? SizedBox.shrink()
//                             : MultiDropdown<PointData>(
//                                 items: context
//                                             .read<EditShiftCubit>()
//                                             .pointModel
//                                             ?.data
//                                             ?.isEmpty ??
//                                         true
//                                     ? [
//                                         DropdownItem(
//                                           label: 'No points',
//                                           value: PointData(
//                                               id: null, name: 'No points'),
//                                         )
//                                       ]
//                                     : context
//                                         .read<EditShiftCubit>()
//                                         .pointModel!
//                                         .data!
//                                         .map((point) => DropdownItem(
//                                               label: point.name!,
//                                               value: point,
//                                             ))
//                                         .toList(),
//                                 controller: context
//                                     .read<EditShiftCubit>()
//                                     .pointsController,
//                                 enabled: true,
//                                 chipDecoration: ChipDecoration(
//                                   backgroundColor: Colors.grey[300],
//                                   wrap: true,
//                                   runSpacing: 5,
//                                   spacing: 5,
//                                 ),
//                                 fieldDecoration: FieldDecoration(
//                                   hintText: context
//                                       .read<EditShiftCubit>()
//                                       .shiftLevelDetailsModel!
//                                       .data!
//                                       .points!
//                                       .map((point) => point.name)
//                                       .join(', '),
//                                   suffixIcon: Icon(IconBroken.arrowDown2),
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.sp,
//                                       color: AppColor.thirdColor),
//                                   showClearIcon: false,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoration: const DropdownDecoration(
//                                   maxHeight: 200,
//                                 ),
//                                 dropdownItemDecoration: DropdownItemDecoration(
//                                   selectedIcon: const Icon(Icons.check_box,
//                                       color: Colors.blue),
//                                 ),
//                                 onSelectionChange: (selectedItems) {
//                                   pointsIds = selectedItems
//                                       .map((item) => (item).id!)
//                                       .toList();
//                                 },
//                               ),
//                         // CustomDropDownList(
//                         //   hint: "Select point",
//                         //   items: context
//                         //               .read<EditShiftCubit>()
//                         //               .pointModel
//                         //               ?.data
//                         //               ?.isEmpty ??
//                         //           true
//                         //       ? ['No point']
//                         //       : context
//                         //               .read<EditShiftCubit>()
//                         //               .pointModel
//                         //               ?.data
//                         //               ?.map((e) => e.name ?? 'Unknown')
//                         //               .toList() ??
//                         //           [],
//                         //   onPressed: (value) {
//                         //     final selectedPoint = context
//                         //         .read<EditShiftCubit>()
//                         //         .pointModel
//                         //         ?.data
//                         //         ?.firstWhere((point) =>
//                         //             point.name ==
//                         //             context
//                         //                 .read<EditShiftCubit>()
//                         //                 .pointController
//                         //                 .text);

//                         //     context
//                         //         .read<EditShiftCubit>()
//                         //         .getPoints(selectedPoint!.id!);
//                         //     context
//                         //         .read<EditShiftCubit>()
//                         //         .pointIdController
//                         //         .text = selectedPoint.id!.toString();
//                         //   },
//                         //   suffixIcon: IconBroken.arrowDown2,
//                         //   controller:
//                         //       context.read<EditShiftCubit>().pointController,
//                         //   isRead: false,
//                         //   keyboardType: TextInputType.text,
//                         // ),
//                         verticalSpace(20),
//                         state is EditShiftLoadingState
//                             ? const Center(
//                                 child: CircularProgressIndicator(
//                                     color: AppColor.primaryColor),
//                               )
//                             : Center(
//                                 child: DefaultElevatedButton(
//                                     name: "Edit",
//                                     onPressed: () {
//                                       showCustomDialog(context,
//                                           "Are you Sure you want save the edit of this shift ?",
//                                           () {
//                                         context
//                                             .read<EditShiftCubit>()
//                                             .editShift(
//                                                 widget.id,
//                                                 organizationsIds,
//                                                 buildingsIds,
//                                                 floorsIds,
//                                                 pointsIds);
//                                         context.pop();
//                                       });
//                                     },
//                                     color: AppColor.primaryColor,
//                                     height: 47,
//                                     width: double.infinity,
//                                     textStyles:
//                                         TextStyles.font20Whitesemimedium),
//                               ),
//                         verticalSpace(30),
//                       ])),
//             )));
//           },
//         ));
//   }
// }
