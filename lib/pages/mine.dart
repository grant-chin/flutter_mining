import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mining/common/Global.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:animate_do/animate_do.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {
  int get goldYesterday => Global.goldYesterday;
  int get goldToday => Global.goldToday;
  int get goldTotal => Global.goldTotal;
  int get goldDaily => Global.goldDaily;
  int get _level => Global.level; // 等级
  int get _exp => Global.exp; // 经验值
  bool isClick = false; // 用于按钮按下缩放效果
  int strokeIndex = -1; // 当前显示圆环进度条下标
  bool _mining = false; // 是否正在mining状态

  // 显示Level Tips的方法
  _showLevelTips() {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (_) => Stack(
        children: [
          Positioned(
            top: kToolbarHeight + 28,
            right: 12,
            child: Image.asset('assets/images/mine/level_block.png', width: 226)
          )
        ],
      )
    );
  }
  // 显示rule弹窗
  _showRuleDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 560,
            padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24)
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(112, 21, 239, 0.3), Color.fromRGBO(92, 81, 255, 0)]
                ),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/mine/rule_text.png'),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 58,
                    padding:EdgeInsets.symmetric(horizontal: 16) ,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.white,
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Got it', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
      decoration: BoxDecoration(color: Color(0xff0F0F12)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            // height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      SizedBox(width: 16),
                      SizedBox(
                        width: 120,
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
                SizedBox(
                  width: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icons/icon_xp.png', width: 20, height: 20),
                          Text('$_exp', style: TextStyle(color: Colors.white, fontSize: 14),),
                          Text('/200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14),),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: _showLevelTips,
                            child: Image.asset('assets/icons/icon_info.png', width: 16, height: 16,),
                          )
                        ],
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
          SizedBox(height: 16),
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
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
                              child: Text('$goldYesterday', style: TextStyle(color: Colors.white, fontSize: 17),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 54,
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
                              child: Text('$goldToday', style: TextStyle(color: Colors.white, fontSize: 17),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 54,
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
                              child: Text('$goldTotal', style: TextStyle(color: Colors.white, fontSize: 17),),
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
          SizedBox(height: 16),
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 16),
            child: Stack(
              alignment: Alignment.center , //指定未定位或部分定位widget的对齐方式
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/mine/mine_bg.png'),
                    Image.asset('assets/images/mine/mine_ring_bg.png', scale: 2.76),
                    Positioned(top: 136, child: Opacity(opacity: strokeIndex > 0 ? 1 : 0, child: Image.asset('assets/images/mine/stroke_1.png', scale: 2.8),)),
                    Positioned(top: 137, left: MediaQuery.of(context).size.width / 2 + 20, child: Opacity(
                      opacity: strokeIndex > 1 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_2.png', scale: 2.8))
                    ),
                    Positioned(top: 144, left: MediaQuery.of(context).size.width / 2 + 46, child: Opacity(
                      opacity: strokeIndex > 2 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_3.png', scale: 2.8))
                    ),
                    Positioned(top: 157, left: MediaQuery.of(context).size.width / 2 + 70, child: Opacity(
                      opacity: strokeIndex > 3 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_4.png', scale: 2.8))
                    ),
                    Positioned(top: 174, left: MediaQuery.of(context).size.width / 2 + 92, child: Opacity(
                      opacity: strokeIndex > 4 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_5.png', scale: 2.8))
                    ),
                    Positioned(top: 196, left: MediaQuery.of(context).size.width / 2 + 109, child: Opacity(
                      opacity: strokeIndex > 5 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_6.png', scale: 2.8))
                    ),
                    Positioned(top: 222, left: MediaQuery.of(context).size.width / 2 + 124, child: Opacity(
                      opacity: strokeIndex > 6 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_7.png', scale: 2.8))
                    ),
                    Positioned(top: 250, left: MediaQuery.of(context).size.width / 2 + 133, child: Opacity(
                      opacity: strokeIndex > 7 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_8.png', scale: 2.8))
                    ),
                    Positioned(top: 278, left: MediaQuery.of(context).size.width / 2 + 136, child: Opacity(
                      opacity: strokeIndex > 8 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_9.png', scale: 2.8))
                    ),
                    Positioned(top: 306, left: MediaQuery.of(context).size.width / 2 + 132, child: Opacity(
                      opacity: strokeIndex > 9 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_10.png', scale: 2.8))
                    ),
                    Positioned(top: 332, left: MediaQuery.of(context).size.width / 2 + 124, child: Opacity(
                      opacity: strokeIndex > 10 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_11.png', scale: 2.8))
                    ),
                    Positioned(top: 356, left: MediaQuery.of(context).size.width / 2 + 110, child: Opacity(
                      opacity: strokeIndex > 11 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_12.png', scale: 2.8))
                    ),
                    Positioned(top: 377, left: MediaQuery.of(context).size.width / 2 + 91, child: Opacity(
                      opacity: strokeIndex > 12 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_13.png', scale: 2.8))
                    ),
                    Positioned(top: 395, left: MediaQuery.of(context).size.width / 2 + 70, child: Opacity(
                      opacity: strokeIndex > 13 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_14.png', scale: 2.8))
                    ),
                    Positioned(top: 410, left: MediaQuery.of(context).size.width / 2 + 46, child: Opacity(
                      opacity: strokeIndex > 14 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_15.png', scale: 2.8))
                    ),
                    Positioned(top: 418, left: MediaQuery.of(context).size.width / 2 + 20, child: Opacity(
                      opacity: strokeIndex > 15 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_16.png', scale: 2.8))
                    ),
                    Positioned(top: 422, child: Opacity(
                      opacity: strokeIndex > 16 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_17.png', scale: 2.8))
                    ),
                    Positioned(top: 418, right: MediaQuery.of(context).size.width / 2 + 20, child: Opacity(
                      opacity: strokeIndex > 17 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_18.png', scale: 2.8))
                    ),
                    Positioned(top: 410, right: MediaQuery.of(context).size.width / 2 + 46, child: Opacity(
                      opacity: strokeIndex > 18 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_19.png', scale: 2.8))
                    ),
                    Positioned(top: 395, right: MediaQuery.of(context).size.width / 2 + 70, child: Opacity(
                      opacity: strokeIndex > 19 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_20.png', scale: 2.8))
                    ),
                    Positioned(top: 377, right: MediaQuery.of(context).size.width / 2 + 91, child: Opacity(
                      opacity: strokeIndex > 20 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_21.png', scale: 2.8))
                    ),
                    Positioned(top: 356, right: MediaQuery.of(context).size.width / 2 + 110, child: Opacity(
                      opacity: strokeIndex > 21 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_22.png', scale: 2.8))
                    ),
                    Positioned(top: 332, right: MediaQuery.of(context).size.width / 2 + 124, child: Opacity(
                      opacity: strokeIndex > 22 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_23.png', scale: 2.8))
                    ),
                    Positioned(top: 306, right: MediaQuery.of(context).size.width / 2 + 132, child: Opacity(
                      opacity: strokeIndex > 23 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_24.png', scale: 2.8))
                    ),
                    Positioned(top: 278, right: MediaQuery.of(context).size.width / 2 + 136, child: Opacity(
                      opacity: strokeIndex > 24 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_25.png', scale: 2.8))
                    ),
                    Positioned(top: 250, right: MediaQuery.of(context).size.width / 2 + 133, child: Opacity(
                      opacity: strokeIndex > 25 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_26.png', scale: 2.8))
                    ),
                    Positioned(top: 222, right: MediaQuery.of(context).size.width / 2 + 124, child: Opacity(
                      opacity: strokeIndex > 26 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_27.png', scale: 2.8))
                    ),
                    Positioned(top: 196, right: MediaQuery.of(context).size.width / 2 + 109, child: Opacity(
                      opacity: strokeIndex > 27 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_28.png', scale: 2.8))
                    ),
                    Positioned(top: 174, right: MediaQuery.of(context).size.width / 2 + 92, child: Opacity(
                      opacity: strokeIndex > 28 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_29.png', scale: 2.8))
                    ),
                    Positioned(top: 157, right: MediaQuery.of(context).size.width / 2 + 70, child: Opacity(
                      opacity: strokeIndex > 29 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_30.png', scale: 2.8))
                    ),
                    Positioned(top: 144, right: MediaQuery.of(context).size.width / 2 + 46, child: Opacity(
                      opacity: strokeIndex > 30 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_31.png', scale: 2.8))
                    ),
                    Positioned(top: 137, right: MediaQuery.of(context).size.width / 2 + 20, child: Opacity(
                      opacity: strokeIndex > 31 ? 1 : 0,
                      child: Image.asset('assets/images/mine/stroke_32.png', scale: 2.8))
                    ),
                    buildShakeAnimationWidget()
                  ],
                ),
                Positioned(
                  top: 0,
                  child: Text('Pool Mining', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                ),
                Positioned(
                  top: 2,
                  right: 16,
                  child: InkWell(
                    onTap: _showRuleDialog,
                    child: Image.asset('assets/icons/icon_info.png', width: 24),
                  )
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
                              child: Text('$goldDaily', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ),
                _mining ? Positioned(
                  bottom: 96,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(112, 21, 239, 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/icon_rocket.png', width: 20, height: 20),
                                SizedBox(width: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('10', style: TextStyle(color: Colors.white, fontSize: 16, height: 1.25)),
                                    Text(' Gh/s', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 11)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(112, 21, 239, 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/icon_crown.png', width: 20, height: 20),
                                SizedBox(width: 6),
                                Text('20%', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 16, height: 1.25)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 54,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(112, 21, 239, 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/icon_clock.png', width: 20, height: 20),
                                SizedBox(width: 6),
                                Text('8:00:00', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 16, height: 1.25)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    )
                  )
                ): Container(),
                Positioned(
                  bottom: 0,
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(92, 81, 255, 1)),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                backgroundColor: Color.fromRGBO(92, 81, 255, 0.3),
                                overlayColor: Color.fromRGBO(92, 81, 255, 1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/icon_alarm.png', width: 24),
                                  Text('2h', style: TextStyle(color: Colors.white, fontSize: 14))
                                ]
                              ),
                            ),
                          ),
                          Positioned(
                            top: -4,
                            right: -6,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(91, 50, 45, 1),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Text('x2', style: TextStyle(color: Color.fromRGBO(252, 114, 90, 1), fontSize: 10, height: 1),),
                            )
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: 96,
                        padding: EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(112, 21, 239, _mining ? 0.3 : 1),
                            overlayColor: _mining ?Color.fromRGBO(112, 21, 239, 1) : Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(_mining ? 'Mining  23.2 Coins' : 'Mine', style: TextStyle(
                            color: _mining ? Color.fromRGBO(112, 21, 239, 1) : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )),
                          onPressed: () {
                            setState(() {
                              if (!_mining) {
                                _mining = true;
                                Timer.periodic(const Duration(milliseconds: 40), (timer) {
                                  if (!_mining) timer.cancel();
                                  setState(() {
                                    if (strokeIndex < 33) {
                                      strokeIndex++;
                                    } else {
                                      strokeIndex = 1;
                                    }
                                  });
                                });
                              } else {
                                _mining = false;
                                strokeIndex = -1;
                              }
                            });
                          }
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ))
        ],
      ),
    );
  }


  
    ///抖动动画控制器
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();
  ///构建抖动效果
  ShakeAnimationWidget buildShakeAnimationWidget() {
    return ShakeAnimationWidget(
      //抖动控制器
      shakeAnimationController: _shakeAnimationController,
      //微旋转的抖动
      shakeAnimationType: ShakeAnimationType.SkewShake,
      //设置不开启抖动
      isForward: false,
      //默认为 0 无限执行
      shakeCount: 1,
      //抖动的幅度 取值范围为[0,1]
      shakeRange: 0.2,
      //执行抖动动画的子Widget
      child: Listener(
        child: Image.asset('assets/icons/icon_simu.png', width: isClick ? 210 : 216),
        onPointerDown: (event) {
          setState(() {
            isClick = true;
          });
        },
        onPointerUp: (event) async {
          int threshold = 5 * _level;
          Global.increaseGold(threshold);
          setState(() {
            isClick = false;
          });

          // //判断抖动动画是否正在执行
          // if (_shakeAnimationController.animationRunging) {
          //   //停止抖动动画
          //   _shakeAnimationController.stop();
          // } else {
          //   //开启抖动动画
          //   //参数shakeCount 用来配置抖动次数
          //   //通过 controller start 方法默认为 1
          //   _shakeAnimationController.start(shakeCount: 1);
          // }
          _shakeAnimationController.start();

          Overlay.of(context).insert(OverlayEntry(builder: (context) => Positioned(
            top: 426,
            left: 260,
            child: FadeOutUp(child: Text('+$threshold', style: TextStyle(
              color: Color.fromRGBO(36, 245, 219, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontFamily: 'Lexend',
              decoration: TextDecoration.none
            )))
          )));
        },
      )
    );
  }
}
