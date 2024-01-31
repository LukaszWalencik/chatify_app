import 'package:chatify_app/providers/authentication_provider.dart';
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
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
