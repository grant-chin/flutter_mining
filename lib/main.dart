import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lexend',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        "/": (context) => MyHomePage(),
        'profile': (context) => ProfileView(),
        'setting': (context) => SettingView(),
      },
      initialRoute: '/',
      // home: const MyHomePage(),
    );
  }
}