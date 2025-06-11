import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/widgets/filter/data/model/filter_dialog_data_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/delete_user_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/data/model/deleted_list_model.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';

import '../../../integrations/data/models/users_model.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitialState());

  static UserManagementCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  int currentPage = 1;
  FilterDialogDataModel? filterModel;
  UsersModel? usersModel;
  getAllUsersInUserManage({int? roleId}) {
    emit(AllUsersLoadingState());

    DioHelper.getData(url: "users/pagination", query: {
      'PageNumber': currentPage,
      'PageSize': 15,
      'Search': searchController.text,
      'Country': filterModel?.country,
      'AreaId': filterModel?.areaId,
      'CityId': filterModel?.cityId,
      'OrganizationId': filterModel?.organizationId,
      'BuildingId': filterModel?.buildingId,
      'FloorId': filterModel?.floorId,
      'SectionId': filterModel?.sectionId,
      'PointId': filterModel?.pointId,
      'RoleId': roleId ?? filterModel?.roleId,
      'ProviderId': filterModel?.providerId,
      'Gender': filterModel?.genderId,
      'Nationality': filterModel?.nationality
    }).then((value) {
      final newUsers = UsersModel.fromJson(value!.data);

      if (currentPage == 1 || usersModel == null) {
        usersModel = newUsers;
      } else {
        usersModel?.data?.users?.addAll(newUsers.data?.users ?? []);
        usersModel?.data?.currentPage = newUsers.data?.currentPage;
        usersModel?.data?.totalPages = newUsers.data?.totalPages;
      }

      emit(AllUsersSuccessState(usersModel!));
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  void initialize(int? roleId) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          currentPage++;
          getAllUsersInUserManage(roleId: roleId);
        }
      });
    getAllUsersInUserManage(roleId: roleId);
    if (role == "Admin") {
      getAllDeletedUser();
    }
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (usersModel == null) {
        currentPage = 1;
        usersModel = null;
        getAllUsersInUserManage();
      } else {
        emit(AllUsersSuccessState(usersModel!));
      }
    } else {
      if (deletedListModel == null) {
        getAllDeletedUser();
      } else {
        emit(DeletedUsersSuccessState(deletedListModel!));
      }
    }
  }

  DeleteUserModel? deleteUserModel;
  List<UserItem> deletedUsers = [];

  userDelete(int id) {
    emit(UserDeleteLoadingState());

    DioHelper.postData(url: 'users/delete/$id', data: {'id': id}).then((value) {
      deleteUserModel = DeleteUserModel.fromJson(value!.data);

      final deletedUser = usersModel?.data?.users?.firstWhere(
        (user) => user.id == id,
      );

      if (deletedUser != null) {
        usersModel?.data?.users?.removeWhere((user) => user.id == id);
        deletedUsers.insert(0, deletedUser);

        // Decrement totalCount
        if (usersModel?.data?.totalCount != null &&
            usersModel!.data!.totalCount! > 0) {
          usersModel!.data!.totalCount = usersModel!.data!.totalCount! - 1;
        }

        if (currentPage == 1) {
          usersModel = null;
          getAllUsersInUserManage();
        } else {
          emit(AllUsersSuccessState(usersModel!));
        }
      }

      emit(UserDeleteSuccessState(deleteUserModel!));
    }).catchError((error) {
      emit(UserDeleteErrorState(error.toString()));
    });
  }

  DeletedListModel? deletedListModel;
  getAllDeletedUser() {
    emit(DeletedUsersLoadingState());
    DioHelper.getData(url: ApiConstants.deleteUserListUrl).then((value) {
      deletedListModel = DeletedListModel.fromJson(value!.data);
      emit(DeletedUsersSuccessState(deletedListModel!));
    }).catchError((error) {
      emit(DeletedUsersErrorState(error.toString()));
    });
  }

  restoreDeletedUser(int id) {
    emit(RestoreUsersLoadingState());

    DioHelper.postData(url: 'users/restore/$id', data: {'id': id})
        .then((value) {
      final responseMessage = value?.data['message'] ?? "Restored successfully";

      // Find and process the restored user
      final restoredData = deletedListModel?.data?.firstWhere(
        (data) => data.id == id,
      );

      if (restoredData != null) {
        // Remove from deleted list
        deletedListModel?.data?.removeWhere((data) => data.id == id);

        // Initialize users list if null
        usersModel?.data?.users ??= [];

        // Convert to User object
        final restoredUser = UserItem.fromJson(restoredData.toJson());

        // Find the correct position to insert (sorted by ID)
        int insertIndex = usersModel!.data!.users!
            .indexWhere((user) => user.id! > restoredUser.id!);

        // If not found, add to end
        if (insertIndex == -1) insertIndex = usersModel!.data!.users!.length;

        // Insert at correct position
        usersModel?.data?.users?.insert(insertIndex, restoredUser);

        // Update pagination metadata
        usersModel?.data?.totalCount = (usersModel?.data?.totalCount ?? 0) + 1;
        usersModel?.data?.totalPages = ((usersModel?.data?.totalCount ?? 0) /
                (usersModel?.data?.pageSize ?? 10))
            .ceil();
      }

      emit(RestoreUsersSuccessState(responseMessage));
    }).catchError((error) {
      emit(RestoreUsersErrorState(error.toString()));
    });
  }

  forcedDeletedUser(int id) {
    emit(ForceDeleteUsersLoadingState());
    DioHelper.deleteData(url: 'users/forcedelete/$id')
        .then((value) {
      final message = value?.data['message'] ?? "deleted successfully";
      emit(ForceDeleteUsersSuccessState(message));
    }).catchError((error) {
      emit(ForceDeleteUsersErrorState(error.toString()));
    });
  }
}
