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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showLoading(){
    isLoading.value = true;
  }

  void hideLoading(){
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

        loginReq.sManufacturer = null;
        loginReq.sModel = null;
        loginReq.sOsName = null;
        loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


        var response = await apiProvider.fetchData(ApiName.LoginWithSecurityCode, loginReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenLoginSuccess(data);
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
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"res" : data});
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

}