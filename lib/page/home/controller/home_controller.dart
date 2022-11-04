import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/home/models/GetPartnerCustomerReq.dart';
import 'package:eqinsurance/page/home/models/get_public_user_req.dart';
import 'package:eqinsurance/page/webview/model/get_contact_req.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}

class HomeController extends GetxController{

  ApiProvider apiProvider = ApiProvider();

  Future<void> getContactInfo() async {
    GetContactReq getContactReq = GetContactReq();
    getContactReq.sUserName = ConfigData.CONSUMER_KEY;
    getContactReq.sPassword = ConfigData.CONSUMER_SECRET;
    getContactReq.sType = ConfigData.PUBLIC;
    getContactReq.sHpNumber = "65 9468 7687";


    var response = await apiProvider.fetchData(ApiName.ContactUs, getContactReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
    }
  }


  Future<void> getPublicUser() async {
    GetPublicUserReq getPublicUserReq = GetPublicUserReq();
    getPublicUserReq.sUserName = ConfigData.CONSUMER_KEY;
    getPublicUserReq.sPassword = ConfigData.CONSUMER_SECRET;


    var response = await apiProvider.fetchData(ApiName.PublicLink, getPublicUserReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }

  void goToPartnerCustomer(){
    if(SharedConfigName.getCurrentUserType == ConfigData.PROMO && SharedConfigName.getPhone != ''){
      showPartnerCustomerWebsite();
    }else{
      Get.toNamed(GetListPages.PARTNER_CUSTOMER);
    }
  }

  Future<void> goToPartnerPage() async {
    bool isSet = await SharedConfigName.isSetSC();
    if(isSet){
      Get.toNamed(GetListPages.INPUT_CODE);
    }else{
      Get.toNamed(GetListPages.REGISTER);
    }
  }

  Future<void> showPartnerCustomerWebsite() async {
    GetPartnerCustomerReq getPartnerCustomerReq = GetPartnerCustomerReq();
    getPartnerCustomerReq.sUserName = ConfigData.CONSUMER_KEY;
    getPartnerCustomerReq.sPassword = ConfigData.CONSUMER_SECRET;
    getPartnerCustomerReq.sHpNumber = "65 9468 7687";


    var response = await apiProvider.fetchData(ApiName.CheckHpNumber, getPartnerCustomerReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      //Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
    }
  }

}