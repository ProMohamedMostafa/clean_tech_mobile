import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/work_location/auditor/logic/cubit/auditor_cubit.dart';

class AuditLocationListItemBuild extends StatelessWidget {
  final int index;
  const AuditLocationListItemBuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuditorCubit>();
    final data = cubit.auditLocationModel?.data?.data;

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () {
        context.pushNamed(Routes.auditLocationDetailsScreen,
            arguments: data[index].id!.toInt());
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.r),
            side: BorderSide(color: AppColor.secondaryColor)),
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
          minTileHeight: 70.h,
          title: Text(
            data![index].name!,
            style: TextStyles.font14BlackSemiBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              data[index].floorName!,
              style: TextStyles.font12GreyRegular,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
