import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }

}

class ContactUsController extends GetxController{

  final Completer<WebViewController> webViewController = Completer<WebViewController>();

  String url = "";

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    getIntentParam();
  }

  void getIntentParam(){
    var data = Get.arguments;
    url = data['link'].toString();
  }

}