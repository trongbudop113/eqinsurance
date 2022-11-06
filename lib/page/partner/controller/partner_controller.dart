import 'dart:async';
import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/webview/model/get_contact_req.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

class PartnerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerController());
  }

}

class PartnerController extends GetxController{
  final Completer<WebViewController> webViewController = Completer<WebViewController>();

  ApiProvider apiProvider = ApiProvider();

  String url = "";

  @override
  void onInit() {
    getIntentParam();
    super.onInit();
  }

  Future<void> getContactInfo() async {
    GetContactReq getContactReq = GetContactReq();
    getContactReq.sUserName = ConfigData.CONSUMER_KEY;
    getContactReq.sPassword = ConfigData.CONSUMER_SECRET;
    getContactReq.sType = ConfigData.PUBLIC;
    getContactReq.sHpNumber = "65 9468 7687";


    var response = await apiProvider.fetchData(ApiName.ContactUs, getContactReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
    }
  }

  void getIntentParam(){
    var data = Get.arguments;
    url = data['link'].toString();
  }

  Future<void> reloadHome() async {
    var web = await webViewController.future;
    await web.loadUrl(url);
  }
}