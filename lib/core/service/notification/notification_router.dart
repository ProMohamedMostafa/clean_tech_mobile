import 'package:smart_cleaning_application/core/routing/routes.dart';

class NotificationRouter {
  static String getRouteName(String? module, int? moduleId) {
    if (moduleId == null) return '';
    switch (module) {
      case 'User':
        return Routes.userDetailsScreen;
      case 'Area':
      case 'City':
      case 'Organization':
      case 'Building':
      case 'Floor':
      case 'Section':
      case 'Point':
        return Routes.workLocationDetailsScreen;
      case 'Task':
        return Routes.taskDetailsScreen;
      case 'Shift':
        return Routes.shiftDetailsScreen;
      case 'Leave':
        return Routes.leavesDetailsScreen;
      case 'Material':
        return Routes.materialDetailsScreen;
      case 'Device':
      case 'DeviceLimit':
        return Routes.sensorDetailsScreen;
      default:
        return '';
    }
  }

  static int getWorkLocationIndex(String? module) {
    switch (module) {
      case 'Area':
        return 0;
      case 'City':
        return 1;
      case 'Organization':
        return 2;
      case 'Building':
        return 3;
      case 'Floor':
        return 4;
      case 'Section':
        return 5;
      case 'Point':
        return 6;
      default:
        return 0;
    }
  }
}
