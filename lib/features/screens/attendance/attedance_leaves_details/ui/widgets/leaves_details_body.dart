import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attedance_leaves_details/logic/cubit/leaves_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class LeavesDetailsBody extends StatelessWidget {
  final int id;
  const LeavesDetailsBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeavesDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).leaveDetails),
        leading: CustomBackButton(),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await context.pushNamed(Routes.editleavesScreen,
                    arguments: id);

                if (result == true) {
                  cubit.refresLeaves(id: id);
                }
              },
              icon: Icon(Icons.edit, color: AppColor.primaryColor))
        ],
      ),
      body: BlocConsumer<LeavesDetailsCubit, LeavesDetailsState>(
        listener: (context, state) {
          if (state is LeavesDeleteSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is LeavesDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is LeavesApproveSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is LeavesApproveErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.leavesDetailsModel == null) {
            return Loading();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _statusChip(
                          text: cubit.leavesDetailsModel!.data!.type!,
                          color: Color(0xffF6DCDF),
                          textColor: Colors.red),
                      horizontalSpace(5),
                      if (cubit.leavesDetailsModel!.data!.status != null) ...[
                        _statusChip(
                            text: cubit.leavesDetailsModel!.data!.status!,
                            color: Colors.grey[300]!,
                            textColor: AppColor.primaryColor),
                        horizontalSpace(5),
                      ],
                      _statusChip(
                          text: cubit.leavesDetailsModel!.data!.role!,
                          color: Colors.grey[300]!,
                          textColor: AppColor.primaryColor),
                    ],
                  ),
                  verticalSpace(5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cubit.leavesDetailsModel!.data!.userName!,
                            style: TextStyles.font14BlackSemiBold),
                        GestureDetector(
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
                                          '${cubit.leavesDetailsModel!.data!.image}',
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/person.png',
                                            fit: BoxFit.fill,
                                          );
                                        },
                                        backgroundDecoration:
                                            const BoxDecoration(
                                                color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                    child: Image.network(
                                  cubit.leavesDetailsModel!.data!.image ?? '',
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/person.png',
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ))))
                      ]),
                  Divider(height: 30),
                  rowDetailsBuild(context, S.of(context).startDate,
                      cubit.leavesDetailsModel!.data!.startDate!),
                  Divider(height: 30),
                  rowDetailsBuild(context, S.of(context).endDate,
                      cubit.leavesDetailsModel!.data!.endDate!),
                  Divider(height: 30),
                  Text(S.of(context).reason,
                      style: TextStyles.font14BlackMedium),
                  verticalSpace(5),
                  Text(cubit.leavesDetailsModel!.data!.reason!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: cubit.descTextShowFlag ? 40 : 3,
                      style: TextStyles.font14GreyRegular),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            cubit.toggleDescText();
                          },
                          child: cubit.descTextShowFlag
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    S.of(context).ReadLessButton,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    S.of(context).ReadMoreButton,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                ))),
                  verticalSpace(10),
                  Text(
                    S.of(context).file,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  cubit.leavesDetailsModel!.data!.file != null
                      ? GestureDetector(
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
                                        '${cubit.leavesDetailsModel!.data!.file}',
                                      ),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/noImage.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      backgroundDecoration: const BoxDecoration(
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
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Image.network(
                              '${cubit.leavesDetailsModel!.data!.file}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/noImage.png',
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ))
                      : Text(S.of(context).noFile),
                  verticalSpace(20),
                  if (role == 'Admin' ||
                      (role == 'Cleaner' &&
                          cubit.leavesDetailsModel!.data!.status == 'Pending'))
                    state is LeavesDeleteLoadingState
                        ? Loading()
                        : cubit.leavesDetailsModel!.data!.status == 'Pending' &&
                                role == 'Admin'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DefaultElevatedButton(
                                      name: S.of(context).approveButton,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return PopUpMessage(
                                              title: S.of(context).Titleapprove,
                                              body: S.of(context).leaveBody,
                                              onPressed: () {
                                                cubit.approveLeaveRequest(
                                                    id, true);
                                                context.pop();
                                              },
                                            );
                                          },
                                        );
                                      },
                                      color: AppColor.primaryColor,
                                 
                                      width: double.infinity,
                                      textStyles:
                                          TextStyles.font16WhiteSemiBold,
                                    ),
                                  ),
                                  horizontalSpace(10),
                                  Expanded(
                                    child: DefaultElevatedButton(
                                      name: S.of(context).rejectButton,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            final cubit = context
                                                .read<LeavesDetailsCubit>();

                                            return Dialog(
                                              insetPadding: EdgeInsets.all(20),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 8.w,
                                                            height: 24.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.r),
                                                            ),
                                                          ),
                                                          horizontalSpace(8),
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .rejectionReason,
                                                            style: TextStyles
                                                                .font18BlackMedium,
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons
                                                                    .close_rounded,
                                                                size: 26.sp),
                                                            onPressed: () =>
                                                                context.pop(),
                                                          ),
                                                        ],
                                                      ),
                                                      verticalSpace(10),
                                                      CustomDescriptionTextFormField(
                                                        controller: cubit
                                                            .rejectionReasonController,
                                                        hint: S
                                                            .of(context)
                                                            .reasonHint,
                                                      ),
                                                      verticalSpace(20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          DefaultElevatedButton(
                                                            name: S
                                                                .of(context)
                                                                .rejectButton,
                                                            onPressed: () {
                                                              cubit
                                                                  .approveLeaveRequest(
                                                                      id,
                                                                      false);
                                                            },
                                                            color: Colors.black,
                                                         
                                                            width: 125.w,
                                                            textStyles: TextStyles
                                                                .font16WhiteSemiBold,
                                                          ),
                                                          DefaultElevatedButton(
                                                            name: S
                                                                .of(context)
                                                                .cancelButton,
                                                            onPressed: () {
                                                              context.pop();
                                                            },
                                                            color: Colors
                                                                .grey[300]!,
                                                         
                                                            width: 125.w,
                                                            textStyles: TextStyles
                                                                .font16BlackSemiBold,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      color: Colors.black,
                                   
                                      width: double.infinity,
                                      textStyles:
                                          TextStyles.font16WhiteSemiBold,
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: DefaultElevatedButton(
                                    name: S.of(context).deleteButton,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return PopUpMessage(
                                                title:
                                                    S.of(context).TitleDelete,
                                                body: S.of(context).leaveBody,
                                                onPressed: () {
                                                  cubit.leavesDelete(id);
                                                });
                                          });
                                    },
                                    color: Colors.red,
                                 
                                    width: double.infinity,
                                    textStyles:
                                        TextStyles.font20Whitesemimedium)),
                  verticalSpace(20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _statusChip(
      {required String text, required Color color, required Color textColor}) {
    return Container(
      height: 23.h,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyles.font11WhiteSemiBold.copyWith(color: textColor),
        ),
      ),
    );
  }
}
