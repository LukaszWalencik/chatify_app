import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return buildUi();
  }

  Widget buildUi() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.02,
          vertical: deviceHeight * 0.02,
        ),
      ),
    );
  }
}
