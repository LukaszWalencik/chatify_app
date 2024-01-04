// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  String barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;
  late double deviceHeight;
  late double deviceWidth;

  TopBar({
    Key? key,
    required this.barTitle,
    this.primaryAction,
    this.secondaryAction,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Container();
  }
}
