import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/pdf.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/history/user_attendance_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/leaves/user_leaves_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/shifts/user_shift_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/tasks/user_tasks_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/user_details/user_details.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/work_location/work_location_user_details.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';

class UserDetailsBody extends StatefulWidget {
  final int id;
  const UserDetailsBody({super.key, required this.id});

  @override
  State<UserDetailsBody> createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 6, vsync: this);
    controller.addListener(() {
      setState(() {});
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
        leading: CustomBackButton(),
        actions: [
          IconButton(
            onPressed: () {
              createPDF(context);
            },
            icon: Icon(
              CupertinoIcons.tray_arrow_down,
              color: Colors.red,
              size: 22.sp,
            ),
          ),
          if (role == 'Admin')
            IconButton(
                onPressed: () {
                  context.pushNamed(Routes.editUserScreen,
                      arguments: widget.id);
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColor.primaryColor,
                ))
        ],
      ),
      body: BlocConsumer<UserDetailsCubit, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDeleteSuccessState) {
            toast(text: state.deleteUserModel.message!, color: Colors.blue);
            context.pushNamedAndRemoveLastTwo(Routes.userManagmentScreen);
          }
          if (state is UserDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if ((cubit.userDetailsModel?.data == null &&
                  cubit.userStatusModel?.data == null) ||
              cubit.userShiftDetailsModel?.data == null ||
              cubit.userTaskDetailsModel?.data == null ||
              cubit.userWorkLocationDetailsModel?.data == null ||
              cubit.attendanceLeavesModel?.data == null) {
            return Loading();
          }

          return Padding(
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
                                      '${ApiConstants.apiBaseUrlImage}${cubit.userDetailsModel!.data!.image}',
                                    ),
                                    errorBuilder: (context, error, stackTrace) {
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
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              '${ApiConstants.apiBaseUrlImage}${cubit.userDetailsModel!.data!.image}',
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
                            color: cubit.userStatusModel?.data == null
                                ? Colors.red
                                : cubit.userStatusModel!.data!.clockOut == null
                                    ? Colors.green
                                    : Colors.red,
                            border: Border.all(color: Colors.white, width: 2.w),
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
                Text(
                  cubit.userDetailsModel!.data!.role!,
                  style: TextStyles.font11GreyMedium,
                ),
                verticalSpace(15),
                SizedBox(
                  height: 42.h,
                  width: double.infinity,
                  child: TabBar(
                      tabAlignment: TabAlignment.center,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: controller,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        color: controller.index == controller.index
                            ? AppColor.primaryColor
                            : Colors.transparent,
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            S.of(context).userDetails,
                            style: TextStyle(
                                color: controller.index == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.of(context).integ2,
                            style: TextStyle(
                                color: controller.index == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.of(context).integ4,
                            style: TextStyle(
                                color: controller.index == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.of(context).integ5,
                            style: TextStyle(
                                color: controller.index == 3
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.of(context).attendance,
                            style: TextStyle(
                                color: controller.index == 4
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                        Tab(
                          child: Text(
                            S.of(context).leaves,
                            style: TextStyle(
                                color: controller.index == 5
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ]),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 2,
                ),
                verticalSpace(5),
                Expanded(
                  child: TabBarView(controller: controller, children: [
                    UserDetails(),
                    WorkLocationUserDetails(),
                    UserShiftDetails(),
                    UserTasksDetails(),
                    UserAttendanceDetails(),
                    UserLeavesDetails()
                  ]),
                ),
                verticalSpace(15),
                (role == 'Admin')
                    ? DefaultElevatedButton(
                        name: S.of(context).deleteButton,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return PopUpMeassage(
                                    title: 'delete',
                                    body: 'user',
                                    onPressed: () {
                                      context
                                          .read<UserDetailsCubit>()
                                          .userDelete(widget.id);
                                    });
                              });
                        },
                        color: Colors.red,
                        height: 48,
                        width: double.infinity,
                        textStyles: TextStyles.font20Whitesemimedium)
                    : SizedBox.shrink(),
                verticalSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
