import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_local.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin {
  int weekday = DateTime.now().weekday;
  List ClaimedArr = [];
  bool is_claimed = false; // 今日是否已签到

  _onTodayClaim() {
    setState(() {
      is_claimed = !is_claimed;
      ClaimedArr = [...ClaimedArr, weekday];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true, // 滑动到顶端时会固定住
          backgroundColor: Colors.black,
          // expandedHeight: 100,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Daily bonus', style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          )),
        ),
        SliverToBoxAdapter(
          child:  Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/tasks/turn_table.png', width: 344),
                    // day 1
                    // Positioned(top: 13, left: 160, child: Image.asset('assets/images/tasks/day_1_default.png', scale: 2.95)),
                    weekday == 1 && !ClaimedArr.contains(1) ? Positioned(top: 13, left: 160, child: Image.asset('assets/images/tasks/day_1_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(1) ? Positioned(top: 13, left: 160, child: Image.asset('assets/images/tasks/day_1_plain.png', scale: 2.95)) : Container(),
                    // day 2
                    weekday < 2 ? Positioned(top: 34, left: 262, child: Image.asset('assets/images/tasks/day_2_default.png', scale: 2.95)) : Container(),
                    weekday == 2 && !ClaimedArr.contains(2) ? Positioned(top: 34, left: 262, child: Image.asset('assets/images/tasks/day_2_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(2) ? Positioned(top: 34, left: 262, child: Image.asset('assets/images/tasks/day_2_plain.png', scale: 2.95)) : Container(),
                    // day 3
                    weekday < 3 ? Positioned(top: 144, left: 288, child: Image.asset('assets/images/tasks/day_3_default.png', scale: 2.95)) : Container(),
                    weekday == 3 && !ClaimedArr.contains(3) ? Positioned(top: 144, left: 288, child: Image.asset('assets/images/tasks/day_3_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(3) ? Positioned(top: 144, left: 288, child: Image.asset('assets/images/tasks/day_3_plain.png', scale: 2.95)) : Container(),
                    // day 4
                    weekday < 4 ? Positioned(top: 236, left: 211, child: Image.asset('assets/images/tasks/day_4_default.png', scale: 2.95)) : Container(),
                    weekday == 4 && !ClaimedArr.contains(4) ? Positioned(top: 236, left: 211, child: Image.asset('assets/images/tasks/day_4_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(4) ? Positioned(top: 236, left: 211, child: Image.asset('assets/images/tasks/day_4_plain.png', scale: 2.95)) : Container(),
                    // day 5
                    weekday < 5 ? Positioned(top: 226, left: 106, child: Image.asset('assets/images/tasks/day_5_default.png', scale: 2.95)) : Container(),
                    weekday == 5 && !ClaimedArr.contains(5) ? Positioned(top: 226, left: 106, child: Image.asset('assets/images/tasks/day_5_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(5) ? Positioned(top: 226, left: 106, child: Image.asset('assets/images/tasks/day_5_plain.png', scale: 2.95)) : Container(),
                    // day 6
                    weekday < 6 ? Positioned(top: 136, left: 67, child: Image.asset('assets/images/tasks/day_6_default.png', scale: 2.95)) : Container(),
                    weekday == 6 && !ClaimedArr.contains(6) ? Positioned(top: 136, left: 67, child: Image.asset('assets/images/tasks/day_6_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(6) ? Positioned(top: 136, left: 67, child: Image.asset('assets/images/tasks/day_6_plain.png', scale: 2.95)) : Container(),
                    // day 7
                    weekday < 7 ? Positioned(top: 42, left: 65, child: Image.asset('assets/images/tasks/day_7_default.png', scale: 2.95)) : Container(),
                    weekday == 7 && !ClaimedArr.contains(7) ? Positioned(top: 42, left: 65, child: Image.asset('assets/images/tasks/day_7_primary.png', scale: 2.95)) : Container(),
                    ClaimedArr.contains(7) ? Positioned(top: 42, left: 65, child: Image.asset('assets/images/tasks/day_7_plain.png', scale: 2.95)) : Container(),

                    Positioned(
                      child: Column(
                        children: [
                          Text('Today reward', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 11)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/icon_coin.png', width: 30, height: 30),
                              Container(
                                margin: EdgeInsets.only(left: 4, top: 6),
                                child: Text('200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 1), fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              foregroundColor: Colors.white,
                              disabledForegroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                              disabledBackgroundColor: Color.fromRGBO(112, 21, 239, 0.3),
                              side: BorderSide(color: Color.fromRGBO(112, 21, 239, 1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                            onPressed: is_claimed ? null : _onTodayClaim,
                            child: Text(is_claimed ? 'Claimed' : 'Claim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    )
                  ]
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/tasks/task_list.png'),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_thumb.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rate us', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Rating successful +50', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              width: 94,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                  overlayColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: Text('Rate', style: TextStyle(color: Colors.white, fontSize: 16)),
                                onPressed: () {}
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_clap.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Invite friends', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Successfully shared once +25', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Share', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_potholing.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Active pioneer', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Claim mining rewards 3 times +200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Claim', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_mystery.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Goal achiever', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Complete 1 NFT minting +500', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Claim', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_potholing.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Power expert', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Claim mining rewards 5 times +600', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Share', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_badge_10.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Goal master', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Reach Level 10 +1000', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Share', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_potholing.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vitality champion', style: TextStyle(color: Colors.white)),
                                Row(
                                  children: [
                                    Text('Claim mining rewards 20 times +2000', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Share', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(22, 22, 26, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/tasks/icon_badge_50.png', width: 40, height: 40),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Peak achiever', style: TextStyle(color: Colors.white),),
                                Row(
                                  children: [
                                    Text('Reach Level 50 +5000', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                                    Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Share', style: TextStyle(color: Colors.white, fontSize: 16)),
                              onPressed: () {}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                )
              ],
            )
          ),
        ),
      ])
    );
  }
}
