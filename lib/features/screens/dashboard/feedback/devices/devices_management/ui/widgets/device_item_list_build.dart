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
import 'package:smart_cleaning_application/features/screens/dashboard/feedback/devices/devices_management/logic/cubit/devices_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class DevicesListItemBuild extends StatelessWidget {
  final int index;
  const DevicesListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DevicesCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        context.pushNamed(Routes.deviceAnswersScreen,
            arguments: cubit.devicesModel!.data!.data![index].id!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.black12)),
        child: Column(
          children: [
            ListTile(
                contentPadding: EdgeInsets.zero,
                minTileHeight: 50.h,
                dense: true,
                leading: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/images/sensor2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        cubit.devicesModel!.data!.data![index].name!,
                        style: TextStyles.font14BlackSemiBold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIconButton(
                      icon: IconBroken.editSquare,
                      color: AppColor.primaryColor,
                      onPressed: () async {
                        final result = await context.pushNamed(
                            Routes.editDevicesScreen,
                            arguments:
                                cubit.devicesModel!.data!.data![index].id!);

                        if (result == true) {
                          cubit.refresh();
                        }
                      },
                    ),
                    horizontalSpace(8),
                    _buildIconButton(
                      icon: IconBroken.delete,
                      color: Colors.red,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return PopUpMessage(
                                  title: S.of(context).TitleDelete,
                                  body: S.of(context).device,
                                  onPressed: () {
                                    cubit.forcedDeletedDevice(cubit
                                        .devicesModel!.data!.data![index].id!);
                                  });
                            });
                      },
                    ),
                  ],
                )),
            verticalSpace(5),
            Divider(color: Colors.grey[300], height: 0),
            verticalSpace(5),
            verticalSpace(5),
            rowDetailsBuild(S.of(context).Building,
                cubit.devicesModel!.data!.data![index].buildingName ?? '--'),
            verticalSpace(5),
            rowDetailsBuild(S.of(context).Floor,
                cubit.devicesModel!.data!.data![index].floorName ?? '--'),
            verticalSpace(5),
            rowDetailsBuild(S.of(context).Section,
                cubit.devicesModel!.data!.data![index].sectionName ?? '--'),
            verticalSpace(5),
            rowDetailsBuild(S.of(context).feedback_name,
                cubit.devicesModel!.data!.data![index].feedbackName ?? '--'),
            verticalSpace(5),
            rowDetailsBuild(
                S.of(context).question_number,
                (cubit.devicesModel!.data!.data![index].questionCount ?? 0)
                    .toString(),
                color: Colors.green),
            verticalSpace(5),
            rowDetailsBuild(
                S.of(context).device_answers,
                (cubit.devicesModel!.data!.data![index].answerCount ?? 0)
                    .toString(),
                color: Colors.green),
            verticalSpace(5),
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
      borderRadius: BorderRadius.circular(4.r),
      onTap: onPressed,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 19.sp,
          ),
        ),
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
        Expanded(
          flex: 2,
          child: Text(
            leadingTitle,
            style: TextStyles.font13Blackmedium,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            suffixTitle,
            style: TextStyles.font13Blackmedium.copyWith(
              color: color ?? AppColor.primaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
