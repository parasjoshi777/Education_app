import 'package:educational_app/screens/course_screen.dart';
import 'package:educational_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

List<Widget> widgetsList = [
  HomePage(),
  CourseScreen(),
  Container(),
  HomePage()
];
int selectedIndex = 0;

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 30,
        selectedItemColor: Color(0xFF674AEF),
        selectedFontSize: 18,
        selectedLabelStyle: TextStyle(color: Color(0xFF674AEF)),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: selectedIndex == 0 ? Color(0xFF674AEF) : Colors.grey),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment,
                  color: selectedIndex == 1 ? Color(0xFF674AEF) : Colors.grey),
              label: 'Course'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: selectedIndex == 2 ? Color(0xFF674AEF) : Colors.grey),
              label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: selectedIndex == 3 ? Color(0xFF674AEF) : Colors.grey),
              label: 'Account'),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            // print(index);
          });
        },
      ),
      body: widgetsList[selectedIndex],
    );
  }
}
