import 'package:chatify_app/pages/login_page.dart';
import 'package:chatify_app/pages/splash_page.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MainApp()
      // SplashPage(
      //   onInitializationComplete: () {
      //     const MainApp();
      //   },
      // ),
      );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatify',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: '/login',
      routes: {'/login': (BuildContext context) => const LoginPage()},
    );
  }
}
