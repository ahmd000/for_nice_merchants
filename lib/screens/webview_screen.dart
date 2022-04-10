import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_nice_merchants/helpers/helpers.dart';
import 'package:for_nice_merchants/widgets/text_app.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../configers/images_config.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> with Helpers {
  late WebViewController controller;
  bool isLoading = true;
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final differences = DateTime.now().difference(timeBackPressed);
        final isExitWarning = differences >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }

          const msg = "يرجي الضغط مرة اخري للخروج من التطبيق !";
          print(msg);
          showSnackBar(context: context, message: msg, error: false);
          return false;
        } else {
          print("مع السلامة ");
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              isLoading == false
                  ? Container()
                  : const Center(
                child: CircularProgressIndicator(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16.sp,
                ),
                child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: main_page,
                    onPageStarted: (s) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onPageFinished: (f) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onWebViewCreated: (controller) {
                      this.controller = controller;
                    },
                    zoomEnabled: true,
                    initialMediaPlaybackPolicy:
                        AutoMediaPlaybackPolicy.always_allow,
                    allowsInlineMediaPlayback: true,
                    debuggingEnabled: false,
                    gestureNavigationEnabled: true,
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith("https://wa.me/")) {
                        print(request.url);
                        launch(request.url);
                        return NavigationDecision.prevent;
                      } else if (request.url.contains("twitter")) {
                        launch(request.url);
                        return NavigationDecision.prevent;
                      } else if (request.url.contains("instagram")) {
                        launch(request.url);
                        return NavigationDecision.prevent;
                      } else if (request.url.contains("snapchat")) {
                        launch(request.url);
                        return NavigationDecision.prevent;
                      } else {
                        return NavigationDecision.navigate;
                      }
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
