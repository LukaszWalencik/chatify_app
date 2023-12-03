import 'package:flutter/material.dart';

class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void removeAndNavigateToRoute(String route) {
    navigatorKey.currentState?.popAndPushNamed(route);
  }

  void navigatorToRoute(String route) {
    navigatorKey.currentState?.pushNamed(route);
  }

  void navigatorToPage(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
