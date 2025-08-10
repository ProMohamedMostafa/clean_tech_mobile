import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';

class SensorTile extends StatelessWidget {
  final String name;
  final int battery;
  final double tasks;
  final bool isOnline;

  const SensorTile({
    super.key,
    required this.name,
    required this.battery,
    required this.tasks,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: isOnline ? Colors.green : Colors.red,
                  size: 12.sp,
                ),
                horizontalSpace(5),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyles.font14BlackRegular,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              "$battery%",
              style: TextStyles.font14BlackRegular.copyWith(
                color: battery < 20 ? Colors.red : Colors.black,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              "$tasks%",
              style: TextStyles.font14BlackRegular,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
