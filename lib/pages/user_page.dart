import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/providers/chat_page_provider.dart';
import 'package:chatify_app/providers/users_page_provider.dart';
import 'package:chatify_app/widgets/custom_input_field.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';
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
  late UsersPageProvider usersPageProvider;
  final TextEditingController searchFieldEditingcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    authenticationProvieder = Provider.of<AuthenticationProvieder>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
            create: (context) => UsersPageProvider(authenticationProvieder))
      ],
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(builder: (context) {
      usersPageProvider = context.watch<UsersPageProvider>();
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
          children: [
            TopBar(
              barTitle: 'Users',
              primaryAction: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1),
                  )),
            ),
            CustomTextField(
                onEditingComplete: (value) {},
                hintText: 'Search..',
                obscureText: false,
                textEditingController: searchFieldEditingcontroller),
            usersList(),
          ],
        ),
      );
    });
  }

  Widget usersList() {
    return Expanded(child: () {
      return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return CustomListViewTile(
                height: deviceHeight * 0.10,
                title: 'User $index',
                subtitle: 'Last Active',
                image: 'https://i.pravatar.cc/300',
                isActive: true,
                isActivity: false,
                onTap: () {});
          });
    }());
  }
}
