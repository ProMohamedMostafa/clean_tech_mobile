import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/features/screens/setting/notification/data/model/notification_model.dart';
import 'package:smart_cleaning_application/features/screens/setting/notification/logic/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);
  ScrollController scrollController = ScrollController();
  ScrollController unreadScrollController = ScrollController();
  int selectedIndex = 0;
  int readNotificationCurrentPage = 1;
  NotificationModel? notificationModel;
  getNotification() {
    emit(NotificationLoadingState());
    DioHelper.getData(
      url: 'notifications',
      query: {
        'PageNumber': readNotificationCurrentPage,
        'PageSize': 10,
      },
    ).then((value) {
      final readNotification = NotificationModel.fromJson(value!.data);

      if (notificationModel == null) {
        notificationModel = readNotification;
      } else {
        notificationModel?.data?.data
            ?.addAll(readNotification.data?.data ?? []);
        notificationModel?.data?.currentPage =
            readNotification.data!.currentPage;
        notificationModel?.data?.totalPages = readNotification.data!.totalPages;
      }
      emit(NotificationSuccessState(notificationModel!));
    }).catchError((error) {
      emit(NotificationErrorState(error.toString()));
    });
  }

  int unReadNotificationCurrentPage = 1;
  NotificationModel? unReadNotificationModel;
  getUnReadNotification() {
    emit(UnReadNotificationLoadingState());
    DioHelper.getData(
      url: 'notifications',
      query: {
        'PageNumber': unReadNotificationCurrentPage,
        'PageSize': 10,
        'IsRead': false,
      },
    ).then((value) {
      final unReadNotification = NotificationModel.fromJson(value!.data);

      if (unReadNotificationModel == null) {
        unReadNotificationModel = unReadNotification;
      } else {
        unReadNotificationModel?.data?.data
            ?.addAll(unReadNotification.data?.data ?? []);
        unReadNotificationModel?.data?.currentPage =
            unReadNotification.data!.currentPage;
        unReadNotificationModel?.data?.totalPages =
            unReadNotification.data!.totalPages;
      }
      emit(UnReadNotificationSuccessState(unReadNotificationModel!));
    }).catchError((error) {
      emit(UnReadNotificationErrorState(error.toString()));
    });
  }

  void myInitialize() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          readNotificationCurrentPage++;
          getNotification();
        }
      });
  }

  void unReadInitialize() {
    unreadScrollController = ScrollController()
      ..addListener(() {
        if (unreadScrollController.position.atEdge &&
            unreadScrollController.position.pixels != 0) {
          unReadNotificationCurrentPage++;
          getUnReadNotification();
        }
      });
  }

  void changeTap(int index) {
    selectedIndex = index;

    if (index == 0) {
      if (notificationModel == null) {
        readNotificationCurrentPage = 1;
        notificationModel = null;
        getNotification();
      } else {
        emit(NotificationSuccessState(notificationModel!));
      }
    } else {
      if (unReadNotificationModel == null) {
        unReadNotificationCurrentPage = 1;
        unReadNotificationModel = null;
        getUnReadNotification();
      } else {
        emit(UnReadNotificationSuccessState(unReadNotificationModel!));
      }
    }
  }

  markRead() {
    emit(MarkReadLoadingState());
    DioHelper.postData(url: 'notifications/mark/read').then((value) {
      // Update both notification models
      notificationModel = null;
      unReadNotificationModel = null;

      // Fetch fresh data for both
      readNotificationCurrentPage = 1;
      unReadNotificationCurrentPage = 1;

      getNotification();
      getUnReadNotification();

      final message =
          value?.data['message'] ?? "All notifications marked as read";
      emit(MarkReadSuccessState(message));
    }).catchError((error) {
      emit(MarkReadErrorState(error.toString()));
    });
  }

  bool allNotificationsRead() {
    final notifications = notificationModel?.data?.data;
    if (notifications == null || notifications.isEmpty) return true;
    return notifications.every((item) => item.isRead == true);
  }
}
