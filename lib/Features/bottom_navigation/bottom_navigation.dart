import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/Colors/app_colors.dart';
import '../Home/View/screens/home_page.dart';
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
        backgroundColor: Colors.black38,
        currentIndex: currentIndex,
        elevation: 20,
        items:  [  BottomNavigationBarItem(icon: Image.asset('assets/images/home.png',height: 30.h,), label: "Home"),
          BottomNavigationBarItem(icon: Image.asset('assets/images/posts.png',height: 30.h,), label: "Posts"),
          BottomNavigationBarItem(icon: Image.asset('assets/images/gear.png',height: 30.h,), label: "More")
        ],
      ),
    );
  }
}
