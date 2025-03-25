import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mining/common/Global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_extend/share_extend.dart';

int weekday = DateTime.now().weekday;
int get _level => Global.level; // 等级
List<String> get claimedArr => Global.weekSignedTimes; // 周签到时间
bool isSignedToday = Global.isSignedToday; // 今日是否已签到
bool isRate = Global.isRate; // 是否评价
bool successRated = false; // 是否成功完成评价
bool isShared = Global.isShared; // 是否分享
bool successShared = false; // 是否成功完成分享
int get mintTimes => Global.mintTimes; // 已铸造次数
List<String> get nftList => Global.nftList; // 已经获取的NFT列表
bool isClaimActivePioneer = Global.isClaimActivePioneer; // 是否已领取铸造先锋奖励
bool isClaimGoalAchiever = Global.isClaimGoalAchiever; // 是否已领取NFT铸造成功成就
bool isClaimPowerExpert = Global.isClaimPowerExpert; // 是否已领取铸造专家成就
bool isClaimGoalMaster = Global.isClaimGoalMaster; // 是否已领取铸造专家成就
bool isClaimVitalityChampion = Global.isClaimVitalityChampion; // 是否已领取铸造冠军成就
bool isClaimPeakAchiever = Global.isClaimPeakAchiever; // 是否已领取巅峰成就

