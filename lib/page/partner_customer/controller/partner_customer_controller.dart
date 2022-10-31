import 'dart:async';
import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PartnerCustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerCustomerController());
  }

}

class PartnerCustomerController extends GetxController{

  @override
  void onInit() {
    super.onInit();
  }
}