
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/loading/loading_page.dart';
import 'package:eqinsurance/page/partner/controller/partner_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/icon_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PartnerPage extends GetView<PartnerController>{
  const PartnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageResource.bg),
                    fit: BoxFit.fill
                )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: controller.heightAppbar.heightTop),
                Container(
                    width: double.maxFinite,
                    height: controller.heightAppbar.heightBody,
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
                            width: 22,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(ImageResource.ic_back, width: 12),
                          ),
                        ),
                        SizedBox(width: 64),
                        Spacer(flex: 1),
                        Text("EQ Insurance", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 19, color: ColorResource.color_content_popup, fontWeight: FontWeight.bold)),
                        Spacer(flex: 1),
                        Container(
                          margin: EdgeInsets.only(bottom: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                                onTap: (){
                                  controller.getContactInfo();
                                },
                              ),
                              SizedBox(width: 8),
                              IconNotificationWidget(
                                onTap: (){
                                  controller.goToNotification();
                                },
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                child: Image.asset(ImageResource.home2, height: 18, fit: BoxFit.fitHeight,),
                                onTap: (){
                                  controller.reloadHome();
                                },
                              ),
                            ],
                          ),
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
                    navigationDelegate: (NavigationRequest request) {
                      if(controller.checkNavigatorLink(request.url)){
                        return NavigationDecision.navigate;
                      }
                      controller.onCheckLink(request.url);
                      return NavigationDecision.prevent;
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                    },
                    onPageStarted: (String url) {
                      controller.isLoading.value = true;
                      print('Page started loading: $url');
                      NavigationDecision.navigate;
                      controller.onCheckLink(url);
                    },
                    onPageFinished: (String url) {
                      controller.isLoading.value = false;
                      print('Page finished loading: $url');
                    },

                    gestureNavigationEnabled: true,
                    backgroundColor: const Color(0x00000000),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => LoadingPage(isLoading: controller.isLoading.value))
        ],
      ),
    );
  }

}