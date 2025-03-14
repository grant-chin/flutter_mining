import 'package:flutter/material.dart';
import 'dart:ui';


class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _level = 1; // 等级
  int _exp = 0; // 经验值
  bool isClick = false; // 用于按钮按下缩放效果
  bool levelVisible = false; // 等级tips是否显示

  /// 点击挖矿增加金币
  void _incrementCounter() {
    setState(() {
      isClick = true;
      _counter += 5 * _level;
    });
  }

  late OverlayEntry _overlayEntry;
  @override
  void initState() {
    super.initState();
    // 初始化等级弹层
    _overlayEntry = OverlayEntry(builder: (context) => Positioned(
      top: 106,
      right: 16,
      child: Image.asset('assets/images/mine/level_block.png', width: 250,)
    ));
  }
  ///显示Level Tips的方法
  showLevelTips() {
    if (levelVisible) {
      _overlayEntry.remove();
    } else {
      Overlay.of(context).insert(_overlayEntry);
    }
    levelVisible = !levelVisible;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: window.physicalSize.height / window.devicePixelRatio,
      padding: const EdgeInsets.fromLTRB(0, kToolbarHeight + 12, 0, 0),
      decoration: BoxDecoration(color: Color(0xff0F0F12)),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: ClipOval(
                          child: Image.asset('assets/images/avator/lion.jpeg', fit: BoxFit.cover),
                        )
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
                              child: Text('Lvl $_level', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: showLevelTips,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/icon_xp.png', width: 20, height: 20),
                            Text('$_exp', style: TextStyle(color: Colors.white, fontSize: 14),),
                            Text('/200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14),),
                            SizedBox(width: 10,),
                            Image.asset('assets/icons/icon_info.png', width: 16, height: 16,),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(35, 36, 41, 1),
                              border: Border.all(color: Color.fromRGBO(53, 54, 60, 1), width: 1),
                              borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                          Positioned(
                            child: Container(
                              width: _exp / 200 * 190 + 8,
                              height: 8,
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(112, 21, 239, 1),
                                borderRadius: BorderRadius.circular(8)
                              ),
                            )
                          ),
                          Positioned(
                            left: _exp / 200 * 190,
                            child: Container(
                              width: 4,
                              height: 4,
                              margin: EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)
                              )
                            )
                          )
                        ],
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
            height: window.physicalSize.height / window.devicePixelRatio - 317,
            padding: EdgeInsets.only(top: 18),
            child: Stack(
              alignment: Alignment.topCenter , //指定未定位或部分定位widget的对齐方式
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/icons/icon_mine_button.png'),
                    Positioned(top: 137, child: Image.asset('assets/images/mine/stroke_1.png', width: 15.2375)),
                    Positioned(top: 138, left: MediaQuery.of(context).size.width / 2 + 20, child: Image.asset('assets/images/mine/stroke_2.png', width: 16.9625)),
                    Positioned(top: 145, left: MediaQuery.of(context).size.width / 2 + 45, child: Image.asset('assets/images/mine/stroke_3.png', width: 18.722)),
                    Positioned(top: 158, left: MediaQuery.of(context).size.width / 2 + 70, child: Image.asset('assets/images/mine/stroke_4.png', width: 19.757)),
                    Positioned(top: 174, left: MediaQuery.of(context).size.width / 2 + 90, child: Image.asset('assets/images/mine/stroke_5.png', width: 20.0445)),
                    Positioned(top: 196, left: MediaQuery.of(context).size.width / 2 + 106, child: Image.asset('assets/images/mine/stroke_6.png', width: 19.55)),
                    Positioned(top: 222, left: MediaQuery.of(context).size.width / 2 + 121, child: Image.asset('assets/images/mine/stroke_7.png', width: 18.308)),
                    Positioned(top: 248, left: MediaQuery.of(context).size.width / 2 + 130, child: Image.asset('assets/images/mine/stroke_8.png', width: 16.353)),
                    Positioned(top: 274, left: MediaQuery.of(context).size.width / 2 + 130, child: Image.asset('assets/images/mine/stroke_9.png', width: 13.9725)),
                    Positioned(top: 304, left: MediaQuery.of(context).size.width / 2 + 129, child: Image.asset('assets/images/mine/stroke_10.png', width: 16.353)),
                    Positioned(top: 331, left: MediaQuery.of(context).size.width / 2 + 123, child: Image.asset('assets/images/mine/stroke_11.png', width: 18.308)),
                    Positioned(top: 356, left: MediaQuery.of(context).size.width / 2 + 109, child: Image.asset('assets/images/mine/stroke_12.png', width: 19.55)),
                    Positioned(top: 378, left: MediaQuery.of(context).size.width / 2 + 92, child: Image.asset('assets/images/mine/stroke_13.png', width: 20.0445)),
                    Positioned(top: 394, left: MediaQuery.of(context).size.width / 2 + 70, child: Image.asset('assets/images/mine/stroke_14.png', width: 19.757)),
                    Positioned(top: 408, left: MediaQuery.of(context).size.width / 2 + 46, child: Image.asset('assets/images/mine/stroke_15.png', width: 18.722)),
                    Positioned(top: 416, left: MediaQuery.of(context).size.width / 2 + 20, child: Image.asset('assets/images/mine/stroke_16.png', width: 16.9625)),
                    Positioned(top: 420, child: Image.asset('assets/images/mine/stroke_17.png', width: 15.2375)),
                    Positioned(top: 416, right: MediaQuery.of(context).size.width / 2 + 20, child: Image.asset('assets/images/mine/stroke_18.png', width: 16.9625)),
                    Positioned(top: 408, right: MediaQuery.of(context).size.width / 2 + 46, child: Image.asset('assets/images/mine/stroke_19.png', width: 18.722)),
                    Positioned(top: 394, right: MediaQuery.of(context).size.width / 2 + 70, child: Image.asset('assets/images/mine/stroke_20.png', width: 19.757)),
                    Positioned(top: 378, right: MediaQuery.of(context).size.width / 2 + 92, child: Image.asset('assets/images/mine/stroke_21.png', width: 20.0445)),
                    Positioned(top: 356, right: MediaQuery.of(context).size.width / 2 + 109, child: Image.asset('assets/images/mine/stroke_22.png', width: 19.55)),
                    Positioned(top: 331, right: MediaQuery.of(context).size.width / 2 + 123, child: Image.asset('assets/images/mine/stroke_23.png', width: 18.308)),
                    Positioned(top: 304, right: MediaQuery.of(context).size.width / 2 + 129, child: Image.asset('assets/images/mine/stroke_24.png', width: 16.353)),
                    Positioned(top: 274, right: MediaQuery.of(context).size.width / 2 + 130, child: Image.asset('assets/images/mine/stroke_25.png', width: 13.9725)),
                    Positioned(top: 248, right: MediaQuery.of(context).size.width / 2 + 130, child: Image.asset('assets/images/mine/stroke_26.png', width: 16.353)),
                    Positioned(top: 218, right: MediaQuery.of(context).size.width / 2 + 120, child: Image.asset('assets/images/mine/stroke_27.png', width: 18.308)),
                    Positioned(top: 198, right: MediaQuery.of(context).size.width / 2 + 110, child: Image.asset('assets/images/mine/stroke_28.png', width: 19.55)),
                    Positioned(top: 178, right: MediaQuery.of(context).size.width / 2 + 92, child: Image.asset('assets/images/mine/stroke_29.png', width: 20.0445)),
                    Positioned(top: 160, right: MediaQuery.of(context).size.width / 2 + 70, child: Image.asset('assets/images/mine/stroke_30.png', width: 19.757)),
                    Positioned(top: 148, right: MediaQuery.of(context).size.width / 2 + 46, child: Image.asset('assets/images/mine/stroke_31.png', width: 18.722)),
                    Positioned(top: 138, right: MediaQuery.of(context).size.width / 2 + 20, child: Image.asset('assets/images/mine/stroke_32.png', width: 16.9625)),
                    Listener(
                      child: Image.asset('assets/icons/icon_simu.png', width: isClick ? 210 : 216, height: isClick ? 210 : 216,),
                      onPointerDown: (event) {
                        _incrementCounter();
                      },
                      onPointerUp: (event) {
                        setState(() {
                          isClick = false;
                        });
                      },
                    )
                  ],
                ),
                Text('Pool Mining', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                Positioned(
                  top: 2,
                  right: 16,
                  child: Image.asset('assets/icons/icon_info.png', width: 24,)
                ),
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
                    padding: EdgeInsets.all(16),
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
