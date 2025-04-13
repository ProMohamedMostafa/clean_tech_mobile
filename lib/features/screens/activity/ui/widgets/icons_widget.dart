import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildActionIcon(int actionId) {
  IconData iconData;
  Color iconColor;
  Color backgroundColor;

  switch (actionId) {
    case 0: // Create
      iconData = Icons.add;
      iconColor = Colors.green;
      break;
    case 1: // Edit
      iconData = Icons.edit;
      iconColor = Colors.orange;
      break;
    case 2: // Delete
      iconData = Icons.delete;
      iconColor = Colors.red;
      break;
    case 3: // Restore
      iconData = Icons.restore;
      iconColor = Colors.teal;
      break;
    case 4: // ForceDelete
      iconData = Icons.delete_forever;
      iconColor = Colors.deepOrange;
      break;
    case 5: // Login
      iconData = Icons.login;
      iconColor = Colors.blue;
      break;
    case 6: // Logout
      iconData = Icons.logout;
      iconColor = Colors.indigo;
      break;
    case 7: // ClockInOut
      iconData = Icons.access_time;
      iconColor = Colors.cyan;
      break;
    case 8: // ChangePassword
      iconData = Icons.lock;
      iconColor = Colors.brown;
      break;
    case 9: // EditProfile
      iconData = Icons.person;
      iconColor = Colors.purple;
      break;
    case 10: // Assign
      iconData = Icons.person_add;
      iconColor = Colors.lightGreen;
      break;
    case 11: // RemoveAssign
      iconData = Icons.person_remove;
      iconColor = Colors.pink;
      break;
    case 12: // StockIn
      iconData = Icons.upload;
      iconColor = Colors.blueGrey;
      break;
    case 13: // StockOut
      iconData = Icons.download;
      iconColor = Colors.deepPurple;
      break;
    case 14: // ChangeStatus
      iconData = Icons.sync_alt;
      iconColor = Colors.lime;
      break;
    case 15: // Comment
      iconData = Icons.comment;
      iconColor = Colors.amber;
      break;
    case 16: // EditSetting
      iconData = Icons.settings;
      iconColor = Colors.grey;
      break;
    default:
      iconData = Icons.help;
      iconColor = Colors.black;
      break;
  }

  backgroundColor = iconColor.withOpacity(0.2);

  return Container(
    height: 40.h,
    width: 40.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor,
    ),
    child: Center(
      child: Icon(
        iconData,
        color: iconColor,
        size: 20.sp,
      ),
    ),
  );
}
