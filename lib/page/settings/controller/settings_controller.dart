import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/settings/models/notification_item_count.dart';
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

  Future<void> onClickYes() async {
    await getNotificationItemCount();
    Get.back();
  }

  void onCLickNo(){
    Get.back();
  }

  Future<void> getNotificationItemCount() async {
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

    }
  }

}