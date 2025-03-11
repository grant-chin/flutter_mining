import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Container(
        height: window.physicalSize.height / window.devicePixelRatio,
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: new BoxDecoration(color: Color(0xff0F0F12)),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 48,
                    width: 48,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Image.asset('assets/images/avator/lion.jpeg', fit: BoxFit.cover,),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Liam xaffizme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color.fromRGBO(112, 21, 239, 0.4), Color.fromRGBO(92, 81, 255, 0.4)]
                            )
                          ),
                          child: Text('Lvl $_counter', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('0/120', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
