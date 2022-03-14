import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configers/images_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/web_view_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OpacityAnimatedWidget.tween(
        opacityEnabled: 1, //define start value
        opacityDisabled: 0, //and end value
        enabled: true,
        curve: Curves.linear,
        duration: const Duration(seconds: 3),
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(logoImage), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
