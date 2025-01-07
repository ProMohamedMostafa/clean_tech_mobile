import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_cubit.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/logic/add_task_state.dart';
import 'package:smart_cleaning_application/features/screens/task/add_task/ui/widget/add_task_text_form_field.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Task",
            style: TextStyles.font16BlackSemiBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: BlocConsumer<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskSuccessState) {
              // toast(text: state.createTaskModel.message!, color: Colors.blue);
              // context.pushNamedAndRemoveLastTwo(Routes.TaskScreen);
            }
            if (state is AddTaskErrorState) {
              toast(text: state.error, color: Colors.red);
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: SingleChildScrollView(
                    child: Form(
              key: context.read<AddTaskCubit>().formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(15),
                        Text(
                          "Task Title",
                          style: TextStyles.font16BlackRegular,
                        ),
                        AddTaskTextFormField(
                          hint: "Enter Task",
                          controller:
                              context.read<AddTaskCubit>().taskNameController,
                          obscureText: false,
                          readOnly: false,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Task Name is Required";
                            }
                          },
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
                                AddTaskTextFormField(
                                  hint: "--/--/---",
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .startDateController,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime
                                          .now(), // This disables any date before today
                                      lastDate: DateTime(
                                          3025), // Set this to any future date
                                    );
                                    if (pickedDate != null) {
                                      // Format date in the form "yyyy-MM-dd"
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        context
                                            .read<AddTaskCubit>()
                                            .startDateController
                                            .text = formattedDate;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
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
                                AddTaskTextFormField(
                                  hint: "--/--/---",
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .endDateController,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.calendar_today,
                                  suffixPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime
                                          .now(), // This disables any date before today
                                      lastDate: DateTime(
                                          3025), // Set this to any future date
                                    );
                                    if (pickedDate != null) {
                                      // Format date in the form "yyyy-MM-dd"
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        context
                                            .read<AddTaskCubit>()
                                            .endDateController
                                            .text = formattedDate;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        verticalSpace(15),
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
                                AddTaskTextFormField(
                                  hint: '00:00 AM',
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .startTimeController,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          String startTime = DateFormat('HH:mm')
                                              .format(DateTime.now());

                                          return AlertDialog(
                                              backgroundColor: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              insetPadding: EdgeInsets.all(20),
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.r))),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                      height: 140.h,
                                                      width: 335.w,
                                                      child:
                                                          CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .time,
                                                              initialDateTime:
                                                                  DateTime
                                                                      .now(),
                                                              onDateTimeChanged:
                                                                  (val) {
                                                                setState(() {
                                                                  startTime = DateFormat(
                                                                          'HH:mm')
                                                                      .format(
                                                                          val);
                                                                });
                                                              })),
                                                  verticalSpace(10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                          height: 48.h,
                                                          width: 130.w,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                side: WidgetStateProperty
                                                                    .all(
                                                                        BorderSide(
                                                                  color: AppColor
                                                                      .thirdColor,
                                                                )),
                                                                backgroundColor:
                                                                    WidgetStateProperty
                                                                        .all(Colors
                                                                            .white),
                                                                overlayColor:
                                                                    WidgetStateProperty.all(
                                                                        AppColor
                                                                            .thirdColor),
                                                                shape:
                                                                    WidgetStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      12.r,
                                                                    ),
                                                                  ),
                                                                ),
                                                                elevation:
                                                                    WidgetStateProperty
                                                                        .all(1),
                                                              ),
                                                              onPressed: () {
                                                                context.pop();
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyles
                                                                    .font14BlackSemiBold,
                                                              ))),
                                                      horizontalSpace(10),
                                                      SizedBox(
                                                          height: 48.h,
                                                          width: 130.w,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateProperty.all(
                                                                        AppColor
                                                                            .primaryColor),
                                                                overlayColor:
                                                                    WidgetStateProperty.all(
                                                                        AppColor
                                                                            .thirdColor),
                                                                shape:
                                                                    WidgetStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      12.r,
                                                                    ),
                                                                  ),
                                                                ),
                                                                elevation:
                                                                    WidgetStateProperty
                                                                        .all(1),
                                                              ),
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        AddTaskCubit>()
                                                                    .startTimeController
                                                                    .text = startTime;
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "save",
                                                                style: TextStyles
                                                                    .font14WhiteMedium,
                                                              ))),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        });
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start time is required";
                                    }
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
                                AddTaskTextFormField(
                                  hint: "09:30 PM",
                                  controller: context
                                      .read<AddTaskCubit>()
                                      .endTimeController,
                                  obscureText: false,
                                  readOnly: true,
                                  suffixIcon: Icons.timer_sharp,
                                  suffixPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          String endTime = DateFormat('HH:mm')
                                              .format(DateTime.now());
                                          return AlertDialog(
                                              backgroundColor: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              insetPadding: EdgeInsets.all(20),
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.r))),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                      height: 140.h,
                                                      width: 335.w,
                                                      child:
                                                          CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .time,
                                                              initialDateTime:
                                                                  DateTime
                                                                      .now(),
                                                              onDateTimeChanged:
                                                                  (val) {
                                                                setState(() {
                                                                  endTime = DateFormat(
                                                                          'HH:mm')
                                                                      .format(
                                                                          val);
                                                                });
                                                              })),
                                                  verticalSpace(10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                          height: 48.h,
                                                          width: 130.w,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                side: WidgetStateProperty
                                                                    .all(
                                                                        BorderSide(
                                                                  color: AppColor
                                                                      .thirdColor,
                                                                )),
                                                                backgroundColor:
                                                                    WidgetStateProperty
                                                                        .all(Colors
                                                                            .white),
                                                                overlayColor:
                                                                    WidgetStateProperty.all(
                                                                        AppColor
                                                                            .thirdColor),
                                                                shape:
                                                                    WidgetStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      12.r,
                                                                    ),
                                                                  ),
                                                                ),
                                                                elevation:
                                                                    WidgetStateProperty
                                                                        .all(1),
                                                              ),
                                                              onPressed: () {
                                                                context.pop();
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyles
                                                                    .font14BlackSemiBold,
                                                              ))),
                                                      horizontalSpace(10),
                                                      SizedBox(
                                                          height: 48.h,
                                                          width: 130.w,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateProperty.all(
                                                                        AppColor
                                                                            .primaryColor),
                                                                overlayColor:
                                                                    WidgetStateProperty.all(
                                                                        AppColor
                                                                            .thirdColor),
                                                                shape:
                                                                    WidgetStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      12.r,
                                                                    ),
                                                                  ),
                                                                ),
                                                                elevation:
                                                                    WidgetStateProperty
                                                                        .all(1),
                                                              ),
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        AddTaskCubit>()
                                                                    .endTimeController
                                                                    .text = endTime;
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "save",
                                                                style: TextStyles
                                                                    .font14WhiteMedium,
                                                              ))),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        });
                                  },
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Start date is required";
                                    }
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        // verticalSpace(15),
                        // Text(
                        //   "Organization",
                        //   style: TextStyles.font16BlackRegular,
                        // ),
                        // AddTaskDropDownList(
                        //   hint: "Select organizations",
                        //   items: context
                        //               .read<AddTaskCubit>()
                        //               .organizationModel
                        //               ?.data
                        //               ?.isEmpty ??
                        //           true
                        //       ? ['No organizations']
                        //       : context
                        //               .read<AddTaskCubit>()
                        //               .organizationModel
                        //               ?.data
                        //               ?.map((e) => e.name ?? 'Unknown')
                        //               .toList() ??
                        //           [],
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty
                        //         // value == 'No organizations'
                        //         ) {
                        //       return "Organizations is required";
                        //     }
                        //   },
                        //   onChanged: (value) {
                        //     final selectedOrganization = context
                        //         .read<AddTaskCubit>()
                        //         .organizationModel
                        //         ?.data
                        //         ?.firstWhere((organization) =>
                        //             organization.name ==
                        //             context
                        //                 .read<AddTaskCubit>()
                        //                 .organizationController
                        //                 .text);

                        //     context
                        //         .read<AddTaskCubit>()
                        //         .getBuilding(selectedOrganization!.id!);
                        //   },
                        //   suffixIcon: IconBroken.arrowDown2,
                        //   controller: context
                        //       .read<AddTaskCubit>()
                        //       .organizationController,
                        //   readOnly: false,
                        //   keyboardType: TextInputType.text,
                        // ),
                        // verticalSpace(15),
                        // Text(
                        //   "Building",
                        //   style: TextStyles.font16BlackRegular,
                        // ),
                        // AddTaskDropDownList(
                        //   hint: "Select building",
                        //   items: context
                        //               .read<AddTaskCubit>()
                        //               .buildingModel
                        //               ?.data
                        //               ?.isEmpty ??
                        //           true
                        //       ? ['No building']
                        //       : context
                        //               .read<AddTaskCubit>()
                        //               .buildingModel
                        //               ?.data
                        //               ?.map((e) => e.name ?? 'Unknown')
                        //               .toList() ??
                        //           [],
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty
                        //         // value == 'No building'
                        //         ) {
                        //       return "Building is required";
                        //     }
                        //   },
                        //   onChanged: (value) {
                        //     final selectedBuilding = context
                        //         .read<AddTaskCubit>()
                        //         .buildingModel
                        //         ?.data
                        //         ?.firstWhere((building) =>
                        //             building.name ==
                        //             context
                        //                 .read<AddTaskCubit>()
                        //                 .buildingController
                        //                 .text);

                        //     context
                        //         .read<AddTaskCubit>()
                        //         .getFloor(selectedBuilding!.id!);
                        //   },
                        //   suffixIcon: IconBroken.arrowDown2,
                        //   controller:
                        //       context.read<AddTaskCubit>().buildingController,
                        //   readOnly: false,
                        //   keyboardType: TextInputType.text,
                        // ),
                        // verticalSpace(15),
                        // Text(
                        //   "Floor",
                        //   style: TextStyles.font16BlackRegular,
                        // ),
                        // AddTaskDropDownList(
                        //   hint: "Select floor",
                        //   items: context
                        //               .read<AddTaskCubit>()
                        //               .floorModel
                        //               ?.data
                        //               ?.isEmpty ??
                        //           true
                        //       ? ['No floors']
                        //       : context
                        //               .read<AddTaskCubit>()
                        //               .floorModel
                        //               ?.data
                        //               ?.map((e) => e.name ?? 'Unknown')
                        //               .toList() ??
                        //           [],
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty
                        //         // value == 'No floors'
                        //         ) {
                        //       return "Floor is required";
                        //     }
                        //   },
                        //   onChanged: (value) {
                        //     final selectedFloor = context
                        //         .read<AddTaskCubit>()
                        //         .floorModel
                        //         ?.data
                        //         ?.firstWhere((floor) =>
                        //             floor.name ==
                        //             context
                        //                 .read<AddTaskCubit>()
                        //                 .floorController
                        //                 .text);

                        //     context
                        //         .read<AddTaskCubit>()
                        //         .getPoints(selectedFloor!.id!);
                        //   },
                        //   suffixIcon: IconBroken.arrowDown2,
                        //   controller:
                        //       context.read<AddTaskCubit>().floorController,
                        //   readOnly: false,
                        //   keyboardType: TextInputType.text,
                        // ),
                        // verticalSpace(15),
                        // Text(
                        //   "Point",
                        //   style: TextStyles.font16BlackRegular,
                        // ),
                        // AddTaskDropDownList(
                        //   hint: "Select point",
                        //   items: context
                        //               .read<AddTaskCubit>()
                        //               .pointModel
                        //               ?.data
                        //               ?.isEmpty ??
                        //           true
                        //       ? ['No point']
                        //       : context
                        //               .read<AddTaskCubit>()
                        //               .pointModel
                        //               ?.data
                        //               ?.map((e) => e.name ?? 'Unknown')
                        //               .toList() ??
                        //           [],
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty
                        //         // value == 'No point'
                        //         ) {
                        //       return "Point is required";
                        //     }
                        //   },
                        //   onChanged: (value) {
                        //     final selectedPoint = context
                        //         .read<AddTaskCubit>()
                        //         .pointModel
                        //         ?.data
                        //         ?.firstWhere((point) =>
                        //             point.name ==
                        //             context
                        //                 .read<AddTaskCubit>()
                        //                 .pointController
                        //                 .text);

                        //     context
                        //         .read<AddTaskCubit>()
                        //         .getPoints(selectedPoint!.id!);
                        //   },
                        //   suffixIcon: IconBroken.arrowDown2,
                        //   controller:
                        //       context.read<AddTaskCubit>().buildingController,
                        //   readOnly: false,
                        //   keyboardType: TextInputType.text,
                        // ),
                        verticalSpace(20),
                        state is AddTaskLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor),
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: "Create",
                                    onPressed: () {
                                      // if (context
                                      //     .read<AddTaskCubit>()
                                      //     .formKey
                                      //     .currentState!
                                      //     .validate()) {
                                      //   context
                                      //       .read<AddTaskCubit>()
                                      //       .addTask();
                                      // }
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
