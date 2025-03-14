import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true, // 滑动到顶端时会固定住
            backgroundColor: Colors.black,
            // expandedHeight: 80,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text('Profile', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'setting');
                },
                child: Image.asset('assets/icons/icon_setting.png', width: 24,),
              ),
              SizedBox(width: 16)
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              // padding: const EdgeInsets.fromLTRB(0, kToolbarHeight + 12, 0, 0),
              child: Column(
                children: [
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Image.asset('assets/icons/icon_back.png', width: 24,),
                  //       ),
                  //       SizedBox(width: 16),
                  //       Text('Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  //       Spacer(),
                  //       Image.asset('assets/icons/icon_setting.png', width: 24)
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 66,
                      height: 66,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: ClipOval(
                        child: Image.asset('assets/images/avator/lion.jpeg', fit: BoxFit.cover),
                      )
                    ),
                  ),
                  SizedBox(height: 6),
                  Text('Liam xaffizme', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromRGBO(112, 21, 239, 0.4), Color.fromRGBO(92, 81, 255, 0.4)]
                      )
                    ),
                    child: Text('Lvl 1', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Lvl 1', style: TextStyle(color: Colors.white, fontSize: 14)),
                            Spacer(),
                            Row(
                              children: [
                                Image.asset('assets/icons/icon_xp.png', width: 24,),
                                Text('80', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 1), fontSize: 14)),
                                Text('/200', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8,),
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
                                width: 100 / 200 * 190 + 8,
                                height: 8,
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(112, 21, 239, 1),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                              )
                            ),
                            Positioned(
                              left: 100 / 200 * 190,
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
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 64) / 3,
                          height: 80,
                          padding: EdgeInsets.only(top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(22, 22, 26, 1),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total balance', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 11),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/icon_coin.png', width: 20, height: 20,),
                                  Container(
                                    padding: EdgeInsets.only(top: 3, left: 4),
                                    child: Text('123,12', style: TextStyle(color: Colors.white, fontSize: 16)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 64) / 3,
                          height: 80,
                          padding: EdgeInsets.only(top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(22, 22, 26, 1),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Miner', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 11),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/icon_rocket.png', width: 20),
                                  Container(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('10 Gh/s', style: TextStyle(color: Colors.white, fontSize: 16)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 64) / 3,
                          height: 80,
                          padding: EdgeInsets.only(top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(22, 22, 26, 1),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Booster', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 11),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/icon_alarm.png', width: 20, height: 20,),
                                  Container(
                                    padding: EdgeInsets.only(top: 1, left: 4),
                                    child: Text('2h', style: TextStyle(color: Colors.white, fontSize: 16)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(16),
                    child: Text('NFTs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       SizedBox(height: 120),
                  //       Text("You don't have any NFTs yet. Tap to mint.", style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),),
                  //       SizedBox(height: 30),
                  //       Container(
                  //         width: 260,
                  //         height: 54,
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             overlayColor: Colors.white,
                  //             backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                  //             disabledBackgroundColor: Color.fromRGBO(35, 36, 41, 1),
                  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  //           ),
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: Text('Mint', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: index % 2 == 0 ? 16 : 0, right: index % 2 == 0 ? 0 : 16, bottom: 16),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(22, 22, 26, 1),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 168,
                          height: 168,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(53, 54, 60, 1),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/images/avator/lion.jpeg', fit: BoxFit.cover),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color.fromRGBO(112, 21, 239, 1), Color.fromRGBO(92, 81, 255, 1)],
                                  ),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    overlayColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    elevation: 0, // 阴影
                                    backgroundColor: Colors.transparent,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)
                                    )
                                  ),
                                  child: Text('Set as Avator', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  )),
                                  onPressed: () {}
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromRGBO(35, 36, 41, 1),
                                  border: Border.all(color: Color.fromRGBO(53, 54, 60, 1), width: 1)
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    overlayColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    elevation: 0, // 阴影
                                    backgroundColor: Colors.transparent,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)
                                    )
                                  ),
                                  child: Image.asset('assets/icons/icon_download.png', width: 20,),
                                  onPressed: () {}
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 6,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.788,
            ),
          ),
        ],
			),
		);
	}
}