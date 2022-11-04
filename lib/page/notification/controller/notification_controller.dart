import 'dart:convert';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/notification/models/notification_req.dart';
import 'package:eqinsurance/page/notification/models/notification_res.dart';
import 'package:eqinsurance/widgets/dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }

}

class NotificationController extends GetxController{

  ApiProvider apiProvider = ApiProvider();

  final RxList<NotificationRes> listNotification = <NotificationRes>[].obs;

  final RxBool isSelected = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  }

  Future<void> getNotification() async {
    GetNotificationReq getNotificationReq = GetNotificationReq();
    getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
    getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
    getNotificationReq.sType = ConfigData.PUBLIC;
    getNotificationReq.sAgentCode = "";


    var response = await apiProvider.fetchData(ApiName.Notification, getNotificationReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String jsonString = root.children[2].children.first.toString();
      NotificationDataRes notificationDataRes = NotificationDataRes.fromJson(jsonDecode(jsonString));
      print("data....." + notificationDataRes.data!.length.toString());
      listNotification.clear();
      listNotification.addAll(notificationDataRes.data ?? []);
    }
  }

  void onSetSelect(){
    isSelected.value = !isSelected.value;
  }

  void onSetSelectedItem(int index){
    listNotification[index].isCheck.value = !listNotification[index].isCheck.value;
  }

  Future<void> onSelectItem(int index) async {
    if(isSelected.value){
      onSetSelectedItem(index);
    }else{
      bool isDelete = await Get.toNamed(GetListPages.NOTIFICATION_DETAIL, arguments: {"data" : listNotification[index]});
      if(isDelete){
        listNotification.removeAt(index);
      }
    }
  }

  Future<void> onDeleteNotificationItem(BuildContext context) async {

    bool isOk = await showDialog(
      context: context,
      builder: (_) => ConfirmDialog(message: "Delete Notification?"),
    );

    if(isOk){
      for(int i = 0; i < listNotification.length; i++){
        if(listNotification[i].isCheck.value){
          listNotification.removeAt(i);
        }
      }
      onSetSelect();
    }

  }

  Widget selectedCheckbox(bool isSelected){

    final double size = 12;
    return Visibility(
      visible: isSelected,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey)
        ),
        child: Icon(Icons.check, color: Colors.black, size: 10),
      ),
      replacement: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
        ),
      ),
    );
  }
}