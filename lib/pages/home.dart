import 'package:flutter/material.dart';
import 'dart:ui';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  int _counter = 0;
  int _level = 1;
  int _exp = 0;

  /// 点击挖矿增加金币
  void _incrementCounter() {
    setState(() {
      _counter += 5 * _level;
    });
  }
  /// 完成任务增加经验
  void _incrementExp(int val) {
    setState(() {
      _exp += val;
    });
  }
  /// Tab 改变
  void onTabChanged(int value) {
    currentIndex = value;
    setState(() {});
  }
  /// 获取项目 icon
  Widget getItemIcon(String icon) {
    return Image.asset(
      icon,
      width: 24,
      height: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Theme(
          data: ThemeData(splashColor: Colors.transparent),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: Color.fromRGBO(15, 15, 18, 1),
            selectedItemColor: Colors.white,
            unselectedItemColor: Color.fromRGBO(249, 249, 249, 0.2),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        height: 96,
        padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
        ),
        child: FloatingActionButton(
          onPressed: () {
            print('Mine!');
          },
          elevation: 5,
          backgroundColor: Color.fromRGBO(112, 21, 239, 1),
          child: Container(
            padding: EdgeInsets.all(0),
            child: Text('Mine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
          ),
        ),
      ),
      body: Container(
        height: window.physicalSize.height / window.devicePixelRatio,
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: BoxDecoration(color: Color(0xff0F0F12)),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 48,
                    width: 48,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Image.asset('assets/images/avator/lion.jpeg', fit: BoxFit.cover),
                  ),
                  Container(
                    width: 120,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Liam xaffizme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color.fromRGBO(112, 21, 239, 0.4), Color.fromRGBO(92, 81, 255, 0.4)]
                            )
                          ),
                          child: Text('Lvl $_level', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 120 - 48 - 60,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/icon_xp.png', width: 20, height: 20),
                            Text('$_exp', style: TextStyle(color: Colors.white, fontSize: 14),),
                            Text('/120', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14),),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Image.asset('assets/icons/icon_info.png', width: 16, height: 16,),
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 120 - 48 - 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(35, 36, 41, 1),
                            border: Border.all(color: Color.fromRGBO(53, 54, 60, 1), width: 1),
                            borderRadius: BorderRadius.circular(8)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 54,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(112, 21, 239, 0.1),
                        border: Border.all(color: Color(0xff7015EF), width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 54,
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(92, 81, 255, 0.1),
                        border: Border.all(color: Color(0xff5C51EF), width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 54,
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 255, 0.1),
                        border: Border.all(color: Color(0xffFF00FF), width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      )
                    ),
                  )
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 16),
              child: Stack(
                alignment: Alignment.topCenter , //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  InkWell(
                    onTap: _incrementCounter,
                    child: Image.asset('assets/icons/icon_mine_button.png'),
                  ),
                  Text('Pool Mining', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  Positioned(
                    top: 48,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 28,
                      height: 60,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(22, 22, 26, 1),
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Column(
                        children: [
                          Text('Daily income', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2)),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/icons/icon_coin.png', width: 20, height: 20),
                              Container(
                                padding: EdgeInsets.only(top: 1, left: 2),
                                child: Text('$_counter', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