List<String> _marketUrls = [
  "vivomarket://details?id=your_package_name&th_name=need_comment",
  "oaps://mk/developer/comment?pkg=your_package_name",
  "appmarket://details?id=your_package_name",
  "mimarket://details?id=your_package_name",
  "itms-apps://itunes.apple.com/app/idyour_package_id?action=write-review",
];
  
  Future<String?> _getLaunchUrl() async {
    for (String item in _marketUrls) {
      if (await canLaunchUrl(Uri.parse(item))) {
        return item;
      }
    }
    return null;
  }

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }
  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached: () {};
      case AppLifecycleState.resumed: _onResumed();
      case AppLifecycleState.inactive: () {};
      case AppLifecycleState.hidden: () {};
      case AppLifecycleState.paused: () {};
    }
  }
  void _onResumed() {
    if (successRated) {
      setState(() => successRated = false);
      _showDialog(1, 'Thanks for Your Feedback!', 50, () {
        Global.receiveRateAward();
        setState(() => isRate = Global.isRate);
      });
    }
    if (successShared) {
      setState(() => successShared = false);
      _showDialog(2, 'Speread the Joy!', 25, () {
        Global.receiveShareAward();
        setState(() => isShared = Global.isShared);
      });
    }
  }


  // 评分按钮点击事件调用：
  Future<void> _toRate() async {
    String url = await _getLaunchUrl() ?? '';
    if(url != '') {
      setState(() {
        successRated = true;
      });
      await launchUrl(Uri.parse(url));
    } else {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (_) => Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(15, 15, 18, 1),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Text('Failed to Retrieve', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              )
            )
          ],
        )
      );
    }
  }
  // 分享
  _toShare() {
    setState(() {
      successShared = true;
    });
    ShareExtend.share("🚀 Earn Gold Together! 🚀Join me on SimuPool - the smartest way to mine crypto effortlessly! 💎", "text");
  }
  // 领取奖励弹窗
  _showDialog(type, subtitle, exp, claimFunc) {
    final imgs = {
      1: 'assets/images/tasks/dialog_title_rating_complete.png', // 评价
      2: 'assets/images/tasks/dialog_title_sharing_is_winning.png', // 分享
      3: 'assets/images/tasks/dialog_title_treasure_collected.png', // 铸造成就
      4: 'assets/images/tasks/dialog_title_NFT_minted.png', // NFT
      5: 'assets/images/tasks/dialog_title_milestone_achieved.png', // 等级成就
    };

    showDialog(
      context: context,
      useSafeArea: false,
      // 构建 Dialog 的视图
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            top: 210,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/tasks/dialog_task.png', width: MediaQuery.of(context).size.width),
                    Positioned(
                      top: 26,
                      left: 26,
                      child: Image.asset(imgs[type]!, height: 40)
                    ),
                  ],
                ),
                Positioned(bottom: 26, child: SizedBox(
                  width: MediaQuery.of(context).size.width - 160,
                  height: MediaQuery.of(context).size.width - 240,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(subtitle, style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),),
                      Container(
                        width: 160,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(35, 36, 41, 1),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text('+$exp', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            Image.asset('assets/icons/icon_xp.png', width: 24),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            overlayColor: Colors.white,
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            claimFunc();
                            Navigator.pop(context);
                          },
                          child: Text('Claim it', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            )
          ),
          Positioned(
            top: MediaQuery.of(context).size.width + 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                overlayColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.all(0),
              ),
              onPressed: () {
                claimFunc();
                Navigator.pop(context);
              },
              child: Image.asset('assets/icons/icon_close.png', width: 40)
            )
          )
        ],
      )
    );
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
          child:  SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/tasks/turn_table.png', width: 344),
                    // day 1
                    // Positioned(top: 13, left: 160, child: Image.asset('assets/images/tasks/day_1_default.png', scale: 2.95)),
                    weekday == 1 && !claimedArr.contains('1') ? Positioned(top: 13, left: MediaQuery.of(context).size.width / 2 - 60, child: Image.asset('assets/images/tasks/day_1_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('1') ? Positioned(top: 13, left: MediaQuery.of(context).size.width / 2 - 60, child: Image.asset('assets/images/tasks/day_1_plain.png', scale: 2.95)) : Container(),
                    // day 2
                    weekday < 2 ? Positioned(top: 33, left: MediaQuery.of(context).size.width / 2 + 42, child: Image.asset('assets/images/tasks/day_2_default.png', scale: 2.95)) : Container(),
                    weekday == 2 && !claimedArr.contains('2') ? Positioned(top: 34, left: MediaQuery.of(context).size.width / 2 + 42, child: Image.asset('assets/images/tasks/day_2_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('2') ? Positioned(top: 34, left: MediaQuery.of(context).size.width / 2 + 42, child: Image.asset('assets/images/tasks/day_2_plain.png', scale: 2.95)) : Container(),
                    // day 3
                    weekday < 3 ? Positioned(top: 144, left: MediaQuery.of(context).size.width / 2 + 68, child: Image.asset('assets/images/tasks/day_3_default.png', scale: 2.95)) : Container(),
                    weekday == 3 && !claimedArr.contains('3') ? Positioned(top: 144, left: MediaQuery.of(context).size.width / 2 + 68, child: Image.asset('assets/images/tasks/day_3_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('3') ? Positioned(top: 144, left: MediaQuery.of(context).size.width / 2 + 68, child: Image.asset('assets/images/tasks/day_3_plain.png', scale: 2.95)) : Container(),
                    // day 4
                    weekday < 4 ? Positioned(top: 236, left: MediaQuery.of(context).size.width / 2 - 9, child: Image.asset('assets/images/tasks/day_4_default.png', scale: 2.95)) : Container(),
                    weekday == 4 && !claimedArr.contains('4') ? Positioned(top: 236, left: MediaQuery.of(context).size.width / 2 - 9, child: Image.asset('assets/images/tasks/day_4_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('4') ? Positioned(top: 236, left: MediaQuery.of(context).size.width / 2 - 9, child: Image.asset('assets/images/tasks/day_4_plain.png', scale: 2.95)) : Container(),
                    // day 5
                    weekday < 5 ? Positioned(top: 226, left: MediaQuery.of(context).size.width / 2 - 114, child: Image.asset('assets/images/tasks/day_5_default.png', scale: 2.95)) : Container(),
                    weekday == 5 && !claimedArr.contains('5') ? Positioned(top: 226, left: MediaQuery.of(context).size.width / 2 - 114, child: Image.asset('assets/images/tasks/day_5_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('5') ? Positioned(top: 226, left: MediaQuery.of(context).size.width / 2 - 114, child: Image.asset('assets/images/tasks/day_5_plain.png', scale: 2.95)) : Container(),
                    // day 6
                    weekday < 6 ? Positioned(top: 136, left: MediaQuery.of(context).size.width / 2 - 153, child: Image.asset('assets/images/tasks/day_6_default.png', scale: 2.95)) : Container(),
                    weekday == 6 && !claimedArr.contains('6') ? Positioned(top: 136, left: MediaQuery.of(context).size.width / 2 - 153, child: Image.asset('assets/images/tasks/day_6_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('6') ? Positioned(top: 136, left: MediaQuery.of(context).size.width / 2 - 153, child: Image.asset('assets/images/tasks/day_6_plain.png', scale: 2.95)) : Container(),
                    // day 7
                    weekday < 7 ? Positioned(top: 42, left: MediaQuery.of(context).size.width / 2 - 155, child: Image.asset('assets/images/tasks/day_7_default.png', scale: 2.95)) : Container(),
                    weekday == 7 && !claimedArr.contains('7') ? Positioned(top: 42, left: MediaQuery.of(context).size.width / 2 - 155, child: Image.asset('assets/images/tasks/day_7_primary.png', scale: 2.95)) : Container(),
                    claimedArr.contains('7') ? Positioned(top: 42, left: MediaQuery.of(context).size.width / 2 - 155, child: Image.asset('assets/images/tasks/day_7_plain.png', scale: 2.95)) : Container(),

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
                            onPressed: isSignedToday ? null : () {
                              Global.onSignToday();
                              setState(() => isSignedToday = Global.isSignedToday);
                            },
                            child: Text(isSignedToday ? 'Claimed' : 'Claim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      // 评分
                      taskItem(
                        'assets/images/tasks/icon_thumb.png',
                        'Rate us',
                        'Rating successful +50',
                        isRate ? 'Claimed' : 'Rate',
                        _toRate
                      ),
                      // 分享
                      taskItem(
                        'assets/images/tasks/icon_clap.png',
                        'Invite friends',
                        'Successfully shared once +25',
                        isShared ? 'Claimed' : 'Share',
                        _toShare
                      ),
                      // 3次铸造成功成就
                      taskItem(
                        'assets/images/tasks/icon_potholing.png',
                        'Active pioneer',
                        'Mining 3 times +200',
                        isClaimActivePioneer ? 'Claimed' : 'Claim',
                        mintTimes > 2 ? () {
                          _showDialog(3, 'Mining Rewards Unlocked!', 200, () {
                            Global.receiveMineAward_3();
                            setState(() => isClaimActivePioneer = Global.isClaimActivePioneer);
                          });
                        } : null
                      ),
                      // 首次获得NFT成就
                      taskItem(
                        'assets/images/tasks/icon_mystery.png',
                        'Goal achiever',
                        'Complete 1 NFT minting +500',
                        isClaimGoalAchiever ? 'Claimed' : 'Claim',
                        nftList.isNotEmpty ? () {
                          _showDialog(2, 'Mint Complete! Welcome to the Future!', 500, () {
                            Global.receiveNFTAward();
                            setState(() => isClaimGoalAchiever = Global.isClaimGoalAchiever);
                          });
                        } : null
                      ),
                      // 5次铸造成功成就
                      taskItem(
                        'assets/images/tasks/icon_potholing.png',
                        'Power expert',
                        'Mining 5 times +600',
                        isClaimPowerExpert ? 'Claimed' : 'Claim',
                        mintTimes > 5 ? () {
                          _showDialog(2, 'Mining Rewards Unlocked!', 600, () {
                            Global.receiveMineAward_5();
                            setState(() => isClaimPowerExpert = Global.isClaimPowerExpert);
                          });
                        } : null
                      ),
                      // 10级成就
                      taskItem(
                        'assets/images/tasks/icon_badge_10.png',
                        'Goal master',
                        'Reach Level 10 +1000',
                        isClaimGoalMaster ? 'Claimed' : 'Claim',
                        _level >= 10 ? () {
                          _showDialog(2, 'Level 10 Unlocked! You’re on Fire!', 1000, () {
                            Global.receiveLevelAward_10();
                            setState(() => isClaimGoalMaster = Global.isClaimGoalMaster);
                          });
                        } : null
                      ),
                      // 20次铸造成功成就
                      taskItem(
                        'assets/images/tasks/icon_potholing.png',
                        'Vitality champion',
                        'Mining 20 times +2000',
                        isClaimVitalityChampion ? 'Claimed' : 'Claim',
                        mintTimes > 20 ? () {
                          _showDialog(2, 'Mining Rewards Unlocked!', 2000, () {
                            Global.receiveMineAward_20();
                            setState(() => isClaimVitalityChampion = Global.isClaimVitalityChampion);
                          });
                        } : null
                      ),
                      // 50级成就
                      taskItem(
                        'assets/images/tasks/icon_badge_50.png',
                        'Peak achiever',
                        'Reach Level 50 +5000',
                        isClaimPeakAchiever ? 'Claimed' : 'Claim',
                        _level >= 50 ? () {
                          _showDialog(2, 'Level 50 Unlocked! You’re on Fire!', 5000, () {
                            Global.receiveLevelAward_50();
                            setState(() => isClaimPeakAchiever = Global.isClaimPeakAchiever);
                          });
                        } : null
                      ),
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

Widget taskItem(img, title, desc, btnText, func) {
  return Container(
    height: 64,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(top: 10, bottom: 6),
    decoration: BoxDecoration(
      color: Color.fromRGBO(22, 22, 26, 1),
      borderRadius: BorderRadius.circular(16)
    ),
    child: Row(
      children: [
        Image.asset(img, width: 40, height: 40),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white),),
            Row(
              children: [
                Text(desc, style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                Image.asset('assets/icons/icon_xp.png', width: 16, height: 16,)
              ],
            )
          ],
        ),
        Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            overlayColor: btnText == 'Claimed' ? Colors.transparent : Colors.white,
            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(112, 21, 239, 1),
            disabledForegroundColor: btnText == 'Claimed' ? Colors.white : Color.fromRGBO(249, 249, 249, 0.2),
            disabledBackgroundColor: btnText == 'Claimed' ? Color.fromRGBO(112, 21, 239, 0.3) : Color.fromRGBO(35, 36, 41, 1),
            padding: EdgeInsets.symmetric(horizontal: 12),
            side: BorderSide(color: btnText == 'Claimed' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: btnText == 'Claimed' ? null : func,
          child: Text(btnText, style: TextStyle(fontSize: 16)),
        )
      ],
    ),
  );
}