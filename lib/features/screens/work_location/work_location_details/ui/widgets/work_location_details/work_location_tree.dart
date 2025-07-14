import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_details/work_location_tree_data.dart';

class WorkLocationTree extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationTree({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();
    final treeData =
        WorkLocationTreeData.fromCubit(cubit, selectedIndex, context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterTabs(cubit, treeData.items),
          verticalSpace(16),
          _buildLocationList(cubit, treeData),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(
      WorkLocationDetailsCubit cubit, List<Map<String, String>> items) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final isSelected = index == cubit.selectedTreeIndex;
          final item = items[index];

          return GestureDetector(
            onTap: () => cubit.changeSelectedTreeIndex(index),
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${item['count']} ${item['title']}",
                      style: TextStyle(
                        color:
                            isSelected ? AppColor.primaryColor : Colors.black,
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
    );
  }

  Widget _buildLocationList(
      WorkLocationDetailsCubit cubit, WorkLocationTreeData treeData) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: treeData.filteredList.length,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        final item = treeData.filteredList[index];
        final currentTitle = treeData.currentTitle;

        return _buildLocationCard(
          context: context,
          item: item,
          currentTitle: currentTitle,
          onTap: () => _handleItemTap(context, cubit, item, currentTitle),
        );
      },
    );
  }

  Widget _buildLocationCard({
    required BuildContext context,
    required dynamic item,
    required String currentTitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
          side: BorderSide(color: AppColor.secondaryColor),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          minTileHeight: 72.h,
          title: Text(item.name ?? '', style: TextStyles.font14BlackSemiBold),
          subtitle: currentTitle != "Device"
              ? Text(item.previousName ?? '',
                  style: TextStyles.font12GreyRegular)
              : null,
          trailing:
              Icon(Icons.arrow_forward_ios_rounded, color: AppColor.thirdColor),
        ),
      ),
    );
  }

  Future<void> _handleItemTap(
    BuildContext context,
    WorkLocationDetailsCubit cubit,
    dynamic item,
    String currentTitle,
  ) async {
    const levelIndex = {
      'City': 1,
      'Organization': 2,
      'Building': 3,
      'Floor': 4,
      'Section': 5,
      'Point': 6,
      'Device': 7,
    };

    final routeName = currentTitle == 'Device'
        ? Routes.sensorDetailsScreen
        : Routes.workLocationDetailsScreen;

    final arguments = currentTitle == 'Device'
        ? item.id
        : {'id': item.id!, 'selectedIndex': levelIndex[currentTitle]};

    final result = await context.pushNamed(routeName, arguments: arguments);

    if (result == true) {
      cubit.initialize(item.id!, levelIndex[currentTitle]!);
    }
  }
}
