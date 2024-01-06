// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chatify_app/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class CustomListViewTileWithActivity extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String image;
  final bool isActive;
  final bool isActivity;
  final Function onTap;
  const CustomListViewTileWithActivity({
    Key? key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isActive,
    required this.isActivity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap,
      minVerticalPadding: height * 0.20,
      leading: RoundedImageNetworkWithStatusIndicator(
          isActive: isActive, imagePath: image, size: height / 2),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
