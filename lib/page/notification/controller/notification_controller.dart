import 'dart:convert';

import 'package:eqinsurance/configs/check_network.dart';
import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/notification/models/notification_req.dart';
import 'package:eqinsurance/page/notification/models/notification_res.dart';
import 'package:eqinsurance/widgets/dialog/confirm_dialog.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
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
  final List<NotificationRes> listNotificationTemp = <NotificationRes>[];

  final RxBool isSelected = false.obs;

  final RxBool isLoading = true.obs;
  final RxBool isLoadMore = true.obs;
  bool isDeleteNotification = false;

  int page = 0;
  int limit = 10;
  bool noMorePage = false;
  int totalPages = 0;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    limit = await SharedConfigName.getNotificationsPerPage();
    if(await CheckConnect.hasNetwork()){
      getNotification();
    }else{
      isLoading.value = false;
      showErrorMessage("Network Error, Please try again!");
    }
  }

  Future<void> showErrorMessage(String message) async {
    await showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void onBack(){
    print("isDeleteNotification..." + isDeleteNotification.toString());
    Get.back(result: isDeleteNotification);
  }

  Future<void> getNotification() async {
    isLoading.value = true;
    String agentCode = await SharedConfigName.getAgentCode();
    String userType = await SharedConfigName.getCurrentUserType();

    GetNotificationReq getNotificationReq = GetNotificationReq();
    getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
    getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
    getNotificationReq.sType = userType;
    getNotificationReq.sAgentCode = agentCode;


    var response = await apiProvider.fetchData(ApiName.Notification, getNotificationReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      //print("data....." + root.children[2].children.first.toString());
      if(root.children[2].children.length == 0){
        isLoading.value = false;
        return;
      }
      String jsonString = root.children[2].children.first.toString();
      NotificationDataRes notificationDataRes = NotificationDataRes.fromJson(jsonDecode(jsonString));
      print("data....." + notificationDataRes.data!.length.toString());
      listNotificationTemp.clear();
      listNotificationTemp.addAll(notificationDataRes.data ?? []);

      int totalItems = listNotificationTemp.length;

      if(totalItems > 0){
        totalPages = (totalItems/limit + (totalItems % limit == 0 ? 0 : 1)).toInt();
        listNotification.clear();
        if(totalItems >=  limit){
          var newList =  listNotificationTemp.getRange(page * limit, limit);
          listNotification.addAll(newList);
          isLoadMore.value = true;
          page++;
        }else{
          listNotification.addAll(listNotificationTemp);
          isLoadMore.value = false;
        }
        displayNotificationList();
      }else{
        totalPages = 0;
        isLoadMore.value = false;
      }
    }
    isLoading.value = false;
  }

  Future<void> refreshNotification() async {
    if(!(await CheckConnect.hasNetwork())){
      showErrorMessage("Network Error, Please try again!");
      return;
    }
    isLoading.value = true;
    try{
      page = 0;
      String agentCode = await SharedConfigName.getAgentCode();
      String userType = await SharedConfigName.getCurrentUserType();

      GetNotificationReq getNotificationReq = GetNotificationReq();
      getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
      getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
      getNotificationReq.sType = userType;
      getNotificationReq.sAgentCode = agentCode;


      var response = await apiProvider.fetchData(ApiName.Notification, getNotificationReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String jsonString = root.children[2].children.first.toString();
        NotificationDataRes notificationDataRes = NotificationDataRes.fromJson(jsonDecode(jsonString));
        print("data....." + notificationDataRes.data!.length.toString());
        listNotificationTemp.clear();
        listNotificationTemp.addAll(notificationDataRes.data ?? []);

        int totalItems = listNotificationTemp.length;

        if(totalItems > 0){
          totalPages = (totalItems/limit + (totalItems % limit == 0 ? 0 : 1)).toInt();
          listNotification.clear();
          if(totalItems >=  limit){
            var newList = listNotificationTemp.getRange(page * limit, limit);
            listNotification.addAll(newList);
            isLoadMore.value = true;
            page++;
          }else{
            listNotification.addAll(listNotificationTemp);
            isLoadMore.value = false;
          }
          displayNotificationList();
        }else{
          totalPages = 0;
          isLoadMore.value = false;
        }
      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
    }
  }

  void loadMoreData(){
    List<NotificationRes> newList = [];
    if(totalPages == (page + 1)){
      newList = listNotificationTemp.getRange(page * limit, listNotificationTemp.length  - 1).toList();
      isLoadMore.value = false;
    }else{
      newList = listNotificationTemp.getRange(page * limit, (page + 1) * limit).toList();
      isLoadMore.value = true;
    }
    listNotification.addAll(newList);
    page++;

    for(int i = 0; i < listNotification.length; i++){
      if(listNotificationRead.contains(listNotification[i].iD)){
        listNotification[i].isRead.value = true;
      }
      if(listNotificationDeleted.contains(listNotification[i].iD)){
        listNotification.removeAt(i);
      }
    }
  }

  Future<void> displayNotificationList() async {
    var dataDeleted = await SharedConfigName.getUserDeletedNotificationIDs();
    var dataRead = await SharedConfigName.getUserReadNotificationIDs();
    print("dataRead.... " + dataRead.toString());
    listNotificationDeleted.clear();
    listNotificationRead.clear();
    listNotificationDeleted.addAll(dataDeleted);
    listNotificationRead.addAll(dataRead);

    if(listNotification.length == 0){
      return;
    }
    for(int i = 0; i < listNotification.length; i++){
      if(listNotificationRead.contains(listNotification[i].iD)){
        listNotification[i].isRead.value = true;
      }
    }
    if(listNotificationDeleted.length > 0) {
      listNotification.removeWhere((element) => listNotificationDeleted.contains(element.iD));
    }
  }

  void onSelectListener(){
    if(listNotification.length == 0){
      return;
    }
    onSetSelect();
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
      listNotification[index].isRead.value = true;
      listNotificationRead.add(listNotification[index].iD ?? '');
      if(isDelete){
        listNotificationDeleted.add(listNotification[index].iD ?? '');
        listNotification.removeWhere((element) => listNotification[index].iD == element.iD);
        removeItemInList();
      }else{
        SharedConfigName.addUserReadNotificationID(listNotification[index].iD ?? '');
      }
      isDeleteNotification = true;
    }
  }

  List<String> listNotificationDeleted = [];
  List<String> listNotificationRead = [];

  Future<void> onDeleteNotificationItem(BuildContext context) async {
    for(int i = 0; i < listNotification.length; i++){
      if(listNotification[i].isCheck.value){
        listNotificationDeleted.add(listNotification[i].iD ?? '');
      }
    }
    if(listNotificationDeleted.length == 0){
      onSetSelect();
      return;
    }
    bool isOk = await showDialog(
      context: context,
      builder: (_) => ConfirmDialog(message: "Delete Notification?"),
    );

    if(isOk){

      if(listNotificationDeleted.length > 0){
        listNotification.removeWhere((element) => listNotificationDeleted.contains(element.iD));
      }
      removeItemInList();
      onSetSelect();
      isDeleteNotification = true;
    }

  }

  void removeItemInList(){
    SharedConfigName.addUserDeletedNotificationID(listNotificationDeleted);
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