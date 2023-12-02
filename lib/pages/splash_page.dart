import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({super.key, required this.onInitializationComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatyfy',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
        // colorScheme: ColorScheme(
        //   background: Color.fromRGBO(36, 35, 49, 1.0),
        // ),
      ),
    );
  }
}
