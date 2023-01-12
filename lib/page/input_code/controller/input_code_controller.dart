import 'dart:io';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/hide_keyboard.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
import 'package:eqinsurance/page/register/models/login_req.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class InputCodeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => InputCodeController());
  }

}

class InputCodeController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();
  TextEditingController scText = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isDisable = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
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

  Future<void> onSubmitLoginAgentCode() async {
    showLoading();
    try{
      String userID = await SharedConfigName.getUserID();
      String pin = scText.text.trim().toString();

      if(pin.isEmpty){
        showErrorMessage("Please enter Security Code");
      }else{
        Login1Req loginReq = Login1Req();
        loginReq.sUserName = ConfigData.CONSUMER_KEY;
        loginReq.sPassword = ConfigData.CONSUMER_SECRET;
        loginReq.sUserID = userID;
        loginReq.sPin = pin;

        loginReq.sManufacturer = "";
        loginReq.sModel = "";
        loginReq.sOsName = "";
        loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


        var response = await apiProvider.fetchData(ApiName.LoginWithSecurityCode, loginReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          String data = root.children[2].children.first.toString();
          print("data1....." + data.toString());

          if(CheckError.isSuccess(data)){
            var newLink = data.replaceAll("amp;", "");
            doWhenLoginSuccess(newLink);
          }else{
            showErrorMessage("Cannot login. Security Code is wrong!");
          }
          //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot login. Security Code is wrong!");
    }
  }

  void doWhenLoginSuccess(String data){
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"link" : data});
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

}