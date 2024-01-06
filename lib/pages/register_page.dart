import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/cloud_storage_service.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/media_service.dart';
import 'package:chatify_app/widgets/custom_button.dart';
import 'package:chatify_app/widgets/custom_input_field.dart';
import 'package:chatify_app/widgets/rounded_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double deviceWidth;
  late double deviceHeight;
  String? name;
  String? email;
  String? password;
  late AuthenticationProvieder authenticationProvieder;
  late DatabaseService databaseService;
  late CloudStorageService cloudStorageService;

  PlatformFile? profileImage;
  final registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    authenticationProvieder = Provider.of<AuthenticationProvieder>(context);
    databaseService = GetIt.instance.get<DatabaseService>();
    cloudStorageService = GetIt.instance.get<CloudStorageService>();
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
          children: [
            profileImageField(),
            SizedBox(height: deviceHeight * 0.05),
            registerForm(),
            SizedBox(height: deviceHeight * 0.05),
            registerButton(),
            SizedBox(height: deviceHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickUpFromLibrary().then((file) {
          setState(() {
            profileImage = file;
          });
        });
      },
      child: () {
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
      }(),
    );
  }

  Widget registerForm() {
    return Container(
      height: deviceHeight * 0.35,
      child: Form(
        key: registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
                onSaved: (value) {
                  setState(() {
                    name = value;
                  });
                },
                regEx: r'.{8,};',
                hintText: 'Name',
                obscureText: false),
            CustomTextFormField(
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: 'Email',
                obscureText: false),
            CustomTextFormField(
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                regEx: r'.{8,};',
                hintText: 'Password',
                obscureText: true),
          ],
        ),
      ),
    );
  }

  Widget registerButton() {
    return CustomButton(
      name: 'Register',
      height: deviceHeight * 0.065,
      width: deviceWidth * 0.65,
      onPressed: () async {
        if (registerFormKey.currentState!.validate() && profileImage != null) {
          registerFormKey.currentState!.save();
          String? uid = await authenticationProvieder
              .registerUserEmailAndPassword(email!, password!);
          String? imageURL = await cloudStorageService.saveUserImageToStorage(
              uid!, profileImage!);
          await databaseService.createUser(uid, email!, name!, imageURL!);
          await authenticationProvieder.logout();
          await authenticationProvieder.loginWithEmailAndPassword(
              email!, password!);
        }
      },
    );
  }
}
