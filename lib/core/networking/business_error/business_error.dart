import 'package:smart_cleaning_application/generated/l10n.dart';

class BusinessErrorMapper {
  static String getMessage(int? code) {
    final s = S.current;

    if (code == null) {
      return s.unknown_error;
    }

    switch (code) {
      case 1000:
        return s.username_already_exists;
      case 1001:
        return s.email_already_exists;
      case 1002:
        return s.password_reset_required;
      case 1011:
        return s.name_already_exists;
      case 1012:
        return s.phone_number_already_exists;
      case 1013:
        return s.email_or_username_not_found;
      case 1014:
        return s.password_is_incorrect;
      case 1015:
        return s.id_number_already_exists;
      case 1016:
        return s.nationality_not_exists;
      case 1017:
        return s.end_date_greater_start_date;
      case 1018:
        return s.country_or_device_already_assigned;
      case 1019:
        return s.role_or_parent_task_not_exists;
      case 1020:
        return s.user_cannot_manage_themselves_or_task_not_exists;
      case 1021:
        return s.area_not_exists_or_reading_out_of_limit;
      case 1022:
        return s.city_not_exists_or_task_completed;
      case 1023:
        return s.organization_or_shift_not_exists;
      case 1024:
        return s.building_not_exists_or_cannot_delete_shift;
      case 1025:
        return s.floor_not_exists_or_user_not_exists;
      case 1026:
        return s.section_not_exists_or_tag_not_exists;
      case 1027:
        return s.point_not_exists_or_leave_not_exists;
      case 1028:
        return s.users_not_found_or_leave_overlaps;
      case 1029:
        return s.shifts_not_found_or_shift_overlaps;
      case 1030:
        return s.organizations_not_found_or_quantity_greater;
      case 1031:
        return s.buildings_not_found_or_already_assign_limit;
      case 1032:
        return s.floors_not_found_or_min_or_max_not_exists;
      case 1033:
        return s.sections_not_found_or_key_not_exists;
      case 1034:
        return s.not_assigned_to_task_or_limit_not_exists;
      case 1035:
        return s.category_not_exists_or_leave_start_future;
      case 1036:
        return s.provider_not_exists_or_question_not_exists;
      case 1037:
        return s.material_not_exists_or_choice_not_exists;
      case 1038:
        return s.currently_reading_or_feedback_device_assigned;
      case 1039:
        return s.after_reading_or_feedback_device_not_exists;
      case 1040:
        return s.category_cannot_be_own_parent;
      case 1041:
        return s.task_cannot_be_own_parent;
      case 1043:
        return s.invalid_otp;
      case 1044:
        return s.otp_expired;
      case 1045:
        return s.failed;
      default:
        return s.unknown_error;
    }
  }
}
