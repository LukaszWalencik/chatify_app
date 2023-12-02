import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({super.key, required this.onInitializationComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    setup().then((_) => widget.onInitializationComplete);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatyfy',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
      ),
      home: Scaffold(
          body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {}
}
