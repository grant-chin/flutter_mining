import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:math';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with SingleTickerProviderStateMixin {
  String miner = '';
  bool isMinting = false;
  int mintIndex = -1;
  int mintEndIndex = 0;
  int mintRound = 0;

  // 选择铸造道具
  _setMiner(name) {
    setState(() {
      if (miner != name) { miner = name; }
      else { miner = ''; }
    });
  }

  // 开始铸造
  _goMinting() {
    setState(() {
      if (isMinting) return;
      isMinting = true;
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        setState(() {
          // 轮盘动画index映射
          if (mintIndex < 7) {
            mintIndex++;
          } else {
            mintIndex = 0;
            mintRound++;
          }
          // 控制结束落点
          switch(miner) {
            case 'Rocket': mintEndIndex = 0; break;
            case 'Booster': mintEndIndex = 5; break;
            case 'NFTs': mintEndIndex = [1, 2, 3, 4, 6, 7][Random().nextInt(6)]; break;
          }
          if (mintRound > 3 && mintIndex == mintEndIndex) {
            isMinting = false;
            mintRound = 0;
            timer.cancel();

            showDialog(// 传入 context
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
                  Positioned(top: 180, child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/item/dialog_miner.png', width: MediaQuery.of(context).size.width,),
                      Positioned(bottom: 30, child: SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        height: MediaQuery.of(context).size.width - 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('You’ve Unlocked a Mystery Item!', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),),
                            Container(
                              width: 160,
                              height: 144,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(35, 36, 41, 1),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset('assets/icons/icon_rocket.png', width: 50),
                                  Text('Miner', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                                  Text('20 Gh/s', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 58,
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
                                child: Text('Claim it', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  )),
                  Positioned(
                    top: MediaQuery.of(context).size.width + 210,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/icons/icon_close.png', width: 40)
                    )
                  )
                ],
              )
            );
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
      decoration: BoxDecoration(
        color: Color(0xff0F0F12),
        image: DecorationImage(image: AssetImage('assets/images/item/item_bg.png'), fit: BoxFit.fill)
      ),
      child: Column(
        children: [
          Image.asset('assets/images/item/item_title.png'),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/item/tips_text.png', width: MediaQuery.of(context).size.width - 180),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Image.asset('assets/images/item/turn_bg.png'),
                    )
                  ],
                ),
                Positioned(
                  right: -16,
                  top: -60,
                  child: Image.asset('assets/images/item/tips_icon.png', width: 180,)
                ),
                Positioned(
                  bottom: 32,
                  child: Text('Select the item you want to mint', style: TextStyle(
                    color: Color.fromRGBO(249, 249, 249, 0.8),
                    fontSize: 16,
                  ))
                ),
                Positioned(
                  top: 90,
                  left: 32,
                  width: MediaQuery.of(context).size.width - 98,
                  height: MediaQuery.of(context).size.width - 98,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 0 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_rocket.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('Rocket', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 1 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_NFT.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('NFTs', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 2 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_NFT.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('NFTs', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 7 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_NFT.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('NFTs', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/turn_value.png', width: 102,),
                              Positioned(
                                top: 22,
                                child: Text('Est. Cost', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14),),
                              ),
                              Positioned(
                                bottom: 24,
                                child: Row(
                                  children: [
                                    Image.asset('assets/icons/icon_coin.png', width: 30,),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, left: 2),
                                      child: Text('0', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 3 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_NFT.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('NFTs', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 6 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_NFT.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('NFTs', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 5 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_alarm.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('Booster', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: 102,),
                              mintIndex == 4 ? Image.asset('assets/images/item/bot_active.png', width: 102,) : Container(),
                              Column(
                                children: [
                                  Image.asset('assets/icons/icon_NFT.png', width: 48,),
                                  SizedBox(height: 4),
                                  Text('NFTs', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _setMiner('Rocket');
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 96) / 3,
                    margin: EdgeInsets.only(left: 16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: miner == 'Rocket' ? Color.fromRGBO(112, 21, 239, 0.15) : Color.fromRGBO(22, 22, 26, 1),
                      border: Border.all(color: miner == 'Rocket' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/icon_rocket.png', width: 38),
                        SizedBox(width: 4),
                        Text('Rocket', style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _setMiner('Booster');
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 96) / 3,
                    margin: EdgeInsets.only(left: 16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: miner == 'Booster' ? Color.fromRGBO(112, 21, 239, 0.15) : Color.fromRGBO(22, 22, 26, 1),
                      border: Border.all(color: miner == 'Booster' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/icon_alarm.png', width: 38),
                        SizedBox(width: 4),
                        Text('Booster', style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _setMiner('NFTs');
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 96) / 3,
                    margin: EdgeInsets.only(left: 16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: miner == 'NFTs' ? Color.fromRGBO(112, 21, 239, 0.15) : Color.fromRGBO(22, 22, 26, 1),
                      border: Border.all(color: miner == 'NFTs' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/icon_NFT.png', width: 38),
                        SizedBox(width: 4),
                        Text('NFTs', style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 96,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                overlayColor: isMinting ? Colors.transparent : Colors.black,
                // foregroundColor: Colors.white,
                backgroundColor: isMinting ? Color.fromRGBO(112, 21, 239, 0.3) : Color.fromRGBO(112, 21, 239, 1),
                // disabledForegroundColor: Color.fromRGBO(249, 249, 249, 0.2),
                disabledBackgroundColor: Color.fromRGBO(35, 36, 41, 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: miner == '' ? null : _goMinting,
              child: Text(isMinting ? 'Minting' : 'Mint', style: TextStyle(
                color: miner == '' ? Color.fromRGBO(249, 249, 249, 0.2) : isMinting ? Color.fromRGBO(112, 21, 239, 1) : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),
          )
        ],
      )
    );
  }
}
