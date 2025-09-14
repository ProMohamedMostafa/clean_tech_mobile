import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/audit_answers/audit_answers_screen.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/history/user_attendance_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/leaves/user_leaves_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/shifts/user_shift_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/tasks/user_tasks_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/user_details/user_details.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/ui/widgets/work_location/work_location_user_details.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';

class UserDetailsBody extends StatefulWidget {
  final int roleId;
  final int id;
  const UserDetailsBody({super.key, required this.id, required this.roleId});

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody>
    with TickerProviderStateMixin {
  late int tabCount;
  late TabController controller;

  @override
  void initState() {
    final cubit = context.read<UserDetailsCubit>();

    tabCount = (widget.roleId == 1002) ? 3 : 6;

    controller = TabController(length: tabCount, vsync: this);
    controller.addListener(() {
      if (controller.indexIsChanging) return;

      final index = controller.index;

      if (widget.roleId == 1002) {
        switch (index) {
          case 1:
            if (cubit.userWorkLocationDetailsModel == null) {
              cubit.getUserWorkLocationDetails(widget.id);
            }
            break;
          case 2:
            if (cubit.auditorsModel == null) {
              cubit.getAuditorAnswers(widget.id);
            }
            break;
        }
      } else {
        switch (index) {
          case 1:
            if (cubit.userWorkLocationDetailsModel == null) {
              cubit.getUserWorkLocationDetails(widget.id);
            }
            break;
          case 2:
            if (cubit.userShiftDetailsModel == null) {
              cubit.getUserShiftDetails(widget.id);
            }
            break;
          case 3:
            if (cubit.userTaskDetailsModel == null) {
              cubit.initialize(widget.id);
            }
            break;
          case 4:
            if (cubit.attendanceHistoryModel == null) {
              cubit.getAllHistory(widget.id);
            }
            break;
          case 5:
            if (cubit.attendanceLeavesModel == null) {
              cubit.getAllLeaves(widget.id);
            }
            break;
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).userDetailsTitle),
          leading: IconButton(
              onPressed: () {
                if (controller.index == 2) {
                  cubit.getUserShiftDetails(widget.id);
                }
                context.popWithTrueResult();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25.sp,
                color: Colors.black,
              )),
          actions: [
            if (role == 'Admin')
              IconButton(
                  onPressed: () async {
                    final result = await context
                        .pushNamed(Routes.editUserScreen, arguments: widget.id);

                    if (result == true) {
                      cubit.getUserDetails(widget.id);
                    }
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColor.primaryColor,
                  )),
           
          ]),
      body: BlocConsumer<UserDetailsCubit, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDeleteSuccessState) {
            toast(text: state.deleteUserModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is UserDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is UserShiftDetailsSuccessState) {
            Loading();
          }
        },
        builder: (context, state) {
          if (cubit.userDetailsModel?.data == null) {
            return Loading();
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
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
                                        '${cubit.userDetailsModel!.data!.image}',
                                      ),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/person.png',
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
                            width: 90.r,
                            height: 90.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                '${cubit.userDetailsModel!.data!.image}',
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/person.png',
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cubit.userDetailsModel!.data!.isWorking ==
                                      true
                                  ? Colors.green
                                  : Colors.red,
                              border:
                                  Border.all(color: Colors.white, width: 2.w),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(cubit.userDetailsModel?.data?.firstName ?? '',
                          style: TextStyles.font14Redbold
                              .copyWith(color: Colors.black)),
                      horizontalSpace(5),
                      Text(cubit.userDetailsModel?.data?.lastName ?? '',
                          style: TextStyles.font14Redbold
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                  verticalSpace(5),
                  Text(cubit.userDetailsModel!.data!.role!,
                      style: TextStyles.font11GreyMedium),
                  verticalSpace(15),
                  SizedBox(
                    height: 42.h,
                    width: double.infinity,
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        final roleId = cubit.userDetailsModel?.data?.roleId;
                        final labels = (roleId == 1002)
                            ? [
                                S.of(context).userDetails,
                                S.of(context).integ2,
                                "History",
                              ]
                            : [
                                S.of(context).userDetails,
                                S.of(context).integ2,
                                S.of(context).integ4,
                                S.of(context).integ5,
                                S.of(context).attendance,
                                S.of(context).leaves,
                              ];

                        return TabBar(
                          controller: controller,
                          tabAlignment: TabAlignment.center,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: AppColor.primaryColor,
                          ),
                          tabs: List.generate(labels.length, (index) {
                            return Tab(
                              child: Text(
                                labels[index],
                                style: TextStyle(
                                  color: controller.index == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                  verticalSpace(5),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: (cubit.userDetailsModel?.data?.roleId == 1002)
                          ? [
                              UserDetails(),
                              cubit.userWorkLocationDetailsModel == null
                                  ? Loading()
                                  : WorkLocationUserDetails(),
                              cubit.auditorsModel == null
                                  ? Loading()
                                  : AuditAnswersDetails(),
                            ]
                          : [
                              UserDetails(),
                              cubit.userWorkLocationDetailsModel == null
                                  ? Loading()
                                  : WorkLocationUserDetails(),
                              cubit.userShiftDetailsModel == null
                                  ? Loading()
                                  : UserShiftDetails(),
                              cubit.userTaskDetailsModel == null
                                  ? Loading()
                                  : UserTasksDetails(),
                              cubit.attendanceHistoryModel == null
                                  ? Loading()
                                  : UserAttendanceDetails(),
                              cubit.attendanceLeavesModel == null
                                  ? Loading()
                                  : UserLeavesDetails(),
                            ],
                    ),
                  ),
                  verticalSpace(15),
                  if (role == 'Admin')
                    DefaultElevatedButton(
                        name: S.of(context).deleteButton,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return PopUpMessage(
                                    title: 'delete',
                                    body: 'user',
                                    onPressed: () {
                                      cubit.userDelete(widget.id);
                                    });
                              });
                        },
                        color: Colors.red,
                        textStyles: TextStyles.font20Whitesemimedium),
                  verticalSpace(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
