import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_cubit.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/logic/organizations_states.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/ui/widgets/organizations_build.dart';
import 'package:smart_cleaning_application/features/screens/organization/organizations/ui/widgets/organizations_filter_search_build.dart';

class OrganizationsBody extends StatefulWidget {
  const OrganizationsBody({super.key});

  @override
  State<OrganizationsBody> createState() => _OrganizationsBodyState();
}

class _OrganizationsBodyState extends State<OrganizationsBody> {
  List<String> tapList = [
    "Areas",
    "Cities",
    "Organizations",
    "Buildings",
    "Floors",
    "Points",
  ];
  @override
  void initState() {
    context.read<OrganizationsCubit>()
      ..getArea()
      ..getCity()
      ..getOrganization()
      ..getBuilding()
      ..getFloor()
      ..getPoint();

    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Organizations', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          height: 50.h,
          width: 50.w,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.addOrganizationScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: REdgeInsets.all(0),
              backgroundColor: AppColor.primaryColor,
              shape: CircleBorder(),
              side: BorderSide(
                color: AppColor.secondaryColor,
                width: 1,
              ),
            ),
            child: Icon(
              Icons.add_home_outlined,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
        ),
      ),
      body: BlocConsumer<OrganizationsCubit, OrganizationsState>(
        listener: (context, state) {
          if (state is AreaErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          final cubit = context.read<OrganizationsCubit>();
          if (state is AreaLoadingState ||
              state is CityLoadingState ||
              cubit.areaModel == null ||
              cubit.cityModel == null) {
            // Show loading indicator
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          }

          // Ensure data is non-null before building the UI
          final areaDetails = cubit.areaModel?.data;
          final cityDetails = cubit.cityModel?.data;

          if (areaDetails == null || cityDetails == null) {
            // Handle case where data fetching fails
            return const Center(
              child: Text("Failed to load organization details."),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    organizationsFilterAndDeleteBuild(
                        context, context.read<OrganizationsCubit>()),
                    verticalSpace(15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 45.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return horizontalSpace(10);
                          },
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: tapList.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                height: 45.h,
                                width: 118.w,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColor.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColor.secondaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      index == 0
                                          ? "${context.read<OrganizationsCubit>().areaModel?.data?.length ?? 0}"
                                          : index == 1
                                              ? "${context.read<OrganizationsCubit>().cityModel?.data?.length ?? 0}"
                                              : index == 2
                                                  ? "${context.read<OrganizationsCubit>().organizationModel?.data?.length ?? 0}"
                                                  : index == 3
                                                      ? "${context.read<OrganizationsCubit>().buildingModel?.data?.length ?? 0}"
                                                      : index == 4
                                                          ? "${context.read<OrganizationsCubit>().floorModel?.data?.length ?? 0}"
                                                          : "${context.read<OrganizationsCubit>().pointModel?.data?.length ?? 0}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColor.primaryColor,
                                      ),
                                    ),
                                    horizontalSpace(5),
                                    Text(
                                      tapList[index],
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColor.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    organizationDetailsBuild(context, selectedIndex!),
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
