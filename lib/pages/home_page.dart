import 'package:chatify_app/pages/chats_page.dart';
import 'package:chatify_app/pages/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = [
    const ChatsPage(),
    const UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Chats',
            icon: Icon(Icons.bubble_chart),
          ),
          BottomNavigationBarItem(
            label: 'Users',
            icon: Icon(Icons.supervised_user_circle_sharp),
          )
        ],
      ),
    );
  }
}
