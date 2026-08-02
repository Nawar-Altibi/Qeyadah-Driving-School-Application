import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/screens/notifications_inbox_screen.dart';

abstract final class NotificationsNavigation {
  static void pushInbox({BuildContext? context}) {
    CoreNavigator.pushPath(
      NotificationsInboxScreen.routePath,
      context: context,
    );
  }

  static void goInbox({BuildContext? context}) {
    CoreNavigator.toPath(NotificationsInboxScreen.routePath, context: context);
  }
}
