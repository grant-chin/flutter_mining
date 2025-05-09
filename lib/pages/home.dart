import 'package:flutter/material.dart';
import './item.dart';
import './mine.dart';
import './tasks.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 1;

  /// Tab 改变
  void onTabChanged(int index) {
    setState(() {
      if (currentIndex != index) {
        currentIndex = index;
      }
    });
  }
  /// 获取项目 icon
  Widget getItemIcon(String icon) {
    return Image.asset(icon, width: 24, height: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          ItemPage(),
          MinePage(toTab: onTabChanged),
          TasksPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black87, width: 0.3))),
        child: Theme(
          data: ThemeData(splashColor: Colors.transparent),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            elevation: 0,
            backgroundColor: Color.fromRGBO(15, 15, 18, 1),
            selectedItemColor: Colors.white,
            unselectedItemColor: Color.fromRGBO(249, 249, 249, 0.2),
            selectedLabelStyle: TextStyle(fontFamily: 'Lexend'),
            unselectedLabelStyle: TextStyle(fontFamily: 'Lexend'),
            items: [
              BottomNavigationBarItem(
                icon: getItemIcon('assets/images/tabbar/item_default.png'),
                activeIcon: getItemIcon('assets/images/tabbar/item_active.png'),
                label: 'Item',
              ),
              BottomNavigationBarItem(
                icon: getItemIcon('assets/images/tabbar/mine_default.png'),
                activeIcon: getItemIcon('assets/images/tabbar/mine_active.png'),
                label: 'Mine',
              ),
              BottomNavigationBarItem(
                icon: getItemIcon('assets/images/tabbar/task_default.png'),
                activeIcon: getItemIcon('assets/images/tabbar/task_active.png'),
                label: 'Tasks',
              ),
            ],
            onTap: onTabChanged,
          )
        ),
      ),
    );
  }
}
