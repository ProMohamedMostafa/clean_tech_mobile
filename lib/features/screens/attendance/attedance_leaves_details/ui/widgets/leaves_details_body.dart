import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_cubit.dart';
import 'package:smart_cleaning_application/features/screens/attendance/attendance_leaves/logic/attendance_leaves_state.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';

class LeavesDetailsBody extends StatefulWidget {
  final int id;
  const LeavesDetailsBody({super.key, required this.id});

  @override
  State<LeavesDetailsBody> createState() => _LeavesDetailsBodyState();
}

class _LeavesDetailsBodyState extends State<LeavesDetailsBody> {
  @override
  void initState() {
    context.read<AttendanceLeavesCubit>().getLeavesDetails(widget.id);
    super.initState();
  }

  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave details"),
        leading: customBackButton(context),
        actions: [
          if (role == 'Admin')
            IconButton(
                onPressed: () {
                  context.pushNamed(Routes.editleavesScreen,
                      arguments: widget.id);
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColor.primaryColor,
                ))
        ],
      ),
      body: BlocConsumer<AttendanceLeavesCubit, AttendanceLeavesState>(
        listener: (context, state) {
          if (state is LeavesDeleteSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.pushNamedAndRemoveUntil(
              Routes.leavesScreen,
              predicate: (route) => false,
            );
          }
          if (state is LeavesDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<AttendanceLeavesCubit>().leavesDetailsModel ==
              null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Container(
                      height: 23.h,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Text(
                          context
                              .read<AttendanceLeavesCubit>()
                              .leavesDetailsModel!
                              .data!
                              .userName!,
                          style: TextStyles.font11WhiteSemiBold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context
                            .read<AttendanceLeavesCubit>()
                            .leavesDetailsModel!
                            .data!
                            .userName!,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      'Start Date',
                      context
                          .read<AttendanceLeavesCubit>()
                          .leavesDetailsModel!
                          .data!
                          .startDate!),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      'End Date',
                      context
                          .read<AttendanceLeavesCubit>()
                          .leavesDetailsModel!
                          .data!
                          .endDate!),
                  Divider(
                    height: 30,
                  ),
                  rowDetailsBuild(
                      context,
                      'Type',
                      context
                          .read<AttendanceLeavesCubit>()
                          .leavesDetailsModel!
                          .data!
                          .type!),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    'Reason',
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  verticalSpace(5),
                  Text(
                    context
                        .read<AttendanceLeavesCubit>()
                        .leavesDetailsModel!
                        .data!
                        .reason!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: descTextShowFlag ? 40 : 3,
                    style: TextStyles.font14GreyRegular,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            setState(() {
                              descTextShowFlag = !descTextShowFlag;
                            });
                          },
                          child: descTextShowFlag
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Read less",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Read more",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                ))),
                  verticalSpace(10),
                  Text(
                    "File",
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(5),
                  context
                              .read<AttendanceLeavesCubit>()
                              .leavesDetailsModel!
                              .data!
                              .file !=
                          null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (contextt) => Scaffold(
                                  appBar: AppBar(
                                    leading: customBackButton(context),
                                  ),
                                  body: Center(
                                    child: PhotoView(
                                      imageProvider: NetworkImage(
                                        '${ApiConstants.apiBaseUrl}${context.read<AttendanceLeavesCubit>().leavesDetailsModel!.data!.file}',
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
                              '${ApiConstants.apiBaseUrl}${context.read<AttendanceLeavesCubit>().leavesDetailsModel!.data!.file}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/noImage.png',
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ))
                      : Text('There\'s no file'),
                  verticalSpace(20),
                  if (role == 'Admin')
                    state is LeavesDeleteLoadingState
                        ? CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          )
                        : Center(
                            child: DefaultElevatedButton(
                                name: 'Delete',
                                onPressed: () {
                                  context
                                      .read<AttendanceLeavesCubit>()
                                      .leavesDelete(widget.id);
                                },
                                color: Colors.red,
                                height: 47,
                                width: double.infinity,
                                textStyles: TextStyles.font20Whitesemimedium),
                          ),
                  verticalSpace(20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
