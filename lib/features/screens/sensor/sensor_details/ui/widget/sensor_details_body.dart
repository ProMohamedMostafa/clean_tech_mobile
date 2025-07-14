import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:smart_cleaning_application/features/screens/sensor/sensor_details/logic/cubit/sensor_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SensorDetailsBody extends StatelessWidget {
  final int id;
  const SensorDetailsBody({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sensorDetails),
        leading: CustomBackButton(),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await context.pushNamed(Routes.sensorEditScreen,
                    arguments: id);
                if (result == true) {
                  cubit.getSensorDetails(id);
                }
              },
              icon: Icon(Icons.edit, color: AppColor.primaryColor)),
        ],
      ),
      body: BlocConsumer<SensorDetailsCubit, SensorDetailsState>(
        listener: (context, state) {
          if (state is DeleteSensorSuccessState) {
            toast(text: state.deletedSensorModel.message!, isSuccess: true);
            context.popWithTrueResult();
          }
          if (state is DeleteSensorErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is DeleteLimitSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is DeleteLimitErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is CreateLimitSensorSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.read<SensorDetailsCubit>().getSensorDetails(id);
          }
          if (state is CreateLimitSensorErrorState) {
            toast(text: state.error, isSuccess: false);
          }

          if (state is EditLimitSensorSuccessState) {
            toast(text: state.message, isSuccess: true);
            context.read<SensorDetailsCubit>().getSensorDetails(id);
          }
          if (state is EditLimitSensorErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          if (cubit.sensorDetailsModel == null) {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cubit.sensorDetailsModel!.data!.name!,
                          style: TextStyles.font14BlackSemiBold,
                        ),
                        horizontalSpace(5),
                        Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                cubit.sensorDetailsModel!.data!.active == true
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            cubit.toggleSensor();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 375),
                            height: 25.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: cubit.isSensorEnabled
                                  ? Colors.grey[400]
                                  : AppColor.primaryColor,
                            ),
                            child: Stack(
                              children: <Widget>[
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 375),
                                  curve: Curves.easeIn,
                                  top: 0,
                                  bottom: 0,
                                  left: cubit.isSensorEnabled ? 23.0.w : 0.0.w,
                                  right: cubit.isSensorEnabled ? 0.0.w : 23.0.w,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 375),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return RotationTransition(
                                        turns: animation,
                                        child: child,
                                      );
                                    },
                                    child: cubit.isSensorEnabled
                                        ? Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.white,
                                            key: const ValueKey('off'),
                                          )
                                        : Icon(
                                            Icons.power_settings_new,
                                            color: Colors.white,
                                            key: const ValueKey('on'),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${S.of(context).sensorTextLastRead} ',
                            style: TextStyles.font12GreyRegular,
                          ),
                          TextSpan(
                            text: cubit.getLastReadText(
                                cubit.sensorDetailsModel!.data!.lastSeenAt!),
                            style: TextStyles.font12GreyRegular
                                .copyWith(color: Colors.red),
                          ),
                          TextSpan(
                            text: ' ${S.of(context).sensorTextAgo}',
                            style: TextStyles.font12GreyRegular,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(5),
                    Text(
                      cubit.sensorDetailsModel!.data!.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: cubit.descTextShowFlag ? 40 : 3,
                      style: TextStyles.font14GreyRegular,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () => cubit.toggleDescription(),
                            child: cubit.descTextShowFlag
                                ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      S.of(context).ReadLessButton,
                                      style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: 12),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      S.of(context).ReadMoreButton,
                                      style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: 12),
                                    ),
                                  ))),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(
                      S.of(context).battery,
                      '${cubit.sensorDetailsModel?.data?.battery?.toString() ?? ''}%',
                      color:
                          ((cubit.sensorDetailsModel?.data?.battery ?? 0)) >= 50
                              ? Colors.green
                              : Colors.deepOrange,
                    ),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(S.of(context).type,
                        cubit.sensorDetailsModel!.data!.applicationName ?? ''),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(S.of(context).Organization,
                        cubit.sensorDetailsModel!.data!.organizationName ?? ''),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(S.of(context).Building,
                        cubit.sensorDetailsModel!.data!.buildingName ?? ''),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(S.of(context).Floor,
                        cubit.sensorDetailsModel!.data!.floorName ?? ''),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(S.of(context).Section,
                        cubit.sensorDetailsModel!.data!.sectionName ?? ''),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    rowDetailsBuild(S.of(context).Point,
                        cubit.sensorDetailsModel!.data!.pointName ?? ''),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300], height: 0),
                    verticalSpace(10),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: List.generate(
                        cubit.sensorDetailsModel!.data!.data!.length,
                        (index) {
                          final item =
                              cubit.sensorDetailsModel!.data!.data![index];
                          return GestureDetector(
                            onTap: () => cubit.updateSelectedIndex(index),
                            child: _buildInfoBox(
                              label: item.key!,
                              value: item.value!.toString(),
                              isActive: index == cubit.selectedIndex,
                            ),
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cubit.sensorDetailsModel?.data?.limit?.key ??
                                      cubit.sensorDetailsModel!.data!
                                          .data![cubit.selectedIndex].key!,
                                  style: TextStyles.font16BlackSemiBold,
                                ),
                                Text(
                                  cubit.sensorDetailsModel?.data?.limit?.value
                                          ?.toString() ??
                                      cubit.sensorDetailsModel!.data!
                                          .data![cubit.selectedIndex].value!
                                          .toString(),
                                  style: TextStyles.font16BlackSemiBold
                                      .copyWith(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.shade300, height: 10.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    S.of(context).min,
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                horizontalSpace(5),
                                SizedBox(
                                  width: 50.w,
                                  height: 40.h,
                                  child: TextFormField(
                                    controller: cubit.minController
                                      ..text = cubit.sensorDetailsModel?.data
                                              ?.limit?.min
                                              .toString() ??
                                          '',
                                    keyboardType: TextInputType.number,
                                    style: TextStyles.font16BlackSemiBold,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 8.w),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: AppColor.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpace(30),
                                Flexible(
                                  child: Text(
                                    S.of(context).max,
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                horizontalSpace(5),
                                SizedBox(
                                  width: 50.w,
                                  height: 40.h,
                                  child: TextFormField(
                                    controller: cubit.maxController
                                      ..text = cubit.sensorDetailsModel?.data
                                              ?.limit?.max
                                              .toString() ??
                                          '',
                                    keyboardType: TextInputType.number,
                                    style: TextStyles.font16BlackSemiBold,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 8.w),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        borderSide: BorderSide(
                                            color: AppColor.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpace(30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 26.h,
                                      width: 72.w,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (cubit.sensorDetailsModel?.data
                                                  ?.limit ==
                                              null) {
                                            showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return PopUpMessage(
                                                      title: S
                                                          .of(context)
                                                          .TitleAdd,
                                                      body: S
                                                          .of(context)
                                                          .limitBody,
                                                      onPressed: () {
                                                        cubit.createLimitSensor(
                                                            id);
                                                      });
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return PopUpMessage(
                                                      title: S
                                                          .of(context)
                                                          .TitleEdit,
                                                      body: S
                                                          .of(context)
                                                          .limitBody,
                                                      onPressed: () {
                                                        cubit.editLimitSensor(
                                                            id);
                                                      });
                                                });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          textStyle:
                                              TextStyles.font14BlackRegular,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit,
                                                size: 16.sp,
                                                color: Colors.white),
                                            horizontalSpace(4),
                                            Text(cubit.sensorDetailsModel?.data
                                                        ?.limit ==
                                                    null
                                                ? S.of(context).addButton
                                                : S.of(context).editButton),
                                          ],
                                        ),
                                      ),
                                    ),
                                    verticalSpace(8),
                                    SizedBox(
                                      height: 26.h,
                                      width: 72.w,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return PopUpMessage(
                                                    title: S
                                                        .of(context)
                                                        .TitleDelete,
                                                    body:
                                                        S.of(context).limitBody,
                                                    onPressed: () {
                                                      cubit.deletelimit(id);
                                                    });
                                              });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          textStyle:
                                              TextStyles.font14BlackRegular,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete,
                                                size: 16.sp,
                                                color: Colors.white),
                                            horizontalSpace(4),
                                            Text(S.of(context).deleteButton),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          verticalSpace(10),
                        ],
                      ),
                    ),
                    verticalSpace(10),
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.getTapList(context).length,
                        itemBuilder: (context, index) {
                          bool isSelected = index == cubit.selectedTreeIndex;
                          return GestureDetector(
                            onTap: () {
                              cubit.updateSelectedTreeIndex(index);
                            },
                            child: IntrinsicWidth(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cubit.getTapList(context)[index],
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColor.primaryColor
                                            : Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        height: 2.h,
                                        color: AppColor.primaryColor,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey[200],
                      child: Center(child: Text(S.of(context).noTasks)),
                    ),
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DefaultElevatedButton(
                              name: S.of(context).reloadButton,
                              onPressed: () {
                                cubit.getSensorDetails(id);
                              },
                              color: AppColor.primaryColor,
                              textStyles: TextStyles.font16WhiteSemiBold),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: DefaultElevatedButton(
                              name: S.of(context).deleteButton,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return PopUpMessage(
                                          title: S.of(context).TitleDelete,
                                          body: S.of(context).sensorBody,
                                          onPressed: () {
                                            cubit.deleteSensor(id);
                                          });
                                    });
                              },
                              color: Colors.red,
                              textStyles: TextStyles.font16WhiteSemiBold),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                  ]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox({
    required String label,
    required String value,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isActive ? Colors.greenAccent : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget rowDetailsBuild(
    String leadingTitle,
    String suffixTitle, {
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingTitle,
          style: TextStyles.font13Blackmedium.copyWith(color: color),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              suffixTitle,
              style: TextStyles.font13Blackmedium.copyWith(
                color: color ?? AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
