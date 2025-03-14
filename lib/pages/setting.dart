import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			body: Stack(
        alignment: Alignment.topCenter,
        children: [
          AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: false,
            title: Text('Settings', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ))
          ),
          Positioned(
            top: kToolbarHeight + 56,
            child: Column(
              children: [
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      overlayColor: Colors.white,
                      shadowColor: Colors.transparent,
                      elevation: 0, // 阴影
                      backgroundColor: Colors.transparent,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Policy privacy', style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        )),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                    onPressed: () {}
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      overlayColor: Colors.white,
                      shadowColor: Colors.transparent,
                      elevation: 0, // 阴影
                      backgroundColor: Colors.transparent,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Terms of service', style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        )),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                    onPressed: () {}
                  ),
                ),
              ],
            )
          ),
          Positioned(
            bottom: kBottomNavigationBarHeight,
            child: Text('v 1.0.1', style: TextStyle(color: Color.fromRGBO(249, 249, 249, 0.2), fontSize: 18, fontWeight: FontWeight.bold),)
          )
        ],
      ),
		);
	}
}