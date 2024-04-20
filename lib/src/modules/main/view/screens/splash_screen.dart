import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const SplashScreen({super.key, required this.nextScreen});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      curve: Curves.bounceOut,
      duration: 3000,
      splashTransition: SplashTransition.sizeTransition,
      splashIconSize: 170.sp,
      function: () async {
        Future.delayed(const Duration(seconds: 2));
      },
      splash: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/logo.png'))),
      ),
      nextScreen: widget.nextScreen,
      animationDuration: const Duration(milliseconds: 2700),
    );
  }
}
