import 'dart:io';

import 'package:eqinsurance/configs/config_button.dart';
import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/device_info_config.dart';
import 'package:eqinsurance/configs/hide_keyboard.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/notification/models/notification_req.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
import 'package:eqinsurance/page/register/models/country_code_res.dart';
import 'package:eqinsurance/page/register/models/input_code_req.dart';
import 'package:eqinsurance/page/register/models/login_req.dart';
import 'package:eqinsurance/page/register/models/phone_number_req.dart';
import 'package:eqinsurance/page/register/models/user_account_req.dart';
import 'package:eqinsurance/page/register/models/verify_code_req.dart';
import 'package:eqinsurance/page/register/page/input_code_page.dart';
import 'package:eqinsurance/page/register/page/verify_code_page.dart';
import 'package:eqinsurance/page/register/page/verify_phone_page.dart';
import 'package:eqinsurance/page/register/page/verify_user_page.dart';
import 'package:eqinsurance/widgets/dialog/country_code_dialog.dart';
import 'package:eqinsurance/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }

}

class RegisterController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();

  final RxInt currentIndex = 0.obs;

  TextEditingController userIDText = TextEditingController();
  TextEditingController userPasswordText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();
  //TextEditingController pinCodeText = TextEditingController();
  TextEditingController scText = TextEditingController();
  TextEditingController confirmSCText = TextEditingController();

  List<int> listCountPage = List.generate(4, (index) => 0);

  RxString textLocationPhone = "".obs;
  RxString textCountryCodePhone = "".obs;

  String pinCodeText = '';

  RxList<CountryCode> listCountryCode = <CountryCode>[].obs;
  var listCountryCodeGen = CountryCodeRes.listCountryCode();

  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool isDisable = false.obs;

  @override
  void onInit() {
    initCountryCode();
    super.onInit();
  }

  void initCountryCode(){
    try{
      var countryCodeCurrent = listCountryCodeGen.where((element) => element.id == "65").first;
      countryCodeCurrent.isChecked.value = true;
      textLocationPhone.value = countryCodeCurrent.name ?? '';
      textCountryCodePhone.value = countryCodeCurrent.id ?? '';
      listCountryCode.value = listCountryCodeGen;
    }catch(e){
      textLocationPhone.value = 'Singapore';
      textCountryCodePhone.value = '65';
    }
  }

  void onSearchCountryCode(String value){
    try{
      listCountryCode.value = listCountryCodeGen;
      var listSearch = listCountryCode.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
      listCountryCode.value = listSearch;
    }catch(e){

    }
  }

  void onFocusPage(int i) {
    currentIndex.value = i;
  }

  void showLoading(){
    isDisable.value = true;
    isLoading.value = true;
  }

  void hideLoading(){
    isDisable.value = false;
    isLoading.value = false;
  }

  Future<void> onSubmitUserAccount() async {
    showLoading();
    try{
      if(userIDText.text.trim().isEmpty || userPasswordText.text.trim().isEmpty){
        showErrorMessage("Please enter User ID and Password");
      }else{
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

          if(CheckError.isSuccess(data)){
            doWhenVerifyUserSuccess(userIDText.text.trim(), userPasswordText.text.trim());
          }else{
            showErrorMessage('User ID or Password is wrong!');
          }
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage('User ID or Password is wrong!');
    }
  }

  Future<void> onSubmitVerifyPhoneNumber() async {
    showLoading();
    try{

      if(textCountryCodePhone.value.trim() == '' || phoneNumberText.text.trim() == ''){
        showErrorMessage("Please enter your mobile number and select country");
      }else{
        final String _MobileNo = textCountryCodePhone.value + phoneNumberText.text.trim();

        PhoneNumberReq phoneNumberReq = PhoneNumberReq();
        phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
        phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
        phoneNumberReq.sUserID = userID;
        phoneNumberReq.sMobileNo = _MobileNo;


        var response = await apiProvider.fetchData(ApiName.SendSMSWithOTP, phoneNumberReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenVerifyPhoneSuccess(phoneNumberText.text.trim(), textCountryCodePhone.value);
          }else{
            showErrorMessage("Cannot send SMS to your mobile number!");
          }
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot send SMS to your mobile number!");
    }
  }

  Future<void> onSubmitVerifyCodeOTP() async {
    showLoading();
    try{
      if(pinCodeText != '' && pinCodeText.length == 6){
        final String _MobileNo = countryCode + phoneNumber;
        print("pinCode ...." + pinCodeText);

        VerifyCodeReq phoneNumberReq = VerifyCodeReq();
        phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
        phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
        phoneNumberReq.sUserID = userID;
        phoneNumberReq.sMobileNo = _MobileNo;
        phoneNumberReq.sOTP = pinCodeText;


        var response = await apiProvider.fetchData(ApiName.VerifyOTP, phoneNumberReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenVerifyOTPSuccess(pinCodeText);
          }else{
            showErrorMessage("OTP is wrong!");
          }
        }
      }else{
        showErrorMessage("Please enter OTP");
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("OTP is wrong!");
    }
  }

  Future<void> onSubmitSCCode() async {
    showLoading();
    var sc = scText.text.trim().toString();
    var confirmSc = confirmSCText.text.trim().toString();

    try{
      if(sc.isEmpty || confirmSc.isEmpty){
        showErrorMessage("Please enter Security Code and Confirm Security Code.");
        hideLoading();
        return;
      }else if(sc.length != 6 || confirmSc.length != 6){
        showErrorMessage("Security Code must contain 6 digits.");
        hideLoading();
        return;
      }else if(!(sc == confirmSc)){
        showErrorMessage("Security Code does not match the Confirm Security Code.");
        hideLoading();
        return;
      }else{
        final String _MobileNo = countryCode + phoneNumber;

        InputCodeReq inputCodeReq = InputCodeReq();
        inputCodeReq.sUserName = ConfigData.CONSUMER_KEY;
        inputCodeReq.sPassword = ConfigData.CONSUMER_SECRET;
        inputCodeReq.sUserID = userID;
        inputCodeReq.sMobileNo = _MobileNo;
        inputCodeReq.sOTP = otp;
        inputCodeReq.sPin = sc;

        inputCodeReq.sManufacturer = "";
        inputCodeReq.sModel = "";
        inputCodeReq.sOsName = "";
        inputCodeReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


        var response = await apiProvider.fetchData(ApiName.InsertRecord, inputCodeReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenVerifySCSuccess(sc);
          }else{
            showErrorMessage("Invalid Security Code!");
            hideLoading();
          }
        }
      }
    }catch(e){
      hideLoading();
      showErrorMessage("Invalid Security Code!");
    }
  }

  Future<void> onSubmitLogin() async {
    try{
      Login1Req loginReq = Login1Req();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sUserID = userID;
      loginReq.sPin = scCode;

      loginReq.sManufacturer = "";
      loginReq.sModel = "";
      loginReq.sOsName = "";
      loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


      var response = await apiProvider.fetchData(ApiName.LoginWithSecurityCode, loginReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          doWhenSuccessLoginWithSecurityCode(data);
        }else{
          showErrorMessage("Cannot login. Please contact website admin!");
          hideLoading();
        }
      }else{
        hideLoading();
      }
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot login. Please contact website admin!");
    }
  }

  Future<void> onSubmitLoginAgentCode(String link) async {
    try{
      Login2Req loginReq = Login2Req();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sUserID = userID;
      loginReq.sUserPass = userPassword;

      loginReq.sManufacturer = "";
      loginReq.sModel = "";
      loginReq.sOsName = "";
      loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


      var response = await apiProvider.fetchData(ApiName.GetAgentCode, loginReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          await ConfigButton.singleton.showHideButton();
          var newLink = link.replaceAll("amp;", "");
          doWhenLoginSuccess(newLink);
        }else{
          showErrorMessage("Cannot get AgentCode!");
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot get AgentCode!");
    }
  }

  Future<void> onSubmitResendCode() async {
    showLoading();
    try{
      final String _MobileNo = countryCode + phoneNumber;

      PhoneNumberReq phoneNumberReq = PhoneNumberReq();
      phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
      phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
      phoneNumberReq.sUserID = userID;
      phoneNumberReq.sMobileNo = _MobileNo;


      var response = await apiProvider.fetchData(ApiName.SendSMSWithOTP, phoneNumberReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          showErrorMessage("New OTP has been sent to you.");
        }else{
          showErrorMessage("Cannot send SMS to your mobile number!");
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot send SMS to your mobile number!");
    }
  }

  String userID = '';
  String userPassword = '';
  void doWhenVerifyUserSuccess(String _UserID, String _UserPass){
    SharedConfigName.setUserID(_UserID);
    SharedConfigName.setUserPass(_UserPass);

    userIDText.clear();
    userPasswordText.clear();
    userID = _UserID;
    userPassword = _UserPass;
    onFocusPage(1);
  }

  String phoneNumber = '';
  String countryCode = '';
  void doWhenVerifyPhoneSuccess(String phone, String code){
    phoneNumber = phone;
    countryCode = code;

    phoneNumberText.clear();
    listCountryCodeGen = CountryCodeRes.listCountryCode();
    initCountryCode();
    //missing

    onFocusPage(2);
  }

  String otp = "";
  void doWhenVerifyOTPSuccess(String _otp){
    this.otp = _otp;

    pinCodeText = '';
    onFocusPage(3);
  }

  String scCode = '';
  void doWhenVerifySCSuccess(String scCode){
    this.scCode = scCode;
    onSubmitLogin();
  }

  Future<void> doWhenSuccessLoginWithSecurityCode(String data) async {
    String currentUserType = await SharedConfigName.getCurrentUserType();
    if(currentUserType != ConfigData.AGENT){
      await SharedConfigName.clearUserNotificationCache();
    }
    refreshNotificationCount();
    SharedConfigName.setSC(scCode);
    SharedConfigName.setRegisteredUserType("AGENT");
    SharedConfigName.setPhone(countryCode + phoneNumber);
    onSubmitLoginAgentCode(data);
  }

  void doWhenLoginSuccess(String data){
    SharedConfigName.setAgentCode(data);
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"link" : data});
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void showDialogSelectCountryCode(){
    showDialog(
        context: Get.context!,
        builder: (_) => CountryCodeDialog(controller: this)
    );
  }

  void onChangeSearchCountry(CountryCode? countryCodeSelect){
    try{
      CountryCode? countryCode;
      for(var item in listCountryCodeGen){
        if(item.id == textCountryCodePhone.value && item.name!.toLowerCase() == textLocationPhone.value.toLowerCase()){
          item.isChecked.value = false;
        }

        if(item.id == countryCodeSelect!.id && item.name!.toLowerCase() == countryCodeSelect.name!.toLowerCase()){
          item.isChecked.value = true;
          countryCode = item;
        }
      }
      if(countryCode == null){
        return;
      }
      textCountryCodePhone.value = countryCode.id ?? '';
      textLocationPhone.value = countryCode.name ?? '';

      listCountryCode.value = listCountryCodeGen;
    }catch(e){

    }
  }

  void onCloseDialog(){
    listCountryCode.value = listCountryCodeGen;
  }

  Widget getWidgetContent(){
    if(currentIndex.value == 0){
      return VerifyUserPage(controller: this);
    }else if(currentIndex.value == 1){
      return VerifyPhonePage(controller: this);
    }else if(currentIndex.value == 2){
      return VerifyCodePage(controller: this);
    }else if(currentIndex.value == 3){
      return InputCodePage(controller:  this);
    }else{
      return Container();
    }
  }

  void onBackPress(){
    pinCodeText = "";
    phoneNumberText.clear();
    userPasswordText.clear();
    userIDText.clear();
    scText.clear();
    confirmSCText.clear();
    initCountryCode();
    listCountryCodeGen = CountryCodeRes.listCountryCode();
    if(currentIndex.value == 3){
      currentIndex.value = 2;
    }else if(currentIndex.value == 2){
      currentIndex.value = 1;
    }else if(currentIndex.value == 1){
      currentIndex.value = 0;
    }else{
      Get.back();
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

}