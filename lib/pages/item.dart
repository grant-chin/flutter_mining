import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:math';
import 'package:flutter_mining/common/Global.dart';

String miner = ''; // 当前选择奖品 Rocket/Booster/NFTs
int minerCost = 0; // 抽奖花费
bool isMinting = false; // 是否正在抽奖
int mintIndex = -1;
int mintEndIndex = 0; // 结束点-控制奖品落点
int mintRound = 0; // 圈数-控制抽奖动画
int get rocketEff => Global.rocketEff + 10; // 挖矿效率/加速器效率
int get rocketSuccessCount => Global.rocketSuccessCount; // 成功获取加速器次数
int get goldBalance => Global.goldBalance; // 余额
int nftIndex = 0; // 抽到随机NFT下标
List<String> nfts = [
  'assets/images/NFTs/nft_1.png',
  'assets/images/NFTs/nft_2.png',
  'assets/images/NFTs/nft_3.png',
  'assets/images/NFTs/nft_4.png',
  'assets/images/NFTs/nft_5.png',
  'assets/images/NFTs/nft_6.png',
  'assets/images/NFTs/nft_7.png',
  'assets/images/NFTs/nft_8.png',
  'assets/images/NFTs/nft_9.png',
  'assets/images/NFTs/nft_10.png',
  'assets/images/NFTs/nft_11.png',
  'assets/images/NFTs/nft_12.png',
  'assets/images/NFTs/nft_13.png',
];

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with SingleTickerProviderStateMixin {
  // 选择铸造道具
  _setMiner(name) {
    if (isMinting) return;
    setState(() {
      if (miner != name) {
        miner = name;
        switch(name) {
          case 'Rocket': minerCost = 1000*rocketSuccessCount; break;
          case 'Booster': minerCost = 2000; break;
          case 'NFTs': minerCost = 10000; break;
        }
      } else {
        // miner = '';
        // minerCost = 0;
      }
    });
  }

  // 开始铸造
  _goMinting() {
    if (isMinting) return;
    // 余额不足
    if (minerCost > goldBalance) {
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
                child: Text('Insufficient Balance', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              )
            )
          ],
        )
      );
      return;
    }
    setState(() {
      isMinting = true;
      // 控制结束落点
      switch(miner) {
        case 'Rocket': mintEndIndex = 0; break;
        case 'Booster': mintEndIndex = 5; break;
        case 'NFTs': mintEndIndex = [1, 2, 3, 4, 6, 7][Random().nextInt(6)]; break;
      }
    });
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        // 轮盘动画index映射
        if (mintIndex < 7) {
          mintIndex++;
        } else {
          mintIndex = 0;
          mintRound++;
        }
        if (mintRound > 3 && mintIndex == mintEndIndex) {
          isMinting = false;
          mintRound = 0;
          timer.cancel();

          if (miner == 'NFTs') {
            setState(() {
              nftIndex = Random().nextInt(13);
            });
          }
          showDialog(// 传入 context
            context: context,
            useSafeArea: false,
            // 构建 Dialog 的视图
            builder: (_) => minerDialog(context)
          );
        }
      });
    });
  }

  // 领取铸造道具
  onClaimItem() {
    Global.decreaseGold(minerCost);
    if (miner == 'Rocket') {
      Global.receiveRocket();
      setState(() {
        minerCost = 1000*rocketSuccessCount;
      });
    } else if (miner == 'Booster') {
      Global.receiveBooster();
    } else if (miner == 'NFTs') {
      Global.receiveNFT(nfts[nftIndex]);
    }
    Navigator.pop(context); // 关闭弹窗
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
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
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
                  bottom: MediaQuery.of(context).size.width / 13,
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 0 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 1 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 2 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 7 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset('assets/images/item/turn_value.png', width: MediaQuery.of(context).size.width / 4.5),
                              Positioned(
                                top: 20,
                                child: Text('Est. Cost', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8), fontSize: 14),),
                              ),
                              Positioned(
                                top: 38,
                                child: Row(
                                  children: [
                                    Image.asset('assets/icons/icon_coin.png', width: 30,),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, left: 2),
                                      child: Text('$minerCost', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 3 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 6 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 5 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
                              Image.asset('assets/images/item/bot_item.png', width: MediaQuery.of(context).size.width / 4.5),
                              mintIndex == 4 ? Image.asset('assets/images/item/bot_active.png', width: MediaQuery.of(context).size.width / 4.5) : Container(),
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
          Spacer(),
          // Text('$goldBalance', style: TextStyle(color: Colors.white, fontSize: 10)),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  _setMiner('Rocket');
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 90) / 3,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: miner == 'Rocket' ? Color.fromRGBO(112, 21, 239, 0.15) : Color.fromRGBO(22, 22, 26, 1),
                    border: Border.all(color: miner == 'Rocket' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_rocket.png', width: 34),
                      SizedBox(width: 4),
                      Text('Rocket', style: TextStyle(color: Colors.white, fontSize: 12))
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              InkWell(
                onTap: () {
                  _setMiner('Booster');
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 90) / 3,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: miner == 'Booster' ? Color.fromRGBO(112, 21, 239, 0.15) : Color.fromRGBO(22, 22, 26, 1),
                    border: Border.all(color: miner == 'Booster' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_alarm.png', width: 34),
                      SizedBox(width: 4),
                      Text('Booster', style: TextStyle(color: Colors.white, fontSize: 12))
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              InkWell(
                onTap: () {
                  _setMiner('NFTs');
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 90) / 3,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: miner == 'NFTs' ? Color.fromRGBO(112, 21, 239, 0.15) : Color.fromRGBO(22, 22, 26, 1),
                    border: Border.all(color: miner == 'NFTs' ? Color.fromRGBO(112, 21, 239, 1) : Colors.transparent),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_NFT.png', width: 34),
                      SizedBox(width: 4),
                      Text('NFTs', style: TextStyle(color: Colors.white, fontSize: 12))
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 86,
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                overlayColor: isMinting ? Colors.transparent : Colors.black,
                // foregroundColor: Colors.white,
                backgroundColor: isMinting ? Color.fromRGBO(112, 21, 239, 0.3) : Color.fromRGBO(112, 21, 239, 1),
                // disabledForegroundColor: Color.fromRGBO(249, 249, 249, 0.2),
                disabledBackgroundColor: Color.fromRGBO(35, 36, 41, 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  // 铸造成功弹窗
  Widget minerDialog(context) {
    final imgs = {
      'Rocket': 'assets/icons/icon_rocket.png',
      'Booster': 'assets/icons/icon_alarm.png',
      'NFTs': 'assets/icons/icon_NFT.png',
    };
    return Stack(
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('You’ve Unlocked a Mystery Item!', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.8)),),
                  Container(
                    width: 160,
                    height: 144,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(35, 36, 41, 1),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: miner == 'NFTs' ? 
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset(nfts[nftIndex], fit: BoxFit.cover)
                      ) : 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(imgs[miner]!, width: 50),
                          Text(miner == 'Rocket' ? 'Miner' : 'Booster', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(miner == 'Rocket' ? '$rocketEff Gh/s' : '2h', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)
                        ],
                      ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.white,
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: onClaimItem,
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
            onPressed: onClaimItem,
            child: Image.asset('assets/icons/icon_close.png', width: 40)
          )
        )
      ],
    );
  }
}