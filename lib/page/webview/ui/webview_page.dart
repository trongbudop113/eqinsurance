
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/webview/controller/webview_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetView<WebViewAppController>{
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage(ImageResource.bg),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 25),
            Container(
                width: double.maxFinite,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(ImageResource.ic_back, width: 12),
                      ),
                    ),
                    SizedBox(width: 64),
                    Spacer(flex: 1),
                    Text("EQ Insurance", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 18)),
                    Spacer(flex: 1),
                    GestureDetector(
                      child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                      onTap: (){
                        controller.getContactInfo();
                        //Get.toNamed(GetListPages.CONTACT_US);
                      },
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      child: Image.asset(ImageResource.ic_notifications, width: 20, height: 20),
                      onTap: (){
                        Get.toNamed(GetListPages.NOTIFICATION);
                      },
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      child: Image.asset(ImageResource.home2, height: 18, fit: BoxFit.fitHeight,),
                      onTap: (){
                        controller.reloadHome();
                      },
                    ),
                    SizedBox(width: 15),
                  ],
                )
            ),
            Expanded(
              child: WebView(
                initialUrl: controller.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller.webViewController.complete(webViewController);
                },
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },

                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              ),
            ),
          ],
        ),
      ),
    );
  }

}