import 'package:flutter/cupertino.dart';
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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/logic/cubit/shift_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/buildings/building_list_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/floor/floor_list_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/organization/organization_list_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/sections/section_list_build.dart';
import 'package:smart_cleaning_application/features/screens/shift/shift_details/ui/widgets/shift_details/shift_details.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ShiftDetailsBody extends StatefulWidget {
  final int id;
  const ShiftDetailsBody({super.key, required this.id});

  @override
  State<ShiftDetailsBody> createState() => _ShiftDetailsBodyState();
}

class _ShiftDetailsBodyState extends State<ShiftDetailsBody>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: 5, vsync: this);
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
    final cubit = context.read<ShiftDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shiftDetails),
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
          if (role == 'Admin')
            IconButton(
                onPressed: () {
                  context.pushNamed(Routes.editShiftScreen,
                      arguments: widget.id);
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColor.primaryColor,
                ))
        ],
      ),
      body: BlocConsumer<ShiftDetailsCubit, ShiftDetailsState>(
        listener: (context, state) {
          if (state is ShiftDeleteSuccessState) {
            toast(text: state.deleteShiftModel.message!, color: Colors.blue);
            Navigator.of(context).pop(true);
          }
          if (state is ShiftDeleteErrorState) {
            toast(text: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (context.read<ShiftDetailsCubit>().shiftDetailsModel == null) {
            return Loading();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: double.infinity,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final shiftLabels = [
                        S.of(context).shiftDetails,
                        S.of(context).Organization,
                        S.of(context).Building,
                        S.of(context).Floor,
                        S.of(context).Section,
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
                        tabs: List.generate(shiftLabels.length, (index) {
                          return Tab(
                            child: Text(
                              shiftLabels[index],
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
                verticalSpace(20),
                Expanded(
                  child: TabBarView(controller: controller, children: [
                    cubit.shiftDetailsModel == null
                        ? Loading()
                        : ShiftDetails(),
                    cubit.shiftDetailsModel == null
                        ? Loading()
                        : OrganizationListBuild(),
                    cubit.shiftDetailsModel == null
                        ? Loading()
                        : BuildingListBuild(),
                    cubit.shiftDetailsModel == null
                        ? Loading()
                        : FloorListBuild(),
                    cubit.shiftDetailsModel == null
                        ? Loading()
                        : SectionListBuild(),
                  ]),
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
                                  title: S.of(context).TitleDelete,
                                  body: S.of(context).shiftBody,
                                  onPressed: () {
                                    context
                                        .read<ShiftDetailsCubit>()
                                        .shiftDelete(widget.id);
                                  });
                            });
                      },
                      color: Colors.red,
                      height: 48,
                      width: double.infinity,
                      textStyles: TextStyles.font20Whitesemimedium),
                verticalSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
