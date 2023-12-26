import 'package:chatify_app/widgets/rounded_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double deviceWidth;
  late double deviceHeight;

  PlatformFile? profileImage;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          children: [profileImageField()],
        ),
      ),
    );
  }

  Widget profileImageField() {
    if (profileImage != null) {
      return RoundedImageFile(
        image: profileImage!,
        size: deviceHeight * 0.15,
      );
    } else {
      return RoundedImageNetwork(
          imagePath: 'https://images.app.goo.gl/43sJURPvCuaYTwnX8',
          size: deviceHeight * 0.15);
    }
  }
}
