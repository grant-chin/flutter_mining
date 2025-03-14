import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			body: Column(
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
          // Text('data', style: TextStyle(color: Colors.white),)
        ],
      ),
		);
	}
}