import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionIcon extends StatelessWidget {
  final int actionId;
  const ActionIcon({super.key, required this.actionId});

  @override
  Widget build(BuildContext context) {
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
      case 7: // ClockIn
      case 8: // ClockOut
        iconData = Icons.access_time;
        iconColor = Colors.cyan;
        break;
      case 9: // ChangePassword
        iconData = Icons.lock;
        iconColor = Colors.brown;
        break;
      case 10: // EditProfile
        iconData = Icons.person;
        iconColor = Colors.purple;
        break;
      case 11: // Assign
        iconData = Icons.person_add;
        iconColor = Colors.lightGreen;
        break;
      case 12: // RemoveAssign
        iconData = Icons.person_remove;
        iconColor = Colors.pink;
        break;
      case 13: // StockIn
        iconData = Icons.upload;
        iconColor = Colors.blueGrey;
        break;
      case 14: // StockOut
        iconData = Icons.download;
        iconColor = Colors.deepPurple;
        break;
      case 15: // ChangeStatus
        iconData = Icons.sync_alt;
        iconColor = Colors.lime;
        break;
      case 16: // Comment
        iconData = Icons.comment;
        iconColor = Colors.amber;
        break;
      case 17: // EditSetting
        iconData = Icons.settings;
        iconColor = Colors.lightBlue;
        break;
      case 18: // Reminder
        iconData = Icons.notifications_active;
        iconColor = Colors.deepOrangeAccent;
        break;
      case 19: // Archive
        iconData = Icons.archive;
        iconColor = Colors.grey;
        break;
      case 20: // UnArchive
        iconData = Icons.unarchive;
        iconColor = Colors.grey;
        break;
      case 21: // ReadData
        iconData = Icons.visibility;
        iconColor = Colors.lightBlueAccent;
        break;
      case 22: // AssignShift
        iconData = Icons.calendar_today;
        iconColor = Colors.cyanAccent;
        break;
      case 23: // RemoveShift
        iconData = Icons.calendar_view_day;
        iconColor = Colors.cyanAccent;
        break;
      case 24: // AssignTag
        iconData = Icons.label;
        iconColor = Colors.purpleAccent;
        break;
      case 25: // RemoveTag
        iconData = Icons.label_off;
        iconColor = Colors.purpleAccent;
        break;
      default:
        iconData = Icons.help_outline;
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
}
