import 'dart:async';
import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PartnerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerController());
  }

}

class PartnerController extends GetxController{
  final Completer<WebViewController> webViewController = Completer<WebViewController>();

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
}