import 'package:chatify_app/firebase_options.dart';
import 'package:chatify_app/pages/home_page.dart';
import 'package:chatify_app/pages/login_page.dart';
import 'package:chatify_app/pages/register_page.dart';
import 'package:chatify_app/pages/splash_page.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp()
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvieder>(
            create: (context) => AuthenticationProvieder())
      ],
      child: MaterialApp(
        title: 'Chatify',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/register': (context) => const RegisterPage(),
        },
      ),
    );
  }
}
