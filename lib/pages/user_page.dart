import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late double deviceHeight;
  late double deviceWidth;

  late AuthenticationProvieder authenticationProvieder;
  final TextEditingController searchFieldEditingcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    authenticationProvieder = Provider.of<AuthenticationProvieder>(context);
    return buildUI();
  }

  Widget buildUI() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: deviceWidth * 0.03,
        horizontal: deviceHeight * 0.02,
      ),
      height: deviceHeight * 0.98,
      width: deviceWidth * 0.97,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TopBar(barTitle: 'Users')],
      ),
    );
  }
}
