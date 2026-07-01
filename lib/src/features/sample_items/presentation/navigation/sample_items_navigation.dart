import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_item_details_screen.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_items_screen.dart';

abstract final class SampleItemsNavigation {
  static void openDetails({required String itemId, BuildContext? context}) {
    CoreNavigator.pushPath(
      SampleItemDetailsScreen.routePathFor(itemId),
      context: context,
    );
  }

  static void goList({BuildContext? context}) {
    CoreNavigator.toPath(SampleItemsScreen.routePath, context: context);
  }
}
