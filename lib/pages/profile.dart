import 'package:flutter/material.dart';
import 'package:flutter_mining/common/Global.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<String> images = [
  'assets/images/NFTs/nft_1.png',
  'assets/images/NFTs/nft_2.png',
];
int get _level => Global.level; // 等级
int get _exp => Global.exp; // 经验值
int get goldTotal => Global.goldTotal;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
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
            child: SizedBox(
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
                    child: Text('Lvl $_level', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 12)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Lvl $_level', style: TextStyle(color: Colors.white, fontSize: 14)),
                            Spacer(),
                            Row(
                              children: [
                                Image.asset('assets/icons/icon_xp.png', width: 24,),
                                Text('$_exp', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 1), fontSize: 14)),
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
                                    child: Text('$goldTotal', style: TextStyle(color: Colors.white, fontSize: 16)),
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
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 10),
                    child: Text('NFTs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  images.isEmpty ? SizedBox(
                    child: Column(
                      children: [
                        SizedBox(height: 120),
                        Text("You don't have any NFTs yet. Tap to mint.", style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 260,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              overlayColor: Colors.white,
                              backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                              disabledBackgroundColor: Color.fromRGBO(35, 36, 41, 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Mint', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ) : nftListWidget(context)
                ],
              ),
            ),
          ),
        ],
			),
		);
	}
}

Widget nftListWidget(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height - 455,
    child: MasonryGridView.count(
      padding: EdgeInsets.fromLTRB(16, 8, 16, kBottomNavigationBarHeight),
      crossAxisCount: 2, //几列
      mainAxisSpacing: 16, // 间距
      crossAxisSpacing: 16, // 纵向间距？
      itemCount: images.length, // 元素个数
      itemBuilder: (context, index) {
        return SizedBox(
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
                    child: Image.asset(images[index], fit: BoxFit.cover),
                  )
                ),
                SizedBox(height: 16),
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
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
                            fontWeight: FontWeight.w500,
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
    ),
  );
}