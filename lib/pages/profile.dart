import 'package:flutter/material.dart';
import 'package:flutter_mining/common/Global.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
// import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';


String avator = Global.avator; // 头像
int get _level => Global.level; // 等级
int get _exp => Global.exp; // 经验值
int get goldTotal => Global.goldTotal;
int get rocketEff => Global.rocketEff; // 挖矿效率/加速器效率
int get boosterNum => Global.boosterNum; // 拥有延时器数量
List<String> get nftList => Global.nftList;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  GlobalKey _globalKey = GlobalKey();

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
                        child: Image.asset(avator, fit: BoxFit.cover),
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
                                    child: Text('$rocketEff Gh/s', style: TextStyle(color: Colors.white, fontSize: 16)),
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
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Column(
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
                              Positioned(
                                top: -12,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(91, 50, 45, 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Text('x$boosterNum', style: TextStyle(color: Color.fromRGBO(252, 114, 90, 1), fontSize: 10, height: 1),),
                                )
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 10),
                    child: Text('NFTs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  nftList.isEmpty ? SizedBox(
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
                              Navigator.pop(context, 'item');
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

  Widget nftListWidget(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 455,
      child: MasonryGridView.count(
        padding: EdgeInsets.fromLTRB(16, 8, 16, kBottomNavigationBarHeight),
        crossAxisCount: 2, //几列
        mainAxisSpacing: 16, // 间距
        crossAxisSpacing: 16, // 纵向间距？
        itemCount: nftList.length, // 元素个数
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
                      child: RepaintBoundary(
                        key: _globalKey,
                        child: Image.asset(nftList[index], fit: BoxFit.cover)
                      )
                    )
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
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
                                padding: EdgeInsets.symmetric(horizontal: 12),
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
                              onPressed: () {
                                Global.setAvator(nftList[index]);
                                setState(() {
                                  avator = Global.avator;
                                });
                              }
                            ),
                          )
                        ),
                        SizedBox(width: 12),
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
                            onPressed: () {
                              _saveLocalImage();
                            }
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

  _saveLocalImage() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      String statusText = result['isSuccess'] ? 'Successfully' : 'Failed';
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
                child: Text('Saved to Album $statusText', style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none
                )),
              )
            )
          ],
        )
      );
    }
  }
}