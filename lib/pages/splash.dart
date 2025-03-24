import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        child: Image(image: AssetImage('assets/images/splash.png'), fit: BoxFit.fill,),
      );
    });
  }
}
