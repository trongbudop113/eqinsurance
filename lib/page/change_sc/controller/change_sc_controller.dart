import 'dart:io';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/change_sc/models/change_sc_req.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
import 'package:eqinsurance/page/register/models/login_req.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class ChangeSCBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeSCController());
  }

}

class ChangeSCController extends GetxController{

  ApiProvider apiProvider = ApiProvider();

  TextEditingController currentScText = TextEditingController();
  TextEditingController newScText = TextEditingController();
  TextEditingController confirmScText = TextEditingController();

  Future<void> onSubmitChangeSC() async {

    String userID = await SharedConfigName.getUserID();

    var currentSc = currentScText.text.trim().toString();
    var newSc = newScText.text.trim().toString();
    var confirmSc = confirmScText.text.trim().toString();
    final regexp = RegExp(r'^[0-9]*\$');

    if(currentSc.isEmpty || newSc.isEmpty || confirmSc.isEmpty){
      showErrorMessage("Please enter all security codes.");
    }else if(!regexp.hasMatch(currentSc) || !regexp.hasMatch(newSc) || !regexp.hasMatch(confirmSc) ||
        currentSc.length != 6 || newSc.length !=6 || confirmSc.length !=6){
      showErrorMessage("Security Code must contain 6 digits.");
    }else if(newSc != confirmSc){
      showErrorMessage("New Security Code does not match the Confirm Security Code.");
    }else{
      ChangeSCReq changeSCReq = ChangeSCReq();
      changeSCReq.sUserName = ConfigData.CONSUMER_KEY;
      changeSCReq.sPassword = ConfigData.CONSUMER_SECRET;
      changeSCReq.sUserID = userID;
      changeSCReq.sOldPin = currentSc;
      changeSCReq.sNewPin = newSc;


      var response = await apiProvider.fetchData(ApiName.ChangePin, changeSCReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          onSubmitLogin(newSc);
        }else{
          showErrorMessage("Old Security Code is wrong!");
        }
        //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
      }
    }

  }

  Future<void> onSubmitLogin(String sc) async {

    String userID = await SharedConfigName.getUserID();

    Login1Req loginReq = Login1Req();
    loginReq.sUserName = ConfigData.CONSUMER_KEY;
    loginReq.sPassword = ConfigData.CONSUMER_SECRET;
    loginReq.sUserID = userID;
    loginReq.sPin = sc;

    // loginReq.sManufacturer = scText.text.trim();
    // loginReq.sOsVersion = scText.text.trim();
    // loginReq.sModel = scText.text.trim();
    loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


    var response = await apiProvider.fetchData(ApiName.LoginWithSecurityCode, loginReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(CheckError.isSuccess(data)){
        Get.offAndToNamed(GetListPages.PARTNER, arguments: {"link" : data});
      }else{
        showErrorMessage("Cannot login. Please contact website admin!");
      }
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

}