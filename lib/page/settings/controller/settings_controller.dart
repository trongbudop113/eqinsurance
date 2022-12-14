import 'package:eqinsurance/configs/config_button.dart';
import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/settings/models/notification_item_count.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }

}

class SettingsController extends GetxController{

  ApiProvider apiProvider = ApiProvider();

  final RxBool isLoading = false.obs;

  Future<void> onClickYes() async {
    isLoading.value = true;
    await getNotificationItemCount();
    SharedConfigName.logoutUser();
    SharedConfigName.setRegisteredUserType('');
    await ConfigButton.singleton.showHideButton();
    isLoading.value = false;
    Get.back(result: true);
  }

  void onCLickNo(){
    Get.back(result: false);
  }

  Future<void> getNotificationItemCount() async {
    try{
      NotificationItemCountReq notificationItemCountReq = NotificationItemCountReq();
      notificationItemCountReq.sUserName = ConfigData.CONSUMER_KEY;
      notificationItemCountReq.sPassword = ConfigData.CONSUMER_SECRET;


      var response = await apiProvider.fetchData(ApiName.NotificationItemCount, notificationItemCountReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String res = root.children[2].children.first.toString();
        int? number = int.tryParse(res);
        SharedConfigName.setNotificationsPerPage(number ?? 0);
      }else{
        showErrorMessage("Cannot get NotificationItemCount!");
      }
    }catch(e){
      isLoading.value = false;
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

}