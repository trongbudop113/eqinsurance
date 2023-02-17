import 'dart:convert';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/network/aes_encrypt.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
import 'package:eqinsurance/page/webview/models/notification_detail_req.dart';
import 'package:eqinsurance/page/webview/models/update_device_req.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:eqinsurance/widgets/dialog/portal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class AuthenticationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }

}

class AuthenticationController extends GetxController{

  final RxBool isShowView = true.obs;
  ApiProvider apiProvider = ApiProvider();

  final RxString textAuthenticated = "Authenticated".obs;
  final RxString imageApproved = ImageResource.ic_complete.obs;

  String authenticateKey = "";

  final String callBackLinkMode = 'https://internet.eqinsurance.com.sg/test/SRServer/Login.aspx?key=';
  //String callBackLinkMode = 'https://internet.eqinsurance.com.sg/eqwap/SRServer/Login.aspx?key=';

  String fireBaseKey = "", requestTokenUrl = "", completeTokenUrl = "", apiUsername = "", apiKey = "";

  final RxBool isLoading = false.obs;
  bool isAuthorized = false;

  @override
  void onInit() {
    super.onInit();
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    String userId =  await SharedConfigName.getUserID();
    String token =  await SharedConfigName.getTokenFirebase();
    if (userId != '' && !userId.isEmpty){
      requestToGetAPIInfo(token);
    }
  }

  Future<void> requestToGetAPIInfo(String token) async {
    isLoading.value = true;
    try{
      GetAPIInfoReq getAPIInfoReq = GetAPIInfoReq();
      getAPIInfoReq.sUserName = ConfigData.CONSUMER_KEY;
      getAPIInfoReq.sPassword = ConfigData.CONSUMER_SECRET;
      getAPIInfoReq.sEnvironment = ConfigData.EVR_CODE;

      var response = await apiProvider.fetchData(ApiName.GetNotificationDetails, getAPIInfoReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          var temValues = data.split("\|");

          fireBaseKey = temValues[0];
          requestTokenUrl = temValues[1];
          completeTokenUrl = temValues[2];
          apiUsername = temValues[3];
          apiKey = temValues[4];
          if(token != ""){
            getInstanceToken(token);
          }

          print("data....." + requestTokenUrl + "...." + fireBaseKey);
        }else{
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;

    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  void getInstanceToken(String token){
    String input = apiUsername + "|" + token;
    String requestKey = AesHelper.encryptString(input, apiKey);
    requestToUpdateDeviceAPI(requestKey);
  }

  Future<void> requestToUpdateDeviceAPI(String requestKey) async {
    try{
      final String requestKeyCopy = requestKey;
      String reQuestUrl = requestTokenUrl.substring(0, requestTokenUrl.indexOf("/RequestToken"));

      String userID = await SharedConfigName.getUserID();
      UpdateDeviceReq updateDeviceReq = UpdateDeviceReq();
      updateDeviceReq.ClientId = apiUsername;
      updateDeviceReq.RequestKey = requestKeyCopy;
      updateDeviceReq.Username = userID;

      var response = await apiProvider.fetchDataUpdateDevice(reQuestUrl + "/UpdateUserDevice", updateDeviceReq);
      if(response != null){
        try{
          var jsonObject = jsonDecode(response);
          if(jsonObject != null){
            var key = jsonObject['authenticatekey'] ?? '';
            if(key != ""){
              showHideApproveArea(true);
              authenticateKey = key;
            }
          }else{
            showHideApproveArea(false);
            imageApproved.value = ImageResource.ic_warning_yellow;
            textAuthenticated.value = "Please try again.";
          }
        }catch(e){
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  Future<void> requestToApprove() async {
    isLoading.value = true;
    try{
      String reQuestUrl = requestTokenUrl.substring(0, requestTokenUrl.indexOf("/RequestToken"));

      ApproveReq approveReq = ApproveReq();
      approveReq.RequestToken = authenticateKey;

      var response = await apiProvider.fetchDataUpdateDevice(reQuestUrl + "/ApproveToken", approveReq);
      if(response != null){

        try{
          var jsonObject = jsonDecode(response);
          if(jsonObject != null){
            String status = jsonObject["status"].toString();
            if (status != '' && status != 'null' && status == '1') {
              showHideApproveArea(false);
              isAuthorized = true;
              await callBackApi(true, requestToken: authenticateKey);
              showAuthenticationPortal();
            } else if (status != "" && status == "2") {
              showHideApproveArea(false);
              showErrorMessage("Your requested token was expired");
            }
            else {
              showHideApproveArea(true);
              showErrorMessage("Approve failed. Please try again");
            }
          }else{
            showHideApproveArea(false);
            imageApproved.value = ImageResource.ic_warning_yellow;
            textAuthenticated.value = "Please try again.";
          }
        }catch(e){
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;

    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  Future<void> requestToReject() async {
    isLoading.value = true;
    try{
      String reQuestUrl = requestTokenUrl.substring(0, requestTokenUrl.indexOf("/RequestToken"));

      ApproveReq approveReq = ApproveReq();
      approveReq.RequestToken = authenticateKey;

      var response = await apiProvider.fetchDataUpdateDevice(reQuestUrl + "/RejectToken", approveReq);
      if(response != null){
        try{
          var jsonObject = jsonDecode(response);
          if(jsonObject != null){
            String status = jsonObject["status"].toString();
            if (status != '' && status != 'null' && status == '1') {
              showHideApproveArea(false);
              imageApproved.value = ImageResource.ic_warning_yellow;
              textAuthenticated.value = "Rejected";
              callBackApi(false, requestToken: authenticateKey);
            }else{
              showHideApproveArea(true);
              showErrorMessage('"Reject failed. Please try again"');
            }
          }else{
            showHideApproveArea(false);
            imageApproved.value = ImageResource.ic_warning_yellow;
            textAuthenticated.value = "Please try again.";
          }
        }catch(e){
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;

    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  void showHideApproveArea(bool show) {
    if (show){
      isShowView.value = true;
    } else {
      isShowView.value = false;
    }
  }

  Future<void> callBackApi(bool isApprove, {required String requestToken}) async {
    try {
      if(isApprove){
        await apiProvider.getCallBack(callBackLinkMode + requestToken);
      }else{
        await apiProvider.getCallBack(callBackLinkMode + requestToken + "&r=1");
      }
    }catch (e) {
      print(e);
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  Future<void> showAuthenticationPortal() async {
    await showDialog(
      context: Get.context!,
      builder: (_) => PortalDialog(authenticationController: this),
    );
    Get.back();
  }

}