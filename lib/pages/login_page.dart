import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:chatify_app/widgets/custom_button.dart';
import 'package:chatify_app/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double deviceHeight;
  late double deviceWidth;

  late AuthenticationProvieder auth;
  late NavigationService navigationService;

  final loginFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

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
          horizontal: deviceWidth * 0.03,
          vertical: deviceHeight * 0.02,
        ),
        height: deviceHeight * 0.98,
        width: deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageTitle(),
            SizedBox(height: deviceHeight * 0.04),
            loginForm(),
            SizedBox(height: deviceHeight * 0.05),
            loginButton(),
            SizedBox(height: deviceHeight * 0.02),
            registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget pageTitle() {
    return SizedBox(
      height: deviceHeight * 0.10,
      child: const Text(
        'Chatify',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget loginForm() {
    return SizedBox(
      height: deviceHeight * 0.18,
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
                onSaved: () {},
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: 'Email',
                obscureText: false),
            CustomTextFormField(
                onSaved: () {},
                regEx: r".{8,}",
                hintText: 'Password',
                obscureText: true),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return CustomButton(
        name: 'Login',
        height: deviceHeight * 0.065,
        width: deviceWidth * 0.65,
        onPressed: () {});
  }

  Widget registerAccountLink() {
    return GestureDetector(
      onTap: () {},
      child: const Text(
        'Dont\'t have an account?',
        style: TextStyle(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
