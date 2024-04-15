import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Beat Blend",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: Colors.red, // Customize the underline color
            decorationStyle: TextDecorationStyle.double, // Customize the underline style
            fontSize: 24.0, // Customize the font size
            fontFamily: 'Roboto', // Customize the font family
            color: Colors.blue, // Customize the text color
          ),
        )
        ,
      ),
    );
  }
}