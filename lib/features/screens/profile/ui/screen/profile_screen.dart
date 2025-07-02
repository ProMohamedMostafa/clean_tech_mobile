import 'package:flutter/cupertino.dart';
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
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_state.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/history/user_attendance_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/leaves/user_leaves_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/shifts/user_shift_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/tasks/user_tasks_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/user_details.dart/user_details.dart';
import 'package:smart_cleaning_application/features/screens/profile/ui/widgets/work_location.dart/work_location_user_details.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    int tabCount = role != 'Admin' ? 6 : 0;
    controller = TabController(length: tabCount, vsync: this);
    controller.addListener(() {
      final cubit = context.read<ProfileCubit>();

      if (controller.indexIsChanging) return;

      final index = controller.index;

      switch (index) {
        case 1:
          if (cubit.userWorkLocationDetailsModel == null) {
            cubit.getUserWorkLocationDetails();
          }
          break;
        case 2:
          if (cubit.userShiftDetailsModel == null) {
            cubit.getUserShiftDetails();
          }
          break;
        case 3:
          if (cubit.userTaskDetailsModel == null) {
            cubit.getUserTaskDetails();
          }
          break;
        case 4:
          if (cubit.attendanceHistoryModel == null) {
            cubit.getAllHistory();
          }
          break;
        case 5:
          if (cubit.attendanceLeavesModel == null) {
            cubit.getAllLeaves();
          }
          break;
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
    final cubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).userDetailsTitle,
          style: TextStyles.font16BlackSemiBold,
        ),
        centerTitle: true,
        leading: CustomBackButton(),
        actions: [
          IconButton(
            onPressed: () {
              // generateAndSavePDF(context);
            },
            icon: Icon(
              CupertinoIcons.tray_arrow_down,
              color: Colors.red,
              size: 22.sp,
            ),
          ),
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.editProfileScreen, arguments: uId);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.primaryColor,
              ))
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (cubit.profileModel?.data == null) {
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
                                        '${cubit.profileModel?.data?.image}',
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
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  '${cubit.profileModel!.data!.image}',
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/person.png',
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ))),
                      if (role != 'Admin')
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cubit.profileModel!.data == null
                                    ? Colors.red
                                    : cubit.profileModel!.data!.isWorking ==
                                            true
                                        ? Colors.green
                                        : Colors.red,
                                border: Border.all(
                                    color: Colors.white, width: 2.w)),
                          ),
                        )
                    ],
                  ),
                ),
                verticalSpace(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cubit.profileModel?.data?.firstName ?? '',
                        style: TextStyles.font14Redbold
                            .copyWith(color: Colors.black)),
                    horizontalSpace(5),
                    Text(cubit.profileModel?.data?.lastName ?? '',
                        style: TextStyles.font14Redbold
                            .copyWith(color: Colors.black)),
                  ],
                ),
                verticalSpace(5),
                Text(cubit.profileModel!.data!.role!,
                    style: TextStyles.font12GreyRegular
                        .copyWith(color: AppColor.primaryColor)),
                verticalSpace(15),
                if (role != 'Admin')
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
                if (role != 'Admin')
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        UserDetails(),
                        // Tab 1: Work Location
                        cubit.userWorkLocationDetailsModel == null
                            ? Loading()
                            : WorkLocationUserDetails(),

                        // Tab 2: Shifts
                        cubit.userShiftDetailsModel == null
                            ? Loading()
                            : UserShiftDetails(),

                        // Tab 3: Tasks
                        cubit.userTaskDetailsModel == null
                            ? Loading()
                            : UserTasksDetails(),

                        // Tab 4: Attendance History
                        cubit.attendanceHistoryModel == null
                            ? Loading()
                            : UserAttendanceDetails(),

                        // Tab 5: Leaves
                        cubit.attendanceLeavesModel == null
                            ? Loading()
                            : UserLeavesDetails(),
                      ],
                    ),
                  )
                else
                  const Expanded(
                    child: UserDetails(),
                  ),
                verticalSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
