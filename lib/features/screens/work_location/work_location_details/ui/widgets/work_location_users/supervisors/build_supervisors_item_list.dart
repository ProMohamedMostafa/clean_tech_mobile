import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';

class BuildSupervisorsItemList extends StatelessWidget {
  final int index;
  final int selectedIndex;
  const BuildSupervisorsItemList(
      {super.key, required this.selectedIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    List<dynamic>? getSupervisorsList(WorkLocationDetailsCubit cubit) {
      switch (selectedIndex) {
        case 0:
          return cubit.areaUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        case 1:
          return cubit.cityUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        case 2:
          return cubit.organizationUsersShiftDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        case 3:
          return cubit.buildingUsersShiftDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        case 4:
          return cubit.floorUsersShiftDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        case 5:
          return cubit.sectionUsersShiftDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        case 6:
          return cubit.pointUsersDetailsModel?.data?.users
              ?.where((user) => user.role == 'Supervisor')
              .toList();
        default:
          return null;
      }
    }

    final supervisors = getSupervisorsList(cubit);
    final supervisor = supervisors![index];

    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.userDetailsScreen,
          arguments: supervisor.id,
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        minTileHeight: 60.h,
        dense: true,
        leading: Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            '${supervisor.image}',
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/person.png',
                fit: BoxFit.fill,
              );
            },
          ),
        ),
        title: Text(
          supervisor.userName,
          style: TextStyles.font14BlackSemiBold,
        ),
        subtitle: Text(
          supervisor.email,
          style: TextStyles.font12GreyRegular,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
