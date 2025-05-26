import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/service/notification/notification_router.dart';

void setupFirebaseMessagingListeners() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _handleMessage(message, isBackground: false);
  });

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleMessage(initialMessage, isAppLaunch: true);
  }
}

void _handleMessage(
  RemoteMessage message, {
  bool isBackground = true,
  bool isAppLaunch = false,
}) {
  final body = message.notification?.body ?? 'You have a new message';
  final module = message.data['module'];
  final moduleId = int.tryParse(message.data['moduleId'] ?? '');

  if (!isBackground || isAppLaunch) {
    _playNotificationSound();
    showTopNotification(body: body, module: module, moduleId: moduleId);
  }

  if (isAppLaunch || isBackground) {
    if (module != null && moduleId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final routeName = NotificationRouter.getRouteName(module, moduleId);
        final selectedIndex = NotificationRouter.getWorkLocationIndex(module);

        if (routeName == Routes.workLocationDetailsScreen) {
          AppNavigator.navigatorKey.currentState?.pushNamed(
            routeName,
            arguments: {
              'id': moduleId,
              'selectedIndex': selectedIndex,
            },
          );
        } else if (routeName.isNotEmpty) {
          AppNavigator.navigatorKey.currentState?.pushNamed(
            routeName,
            arguments: moduleId,
          );
        }
      });
    }
  }
}

Future<void> _playNotificationSound() async {
  final player = AudioPlayer();
  await player.play(AssetSource('sounds/tone.mp3'));
}

void showTopNotification({required String body, module, moduleId}) {
  final overlay = AppNavigator.navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  late OverlayEntry overlayEntry;

  void handleTap() {
    if (overlayEntry.mounted) overlayEntry.remove();

    final routeName = NotificationRouter.getRouteName(module, moduleId);
    final selectedIndex = NotificationRouter.getWorkLocationIndex(module);

    if (routeName == Routes.workLocationDetailsScreen) {
      AppNavigator.navigatorKey.currentState?.pushNamed(
        routeName,
        arguments: {
          'id': moduleId,
          'selectedIndex': selectedIndex,
        },
      );
    } else if (routeName.isNotEmpty) {
      AppNavigator.navigatorKey.currentState?.pushNamed(
        routeName,
        arguments: moduleId,
      );
    }
  }

  overlayEntry = OverlayEntry(
    builder: (context) => SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            color: Colors.transparent,
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (_) {
                if (overlayEntry.mounted) overlayEntry.remove();
              },
              child: GestureDetector(
                onTap: handleTap,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/fullLogo.png",
                            width: 24.w,
                            height: 24.h,
                            fit: BoxFit.contain,
                          ),
                          horizontalSpace(10),
                          Image.asset(
                            "assets/images/textLogo.png",
                            width: 65.w,
                            height: 15.h,
                            fit: BoxFit.contain,
                          ),
                          Spacer(),
                          Text(
                            TimeOfDay.now().format(context),
                            style: TextStyles.font11GreyMedium,
                          ),
                        ],
                      ),
                      verticalSpace(10),
                      Text(
                        body,
                        style: TextStyles.font11BlackMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 5)).then((_) {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}
