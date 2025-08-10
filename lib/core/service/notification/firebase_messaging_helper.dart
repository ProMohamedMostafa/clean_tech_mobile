import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/service/notification/notification_router.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/src/app_cubit/app_cubit.dart';

class FirebaseMessagingHelper {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _messaging.requestPermission();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage, isLaunch: true);
    }
  }

  static void _handleForegroundMessage(RemoteMessage message) async {
    // Add this
    final isEnabled = await CacheHelper.getBool('notification') ?? true;
    if (!isEnabled) return;

    final body = message.notification?.body ?? 'New Message';
    final module = message.data['module'];
    final moduleId = int.tryParse(message.data['moduleId'] ?? '');

    _playSound();
    _showOverlayNotification(body, module, moduleId);

    final context = AppNavigator.navigatorKey.currentContext;
    if (context != null) {
      final cubit = AppCubit.get(context);
      cubit.getUnReadNotification();
    }
  }

  static void _handleBackgroundMessage(RemoteMessage message,
      {bool isLaunch = false}) async {
    final isEnabled = await CacheHelper.getBool('notification') ?? true;
    if (!isEnabled) return;

    final module = message.data['module'];
    final moduleId = int.tryParse(message.data['moduleId'] ?? '');

    if (module != null && moduleId != null) {
      Future.delayed(Duration.zero, () {
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
        } else {
          AppNavigator.navigatorKey.currentState
              ?.pushNamed(routeName, arguments: moduleId);
        }
      });
    }
  }

  static Future<void> _playSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/tone.mp3'));
  }

  static void _showOverlayNotification(
      String body, String? module, int? moduleId) async {
    final isEnabled = await CacheHelper.getBool('notification') ?? true;
    if (!isEnabled) return;

    final overlay = AppNavigator.navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    late OverlayEntry entry;

    void handleTap() async {
      if (entry.mounted) entry.remove();

      final context = AppNavigator.navigatorKey.currentContext;
      final routeName = NotificationRouter.getRouteName(module, moduleId);
      final selectedIndex = NotificationRouter.getWorkLocationIndex(module);

      if (context != null && routeName.isNotEmpty) {
        if (routeName == Routes.workLocationDetailsScreen) {
          await Navigator.of(context).pushNamed(
            routeName,
            arguments: {
              'id': moduleId,
              'selectedIndex': selectedIndex,
            },
          );
        } else {
          await Navigator.of(context).pushNamed(
            routeName,
            arguments: moduleId,
          );
        }

        // Refresh unread count after returning from the details screen
        AppCubit.get(context).getUnReadNotification();
      }
    }

    entry = OverlayEntry(
        builder: (context) => SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Material(
                    color: Colors.transparent,
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
            ));

    overlay.insert(entry);
    Future.delayed(Duration(seconds: 5), () {
      if (entry.mounted) entry.remove();
    });
  }
}
