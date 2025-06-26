import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/logic/leaves_edit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves_edit/logic/leaves_edit_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_date_picker.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LeavesEditBody extends StatelessWidget {
  final int id;
  const LeavesEditBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeavesEditCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).editLeave), leading: CustomBackButton()),
      body: BlocConsumer<LeavesEditCubit, LeavesEditState>(
        listener: (context, state) {
          if (state is LeavesEditSuccessState) {
            toast(
                text: state.attendanceLeavesEditModel.message!,
                color: Colors.blue);
            context.pushNamedAndRemoveAllExceptFirst(Routes.leavesScreen);
          }
          if (state is LeavesEditErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (cubit.leavesDetailsModel == null) {
            return Loading();
          }
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
                        hint: cubit.leavesDetailsModel!.data!.userName!,
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
                      hint: cubit.leavesDetailsModel!.data!.type!,
                      items: [
                        S.of(context).sick,
                        S.of(context).annual,
                        S.of(context).ordinary
                      ],
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
                              hint: cubit.leavesDetailsModel!.data!.startDate!,
                              controller: cubit.startDateController,
                              suffixIcon: Icons.calendar_today,
                              suffixPressed: () async {
                                final selectedDate =
                                    await CustomDatePicker.show(
                                        context: context);

                                if (selectedDate != null && context.mounted) {
                                  cubit.startDateController.text = selectedDate;
                                }
                              },
                              keyboardType: TextInputType.none,
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
                              hint: cubit.leavesDetailsModel!.data!.endDate!,
                              controller: cubit.endDateController,
                              suffixIcon: Icons.calendar_today,
                              suffixPressed: () async {
                                final selectedDate =
                                    await CustomDatePicker.show(
                                        context: context);

                                if (selectedDate != null && context.mounted) {
                                  cubit.endDateController.text = selectedDate;
                                }
                              },
                              keyboardType: TextInputType.none,
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
                      controller: cubit.discriptionController
                        ..text = cubit.leavesDetailsModel!.data!.reason!,
                      hint: cubit.leavesDetailsModel!.data!.reason!,
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Text(
                          S.of(context).file,
                          style: TextStyles.font16BlackRegular,
                        ),
                        horizontalSpace(20),
                        Builder(
                          builder: (context) {
                            if (cubit.image?.path != null) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contextt) => Scaffold(
                                        appBar: AppBar(
                                          leading: CustomBackButton(),
                                        ),
                                        body: Center(
                                          child: PhotoView(
                                            imageProvider: FileImage(
                                              File(cubit.image!.path),
                                            ),
                                            backgroundDecoration:
                                                const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Image.file(
                                    File(cubit.image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else if (cubit.leavesDetailsModel!.data!.file !=
                                null) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contextt) => Scaffold(
                                          appBar: AppBar(
                                            leading: CustomBackButton(),
                                          ),
                                          body: Center(
                                            child: PhotoView(
                                              imageProvider: NetworkImage(
                                                '${ApiConstants.apiBaseUrl}${cubit.leavesDetailsModel!.data!.file}',
                                              ),
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/noImage.png',
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                              backgroundDecoration:
                                                  const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Image.network(
                                      '${ApiConstants.apiBaseUrl}${cubit.leavesDetailsModel!.data!.file}',
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/noImage.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                                  ));
                            } else {
                              return Text(S.of(context).noFile);
                            }
                          },
                        ),
                        Spacer(),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                cubit.galleryFile();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: AppColor.primaryColor,
                                  elevation: 4),
                              child: const Icon(IconBroken.upload,
                                  color: Colors.white, size: 26),
                            ),
                            verticalSpace(8),
                            Text(
                              S.of(context).uploadFile,
                              style: TextStyles.font14BlackSemiBold,
                            ),
                          ],
                        ),
                        horizontalSpace(20),
                      ],
                    ),
                    verticalSpace(20),
                    state is LeavesEditLoadingState
                        ? Loading()
                        : Center(
                            child: DefaultElevatedButton(
                                name: S.of(context).editButton,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return PopUpMessage(
                                            title: S.of(context).TitleEdit,
                                            body: S.of(context).leaveBody,
                                            onPressed: () {
                                              role == 'Admin'
                                                  ? cubit.editLeaves(
                                                      cubit.image?.path, id)
                                                  : cubit.editLeavesRequest(
                                                      cubit.image?.path, id);
                                            });
                                      });
                                },
                                color: AppColor.primaryColor,
                                height: 47,
                                width: double.infinity,
                                textStyles: TextStyles.font20Whitesemimedium),
                          ),
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
