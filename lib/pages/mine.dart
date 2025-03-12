import 'package:flutter/material.dart';
import 'dart:ui';


class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _level = 1;

  /// 点击挖矿增加金币
  void _incrementCounter() {
    setState(() {
      _counter += 5 * _level;
    });
  }
  
  @override
  Widget build(BuildContext context) {
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: 96,
      //   padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(12)
      //   ),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       print('Mine!');
      //     },
      //     elevation: 5,
      //     backgroundColor: Color.fromRGBO(112, 21, 239, 1),
      //     child: Container(
      //       padding: EdgeInsets.all(0),
      //       child: Text('Mine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      //     ),
      //   ),
      // ),
    return Container(
      width: MediaQuery.of(context).size.width,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icons/icon_xp.png', width: 20, height: 20),
                          Text('0', style: TextStyle(color: Colors.white, fontSize: 14),),
                          Text('/200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14),),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Image.asset('assets/icons/icon_info.png', width: 16, height: 16,),
                          )
                        ],
                      ),
                      Container(
                        height: 12,
                        margin: EdgeInsets.only(top: 8),
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
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(112, 21, 239, 0.1),
                      border: Border.all(color: Color(0xff7015EF), width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Yesterday', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_coin.png', width: 20, height: 20),
                            Container(
                              padding: EdgeInsets.only(left: 2),
                              child: Text('--', style: TextStyle(color: Colors.white, fontSize: 17),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 54,
                    margin: EdgeInsets.only(left: 8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 81, 255, 0.1),
                      border: Border.all(color: Color(0xff5C51EF), width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Today', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_coin.png', width: 20, height: 20),
                            Container(
                              padding: EdgeInsets.only(left: 2),
                              child: Text('--', style: TextStyle(color: Colors.white, fontSize: 17),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 54,
                    margin: EdgeInsets.only(left: 16),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 0, 255, 0.1),
                      border: Border.all(color: Color(0xffFF00FF), width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Total income', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_coin.png', width: 20, height: 20),
                            Container(
                              padding: EdgeInsets.only(left: 2),
                              child: Text('--', style: TextStyle(color: Colors.white, fontSize: 17),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: window.physicalSize.height / window.devicePixelRatio - 315,
            padding: EdgeInsets.only(top: 28),
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
                    height: 64,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(22, 22, 26, 1),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Daily income', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2)),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_coin.png', width: 20, height: 20),
                            Container(
                              padding: EdgeInsets.only(left: 2),
                              child: Text('$_counter', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 96,
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                        overlayColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('Mine', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {}
                    ),
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
