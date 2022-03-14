import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_nice_merchants/screens/splash_screen.dart';

import 'screens/webview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (context, widget) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: widget!,
              );
            },
            initialRoute: '/splash_screen',
            routes: {
              '/splash_screen': (context) => const SplashScreen(),
              '/web_view_screen': (context) => const WebViewScreen(),
            },
          );
        });
  }
}
