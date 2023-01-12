
import 'dart:io';

import 'package:eqinsurance/configs/config_button.dart';
import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/device_info_config.dart';
import 'package:eqinsurance/configs/hide_keyboard.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/notification/models/notification_req.dart';
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

class PartnerCustomerController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();
  TextEditingController phoneText = TextEditingController();

  String countryCode = "65";

  final RxBool isLoading = false.obs;
  final RxBool isDisable = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showLoading(){
    isDisable.value = true;
    isLoading.value = true;
  }

  void hideLoading(){
    isDisable.value = false;
    isLoading.value = false;
  }

  Future<void> onSubmitCheckPhone() async {
    showLoading();
    if(countryCode.isEmpty || phoneText.text.trim().isEmpty){
      showErrorMessage("Please enter your mobile number and country code.");
    }
    try{
      String hpNumber = countryCode + phoneText.text.trim().toString();

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
          showErrorMessage("Cannot verify your mobile number!");
        }
      }
      hideLoading();;
    }catch(e){
      hideLoading();;
      showErrorMessage("Cannot verify your mobile number!");
    }
  }

  Future<void> doWhenSuccess(String response, String phone) async {
    var separateResult = response.split("\|");
    final String _AgentCode = separateResult[0];
    final String URL = separateResult[1];
    var newLink = URL.replaceAll("amp;", "");

    String currentUserType = await SharedConfigName.getCurrentUserType();
    if(currentUserType != ConfigData.PROMO){
      SharedConfigName.clearUserNotificationCache();
    }

    refreshNotificationCount();
    SharedConfigName.setAgentCode(_AgentCode);
    SharedConfigName.setPhone(phone);
    SharedConfigName.setRegisteredUserType("PROMO");
    ConfigButton.singleton.showHideButton();
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {'link', newLink});

  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  Future<void> refreshNotificationCount() async {
    showLoading();
    try {
      String agentCode = await SharedConfigName.getAgentCode();
      String userType = await SharedConfigName.getCurrentUserType();

      GetNotificationReq getNotificationReq = GetNotificationReq();
      getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
      getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
      getNotificationReq.sType = userType;
      getNotificationReq.sAgentCode = agentCode;

      var response = await apiProvider.fetchData(
          ApiName.NotificationCount, getNotificationReq);
      if (response != null) {
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if (CheckError.isSuccess(data)) {
          if (data != "" && data != "0" && data != 0) {
            int apiCount = int.tryParse(data) ?? 0;
            List<String> readAndDeletedNotificationIDs =
            await SharedConfigName.getUserReadNotificationIDs();
            var listDataDeleted =
            await SharedConfigName.getUserDeletedNotificationIDs();
            for (var element in listDataDeleted) {
              if (!readAndDeletedNotificationIDs.contains(element))
                readAndDeletedNotificationIDs.add(element);
            }

            //String jsonText = jsonEncode(readAndDeletedNotificationIDs);

            int localCacheCount = readAndDeletedNotificationIDs.length;
            int totalCount = apiCount - localCacheCount;

            if (totalCount > 0) {
              DeviceInfoConfig.singleton.countNotification.value = totalCount;
            } else {
              DeviceInfoConfig.singleton.countNotification.value = 0;
            }
          }
        }
      }

      hideLoading();;
    } catch (e) {
      hideLoading();;
    }
  }
}