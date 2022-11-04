import 'dart:core';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedConfigName{
  static const String sc = "sc";
  static const String UserID = "_UserID";
  static const String UserPass = "_UserPass";
  static const String AgentCode = "_AgentCode";
  static const String phone= "phone";
  static const String userType = "userType";
  static const String userNotificationReadIDs = "userNotificationReadIDs";
  static const String userNotificationDeletedIDs = "userNotificationDeletedIDs";
  static const String popupID = "popupID";

  static const String NotificationsPerPage = "NotificationsPerPage";


  static Future<void> logoutUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(sc);
    sharedPreferences.remove(UserID);
    sharedPreferences.remove(UserPass);
    sharedPreferences.remove(AgentCode);
    sharedPreferences.remove(phone);
    sharedPreferences.remove(userType);
    sharedPreferences.remove(userNotificationReadIDs);
    sharedPreferences.remove(userNotificationDeletedIDs);
    sharedPreferences.remove(popupID);
    sharedPreferences.remove(NotificationsPerPage);
  }


  static Future<void> setNotificationsPerPage(int number) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(NotificationsPerPage, number);
  }

  static Future<String> getCurrentUserType() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String data =  sharedPreferences.getString(userType) ?? '';
    if(data != ''){
      return userType;
    }
    return ConfigData.PUBLIC;
  }

  static Future<String> getPhone() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(phone) ?? '';
  }

  static Future<bool> isSetSC() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String data =  sharedPreferences.getString(sc) ?? '';
    if(data != ''){
      return true;
    }
    return false;
  }
}