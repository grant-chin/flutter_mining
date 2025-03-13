import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, kToolbarHeight + 12, 0, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/icon_back.png', width: 24,),
                        SizedBox(width: 16),
                        Text('Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Image.asset('assets/icons/icon_setting.png', width: 24)
                      ],
                    ),
                  ),
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
                ],
              ),
            ),
          )
        ],
			),
		);
	}
}