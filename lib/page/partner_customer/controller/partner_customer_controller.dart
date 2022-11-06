
import 'dart:io';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/partner_customer/models/login_hp_number_req.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class PartnerCustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerCustomerController());
  }

}

class PartnerCustomerController extends GetxController{

  ApiProvider apiProvider = ApiProvider();
  TextEditingController phoneText = TextEditingController();

  String countryCode = "65";

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onSubmitCheckPhone() async {

    String hpNumber = phoneText.text.trim().toString();

    LoginHpNumberReq loginReq = LoginHpNumberReq();
    loginReq.sUserName = ConfigData.CONSUMER_KEY;
    loginReq.sPassword = ConfigData.CONSUMER_SECRET;
    loginReq.sHpNumber = hpNumber;


    var response = await apiProvider.fetchData(ApiName.CheckHpNumber, loginReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(CheckError.isSuccess(data)){
        doWhenSuccess(data, hpNumber);
      }else{
        showErrorMessage("Cannot get AgentCode!");
      }
    }
  }

  Future<void> doWhenSuccess(String response, String phone) async {
    var separateResult = response.split("\\|");
    final String _AgentCode = separateResult[0];
    final String URL = separateResult[1];

    String currentUserType = await SharedConfigName.getCurrentUserType();
    if(currentUserType != ConfigData.PROMO){
      SharedConfigName.clearUserNotificationCache();
    }

    SharedConfigName.setAgentCode(_AgentCode);
    SharedConfigName.setPhone(phone);
    SharedConfigName.setRegisteredUserType("PROMO");

    Get.offAndToNamed(GetListPages.PARTNER, arguments: {'link', URL});

  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }
}