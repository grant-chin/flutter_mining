import 'package:flutter/material.dart';
import 'dart:ui';


class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: <Widget>[
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              width: MediaQuery.of(context).size.width,
              height: window.physicalSize.height / window.devicePixelRatio,
              padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
              decoration: BoxDecoration(color: Color(0xff0F0F12)),
              child: Column(
                children: [
                  Image.asset('assets/images/tasks/task_title.png'),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/tasks/turntable.png',
                        width: MediaQuery.of(context).size.width - 96,
                        height: MediaQuery.of(context).size.width - 96,
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            Text('Today reward', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/icon_coin.png', width: 30, height: 30),
                                Container(
                                  margin: EdgeInsets.only(left: 4, top: 4),
                                  child: Text('200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 1), fontSize: 24, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                                overlayColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text('Claim', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              onPressed: () {}
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
                      ],
                    ),
                  )
                ],
              )
            ),
            childCount: 1
          ),
          itemExtent: 1200,
        ),
      ])
    );
  }
}
