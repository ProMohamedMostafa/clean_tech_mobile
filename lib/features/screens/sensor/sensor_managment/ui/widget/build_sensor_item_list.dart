import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class BuildSensorItemList extends StatelessWidget {
  final int index;
  const BuildSensorItemList({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () async{
        if (cubit.selectedIndex == 0) {
          final result = await   context.pushNamed(
            Routes.sensorDetailsScreen,
            arguments: cubit.sensorModel!.data!.data![index].id,
          );

          if (result == true) {
            cubit.refreshSensors();
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.black12)),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              minTileHeight: 60.h,
              dense: true,
              leading: Stack(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/images/sensor2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cubit.selectedIndex == 0
                              ? cubit.sensorModel!.data!.data![index].active ==
                                      true
                                  ? Colors.green
                                  : Colors.red
                              : cubit.deletedSensorListModel!.data![index]
                                          .active ==
                                      true
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ))
                ],
              ),
              title: Text(
                cubit.selectedIndex == 0
                    ? cubit.sensorModel!.data!.data![index].name!
                    : cubit.deletedSensorListModel!.data![index].name!,
                style: TextStyles.font14BlackSemiBold,
              ),
              subtitle: cubit.selectedIndex == 0
                  ? RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${S.of(context).sensorTextLastRead} ',
                            style: TextStyles.font12GreyRegular,
                          ),
                          TextSpan(
                            text: cubit.getLastReadText(cubit
                                .sensorModel!.data!.data![index].lastSeenAt!),
                            style: TextStyles.font12GreyRegular
                                .copyWith(color: Colors.red),
                          ),
                          TextSpan(
                            text: ' ${S.of(context).sensorTextAgo}',
                            style: TextStyles.font12GreyRegular,
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              trailing: cubit.selectedIndex == 0
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildIconButton(
                          icon: Icons.sync,
                          color: cubit.sensorModel!.data!.data![index].active ==
                                  true
                              ? Colors.green
                              : Colors.green[100]!,
                          onPressed: () {},
                        ),
                        horizontalSpace(12),
                        _buildIconButton(
                          icon: Icons.power_settings_new,
                          color: cubit.sensorModel!.data!.data![index].active ==
                                  true
                              ? AppColor.primaryColor
                              : Colors.grey,
                          onPressed: () {},
                        ),
                      ],
                    )
                  : _buildIconButton(
                      icon: Icons.replay_outlined,
                      color: Colors.green,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return PopUpMessage(
                                  title: S.of(context).TitleRestore,
                                  body: S.of(context).sensorBody,
                                  onPressed: () {
                                    cubit.restoreDeletedSensor(cubit
                                        .deletedSensorListModel!
                                        .data![index]
                                        .id!);
                                  });
                            });
                      },
                    ),
            ),
            verticalSpace(5),
            Divider(color: Colors.grey[300], height: 0),
            verticalSpace(5),
            if (cubit.sensorModel!.data!.data![index].pointId != null) ...[
              if (cubit.selectedIndex == 0) ...[
                rowDetailsBuild(
                    S.of(context).Organization,
                    cubit.sensorModel!.data!.data![index].organizationName ??
                        ''),
                verticalSpace(5),
                rowDetailsBuild(S.of(context).Building,
                    cubit.sensorModel!.data!.data![index].buildingName ?? ''),
                verticalSpace(5),
                rowDetailsBuild(S.of(context).Floor,
                    cubit.sensorModel!.data!.data![index].floorName ?? ''),
                verticalSpace(5),
                rowDetailsBuild(S.of(context).Section,
                    cubit.sensorModel!.data!.data![index].sectionName ?? ''),
                verticalSpace(5),
              ],
              rowDetailsBuild(
                  S.of(context).Point,
                  cubit.selectedIndex == 0
                      ? cubit.sensorModel!.data!.data![index].pointName ?? ''
                      : cubit.deletedSensorListModel!.data![index].pointName ??
                          ''),
              verticalSpace(5),
            ],
            rowDetailsBuild(
                S.of(context).type,
                cubit.selectedIndex == 0
                    ? cubit.sensorModel!.data!.data![index].applicationName ??
                        ''
                    : cubit.deletedSensorListModel!.data![index]
                            .applicationName ??
                        ''),
            verticalSpace(5),
            rowDetailsBuild(
              S.of(context).type,
              cubit.selectedIndex == 0
                  ? '${cubit.sensorModel?.data?.data?[index].battery?.toString() ?? ''}%'
                  : '${cubit.deletedSensorListModel?.data?[index].battery?.toString() ?? ''}%',
              icon: (cubit.selectedIndex == 0
                          ? (cubit.sensorModel?.data?.data?[index].battery ?? 0)
                          : (cubit.deletedSensorListModel?.data?[index]
                                  .battery ??
                              0)) >=
                      50
                  ? Icons.battery_charging_full_rounded
                  : Icons.battery_2_bar_rounded,
              color: (cubit.selectedIndex == 0
                          ? (cubit.sensorModel?.data?.data?[index].battery ?? 0)
                          : (cubit.deletedSensorListModel?.data?[index]
                                  .battery ??
                              0)) >=
                      50
                  ? Colors.green
                  : Colors.deepOrange,
            ),
            if (cubit.selectedIndex == 0) ...[
              verticalSpace(5),
              Divider(color: Colors.grey[300], height: 0),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).editLocation,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () async{
                       final result = await   context.pushNamed(Routes.sensorEditScreen,
                          arguments: cubit.sensorModel!.data!.data![index].id);

          if (result == true) {
            cubit.refreshSensors();
          }
                      
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color:
                            cubit.sensorModel!.data!.data![index].pointName ==
                                    null
                                ? AppColor.primaryColor.withOpacity(0.2)
                                : Colors.black.withOpacity(0.2),
                      ),
                      child: Icon(
                        cubit.sensorModel!.data!.data![index].pointName == null
                            ? IconBroken.plus
                            : IconBroken.editSquare,
                        color:
                            cubit.sensorModel!.data!.data![index].pointName ==
                                    null
                                ? AppColor.primaryColor
                                : Colors.black,
                        size: 28.sp,
                      ),
                    ),
                  )
                ],
              ),
              verticalSpace(10),
              Container(
                height: 65.h,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        cubit.sensorModel!.data!.data![index].data!.length,
                        (i) {
                          final item =
                              cubit.sensorModel!.data!.data![index].data![i];
                          final limit =
                              cubit.sensorModel!.data!.data![index].limit;

                          // Check if limit is set for this key
                          bool isOutOfBounds = false;
                          if (limit != null &&
                              limit.key == item.key &&
                              item.value is num) {
                            final value = item.value as num;
                            if ((limit.min != null && value < limit.min!) ||
                                (limit.max != null && value > limit.max!)) {
                              isOutOfBounds = true;
                            }
                          }

                          final color =
                              isOutOfBounds ? Colors.red : Colors.black;

                          return Row(
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.key ?? '',
                                      style: TextStyle(
                                          color: isOutOfBounds
                                              ? Colors.red
                                              : Colors.grey),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      item.value.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (i !=
                                  cubit.sensorModel!.data!.data![index].data!
                                          .length -
                                      1)
                                Container(
                                  height: 30.h,
                                  width: 1.w,
                                  color: Colors.green,
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace(10),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onPressed,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  Widget rowDetailsBuild(
    String leadingTitle,
    String suffixTitle, {
    Color? color,
    IconData? icon,
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
            if (icon != null) ...[
              Icon(
                icon,
                color: color,
                size: 17.sp,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
