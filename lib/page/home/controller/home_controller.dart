import 'dart:convert';

import 'package:eqinsurance/configs/config_button.dart';
import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/device_info_config.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/home/models/GetPartnerCustomerReq.dart';
import 'package:eqinsurance/page/home/models/get_public_user_req.dart';
import 'package:eqinsurance/page/notification/models/notification_req.dart';
import 'package:eqinsurance/page/notification/models/notification_res.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
import 'package:eqinsurance/page/webview/model/get_contact_req.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:eqinsurance/widgets/dialog/home_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  ApiProvider apiProvider = ApiProvider();

  final HeightAppbar heightAppbar = DeviceInfoConfig.singleton.heightAppbar;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    ConfigButton.singleton.showHideButton();
    refreshNotificationCount();
    openPopupNotification();
  }

  @override
  void onReady() {
    super.onReady();
    print("onReady :...");
    initFirebaseMessage();
    initDataFromBackgroundApp();
    // print("start encrypt.....");
    // var text = 'mobileapi|cauugf6ORCafNuvfhBNxLg:APA91bGWk7S0Z1we_YrKm9Hc-FVG04230kodgyuQftmKL7mf4Stwt-hypkYzSzJH19emDxnKdEQN1IclTyCfGCWAN--5qasNLr3Dxski9IcEt3WXLmN2heDG1BWZboD_Vphq3Jx7f_TG';
    // String key = "28103264-9141-4540-a55b-c4ec6596ee2d"; //
    // String test2 = AesHelper.encryptString(text,key);
    // print("encrpyted 2....." + test2);
    // String test3 = AesHelper.decryptString("fmoY5Setq7hJyBNnous+v/5kbU3cHSyQzFigAGOa4zxS6iux2mpUBT6GMwsZU+F0aNtt3u5ngxl7yN28MRo3zjneVkQ3iPBXZfe4KGQyoQxR/r8isolBsigA5ZK+EAuJJWJLjeMAIqaSz6p0Y+MwSmxgARIRfmgjou15A4xDEFro3UkKRySA040NWQRdLuoZbbXYQP0gaCaDc9ItzW0oCT+l2vM2RNGmbQty0zylW0w=", key);
    // print("decrpyted 2....." + test3);
    // print("end encrypt.....");
  }

  void initDataFromBackgroundApp(){
    try{
      bool isShow = Get.arguments;
      print("isShow......$isShow");
      if(isShow){
        Get.toNamed(GetListPages.AUTHENTICATION);
      }
    }catch(e){

    }
  }

  Future<void> initFirebaseMessage() async {
    print("initFirebaseMessage....");

    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    //FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
      Get.toNamed(GetListPages.AUTHENTICATION);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
      Get.toNamed(GetListPages.AUTHENTICATION);
    });
  }

  Future<void> goToSetting() async {
    var isUpdate = await Get.toNamed(GetListPages.SETTINGS);
    if(isUpdate ?? false){
      refreshNotificationCount();
    }
  }

  Future<void> goToNotification() async {
    var isUpdate = await Get.toNamed(GetListPages.NOTIFICATION);
    if(isUpdate ?? false){
      refreshNotificationCount();
    }
  }


  Future<void> openPopupNotification() async {
    try {
      GetNotificationReq getNotificationReq = GetNotificationReq();
      getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
      getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
      getNotificationReq.sType = "POPUP";
      getNotificationReq.sAgentCode = "";

      var response =
      await apiProvider.fetchData(ApiName.Notification, getNotificationReq);
      if (response != null) {
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String jsonString = root.children[2].children.first.toString();
        if (CheckError.isSuccess(jsonString)) {
          if (jsonString != '' && jsonString != '0' && jsonString != 0) {
            NotificationDataRes notificationDataRes =
            NotificationDataRes.fromJson(jsonDecode(jsonString));
            print("data....." + notificationDataRes.data!.length.toString());
            showHomeDialog(notificationDataRes.data![0]);
          }
        }
      }
    } catch (e) {}
  }

  Future<void> getContactInfo() async {
    try {
      isLoading.value = true;
      final String _Type = await SharedConfigName.getCurrentUserType();
      String _HpNumberTemp = "";
      if (_Type == ConfigData.PROMO) {
        _HpNumberTemp = await SharedConfigName.getPhone();
      }
      final String _HpNumber = _HpNumberTemp;

      GetContactReq getContactReq = GetContactReq();
      getContactReq.sUserName = ConfigData.CONSUMER_KEY;
      getContactReq.sPassword = ConfigData.CONSUMER_SECRET;
      getContactReq.sType = ConfigData.PUBLIC;
      getContactReq.sHpNumber = _HpNumber;

      var response =
      await apiProvider.fetchData(ApiName.ContactUs, getContactReq);
      if (response != null) {
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String link = root.children[2].children.first.toString();
        Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
      } else {
        showErrorMessage("Can not load contact, please try again!");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showErrorMessage("Can not load contact, please try again!");
    }
  }

  Future<void> getPublicUser() async {
    isLoading.value = true;
    try {
      GetPublicUserReq getPublicUserReq = GetPublicUserReq();
      getPublicUserReq.sUserName = ConfigData.CONSUMER_KEY;
      getPublicUserReq.sPassword = ConfigData.CONSUMER_SECRET;

      var response =
      await apiProvider.fetchData(ApiName.PublicLink, getPublicUserReq);
      if (response != null) {
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String link = root.children[2].children.first.toString();
        var newLink = link.replaceAll("amp;", "");
        Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": newLink});
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showErrorMessage("Error, Please try again");
    }
    //Get.toNamed(GetListPages.AUTHENTICATION);
  }

  void goToPartnerCustomer() {
    if (SharedConfigName.getCurrentUserType == ConfigData.PROMO &&
        SharedConfigName.getPhone != '') {
      showPartnerCustomerWebsite();
    } else {
      Get.toNamed(GetListPages.PARTNER_CUSTOMER);
    }

    // SharedConfigName.setRegisteredUserType("AGENT");
    // ConfigButton.singleton.showHideButton();
    // print('eeeeee');
  }

  Future<void> goToPartnerPage() async {
    bool isSet = await SharedConfigName.isSetSC();
    if (isSet) {
      Get.toNamed(GetListPages.INPUT_CODE);
    } else {
      Get.toNamed(GetListPages.REGISTER);
    }
  }

  Future<void> showPartnerCustomerWebsite() async {
    isLoading.value = true;
    try {
      String vPhone = await SharedConfigName.getPhone();
      final String _MobileNo = "" + vPhone;

      GetPartnerCustomerReq getPartnerCustomerReq = GetPartnerCustomerReq();
      getPartnerCustomerReq.sUserName = ConfigData.CONSUMER_KEY;
      getPartnerCustomerReq.sPassword = ConfigData.CONSUMER_SECRET;
      getPartnerCustomerReq.sHpNumber = _MobileNo;

      var response = await apiProvider.fetchData(
          ApiName.CheckHpNumber, getPartnerCustomerReq);
      if (response != null) {
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String link = root.children[2].children.first.toString();
        if (CheckError.isSuccess(link)) {
          var separateResult = response.split("\|");
          //final String _AgentCode = separateResult[0];
          final String URL = separateResult[1];
          Get.toNamed(GetListPages.PARTNER, arguments: {"link": URL});
        } else {
          showErrorMessage("Cannot verify your mobile number!");
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showErrorMessage("Cannot verify your mobile number, please try again!");
    }
  }

  Future<void> refreshNotificationCount() async {
    isLoading.value = true;
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

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void showHomeDialog(NotificationRes data) {
    showDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        context: Get.context!,
        builder: (_) => HomeDialog(data: data));
  }
}
