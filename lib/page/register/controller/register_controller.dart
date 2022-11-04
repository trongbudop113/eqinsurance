import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/register/models/user_account_req.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }

}

class RegisterController extends GetxController{

  ApiProvider apiProvider = ApiProvider();

  final RxInt currentIndex = 0.obs;

  TextEditingController userIDText = TextEditingController();
  TextEditingController userPasswordText = TextEditingController();

  List<int> listCountPage = List.generate(4, (index) => 0);


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onFocusPage(int i) {
    currentIndex.value = i;
  }

  Future<void> onSubmitUserAccount() async {
    UserAccountReq userAccountReq = UserAccountReq();
    userAccountReq.sUserName = ConfigData.CONSUMER_KEY;
    userAccountReq.sPassword = ConfigData.CONSUMER_SECRET;
    userAccountReq.sUserID = userIDText.text.trim();
    userAccountReq.sUserPass = userPasswordText.text.trim();


    var response = await apiProvider.fetchData(ApiName.IsValidateID, userAccountReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(data == '0'){
        onFocusPage(1);
      }
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }


  void onChangeUserName(String value){
    userIDText.text = value;
  }

  void onChangePassword(String value){
    userPasswordText.text = value;
  }

}