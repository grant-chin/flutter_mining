import 'package:flutter/material.dart';
import 'dart:ui';


class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: window.physicalSize.height / window.devicePixelRatio,
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
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 96) / 3,
                  margin: EdgeInsets.only(left: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(22, 22, 26, 1),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/item/icon_rocket.png', width: 40),
                      Text('Miner', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 96) / 3,
                  margin: EdgeInsets.only(left: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(22, 22, 26, 1),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/item/icon_alarm.png', width: 40),
                      Text('Booster', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 96) / 3,
                  margin: EdgeInsets.only(left: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(22, 22, 26, 1),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/item/icon_NFT.png', width: 40),
                      Text('NFTs', style: TextStyle(color: Colors.white))
                    ],
                  ),
                )
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
                backgroundColor: Color.fromRGBO(112, 21, 239, 1),
                overlayColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text('Mint', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {}
            ),
          )
        ],
      )
    );
  }
}
