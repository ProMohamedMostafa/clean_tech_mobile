import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_add/logic/leaves_add_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/attendance/attendance_leaves_add/logic/leaves_add_state.dart';
import 'package:smart_cleaning_application/core/widgets/custom_date_picker/custom_date_picker.dart';
import 'package:smart_cleaning_application/core/widgets/custom_description_text_form_field/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/custom_drop_down_list/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LeavesAddBody extends StatelessWidget {
  const LeavesAddBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeavesAddCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).createLeave), leading: CustomBackButton()),
      body: BlocConsumer<LeavesAddCubit, LeavesAddState>(
        listener: (context, state) {
          if (state is LeavesAddSuccessState) {
            toast(
                text: state.attendanceLeavesAddModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is LeavesAddErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (role == 'Admin') ...[
                      Text(
                        S.of(context).employeeName,
                        style: TextStyles.font16BlackRegular,
                      ),
                      verticalSpace(5),
                      CustomDropDownList(
                        hint: S.of(context).selectEmployee,
                        onPressed: (selectedValue) {
                          final selectedId = cubit.usersModel?.data?.users!
                              .firstWhere((employee) =>
                                  employee.userName == selectedValue)
                              .id
                              ?.toString();

                          if (selectedId != null) {
                            cubit.employeeIdController.text = selectedId;
                          }
                        },
                        items: cubit.userItem
                            .map((e) => e.userName ?? 'Unknown')
                            .toList(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == S.of(context).noEmployeeValidation) {
                            return S.of(context).employeeNameRequiredValidation;
                          }
                          return null;
                        },
                        controller: cubit.employeeController,
                        keyboardType: TextInputType.text,
                        suffixIcon: IconBroken.arrowDown2,
                      ),
                      verticalSpace(10),
                    ],
                    Text(
                      S.of(context).type,
                      style: TextStyles.font16BlackRegular,
                    ),
                    verticalSpace(5),
                    CustomDropDownList(
                      onPressed: (selectedValue) {
                        final items = [
                          S.of(context).sick,
                          S.of(context).annual,
                          S.of(context).ordinary
                        ];
                        final selectedIndex = items.indexOf(selectedValue);
                        if (selectedIndex != -1) {
                          cubit.typeIdController.text =
                              selectedIndex.toString();
                        }
                      },
                      hint: S.of(context).selectType,
                      items: [
                        S.of(context).sick,
                        S.of(context).annual,
                        S.of(context).ordinary
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).typeRequired;
                        }
                        return null;
                      },
                      controller: cubit.typeController,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconBroken.arrowDown2,
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
                              S.of(context).startDate,
                              style: TextStyles.font16BlackRegular,
                            ),
                            verticalSpace(5),
                            CustomTextFormField(
                              onlyRead: true,
                              hint: "--/--/---",
                              controller: cubit.startDateController,
                              suffixIcon: Icons.calendar_today,
                              suffixPressed: () async {
                                final selectedDate =
                                    await CustomDatePicker.show(
                                        context: context);

                                if (selectedDate != null && context.mounted) {
                                  context
                                      .read<LeavesAddCubit>()
                                      .startDateController
                                      .text = selectedDate;
                                }
                              },
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S
                                      .of(context)
                                      .startDateRequiredValidation;
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
                              S.of(context).endDate,
                              style: TextStyles.font16BlackRegular,
                            ),
                            verticalSpace(5),
                            CustomTextFormField(
                              onlyRead: true,
                              hint: "--/--/---",
                              controller: cubit.endDateController,
                              suffixIcon: Icons.calendar_today,
                              suffixPressed: () async {
                                final selectedDate =
                                    await CustomDatePicker.show(
                                        context: context);

                                if (selectedDate != null && context.mounted) {
                                  context
                                      .read<LeavesAddCubit>()
                                      .endDateController
                                      .text = selectedDate;
                                }
                              },
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S
                                      .of(context)
                                      .endDateRequiredValidation;
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
                      S.of(context).reason,
                      style: TextStyles.font16BlackRegular,
                    ),
                    verticalSpace(5),
                    CustomDescriptionTextFormField(
                      controller: cubit.discriptionController,
                      hint: S.of(context).writeReason,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).reasonRequiredValidation;
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.pickSingleFile();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: AppColor.primaryColor,
                            elevation: 4),
                        child: const Icon(IconBroken.upload,
                            color: Colors.white, size: 26),
                      ),
                    ),
                    verticalSpace(8),
                    Center(
                        child: Text(S.of(context).uploadFile,
                            style: TextStyles.font14BlackSemiBold)),
                    verticalSpace(20),
                    if (state is ImageSelectedState) ...[
                      Text(S.of(context).file,
                          style: TextStyles.font16BlackRegular),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final path = cubit.image!.path;
                              final isPDF = path.toLowerCase().endsWith('.pdf');

                              if (isPDF) {
                                await OpenFile.open(path);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (contextt) => Scaffold(
                                      appBar:
                                          AppBar(leading: CustomBackButton()),
                                      body: Center(
                                        child: PhotoView(
                                          imageProvider: FileImage(File(path)),
                                          backgroundDecoration:
                                              const BoxDecoration(
                                                  color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Builder(builder: (_) {
                              final path = cubit.image!.path;
                              final isPDF = path.toLowerCase().endsWith('.pdf');

                              return Container(
                                height: 80,
                                width: 80,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.grey.shade200,
                                ),
                                child: isPDF
                                    ? Icon(Icons.picture_as_pdf,
                                        color: Colors.red, size: 40.sp)
                                    : Image.file(File(path), fit: BoxFit.cover),
                              );
                            }),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                cubit.removeSelectedFile();
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                child: Icon(Icons.close,
                                    size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    verticalSpace(20),
                    state is LeavesAddLoadingState
                        ? Loading()
                        : Center(
                            child: DefaultElevatedButton(
                                name: S.of(context).createButton,
                                onPressed: () {
                                  if (context
                                      .read<LeavesAddCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    (role == 'Admin')
                                        ? cubit.createLeaves(cubit.image?.path)
                                        : cubit.createLeaveRequest(
                                            cubit.image?.path);
                                  }
                                },
                                color: AppColor.primaryColor,
                                textStyles: TextStyles.font20Whitesemimedium)),
                    verticalSpace(20),
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
