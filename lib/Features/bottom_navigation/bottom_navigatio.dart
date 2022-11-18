import 'package:flutter/material.dart';

import '../../Core/Colors/app_colors.dart';
import '../Home/View/homepage.dart';
import '../More/views/more_screen.dart';
import '../Posts/View/pages/posts_screen.dart';



class BottomNav extends StatefulWidget {
  int comingIndex = -1;

  BottomNav({required this.comingIndex});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 1;

  final tabs = [const HomePage(), const PostsPage(),MoreScreen()];

  //final keyOne = GlobalKey();
  @override
  void initState() {
    (widget.comingIndex != -1)
        ? currentIndex = widget.comingIndex
        : currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.white,
        backgroundColor: CustomColors.niceBlue,
        currentIndex: currentIndex,
        elevation: 20,
        items: const [  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: "Posts"),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert_outlined), label: "More")
        ],
      ),
    );
  }
}
