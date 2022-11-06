import 'dart:io';

import 'package:eqinsurance/configs/configs_data.dart';
import 'package:eqinsurance/configs/shared_config_name.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/network/api_name.dart';
import 'package:eqinsurance/network/api_provider.dart';
import 'package:eqinsurance/page/register/controller/check_error.dart';
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

class RegisterController extends GetxController{

  ApiProvider apiProvider = ApiProvider();

  final RxInt currentIndex = 0.obs;

  TextEditingController userIDText = TextEditingController();
  TextEditingController userPasswordText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();
  TextEditingController pinCodeText = TextEditingController();
  TextEditingController scText = TextEditingController();
  TextEditingController confirmSCText = TextEditingController();

  List<int> listCountPage = List.generate(4, (index) => 0);

  RxString textLocationPhone = "Singapore".obs;
  RxString textCountryCodePhone = "+65".obs;

  final formKey = GlobalKey<FormState>();


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

      if(CheckError.isSuccess(data)){
        doWhenVerifyUserSuccess(userIDText.text.trim(), userPasswordText.text.trim());
      }else{
        showErrorMessage('User ID or Password is wrong!');
      }
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }

  Future<void> onSubmitVerifyPhoneNumber() async {

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
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }

  Future<void> onSubmitVerifyCodeOTP() async {

    final String _MobileNo = countryCode + phoneNumber;

    VerifyCodeReq phoneNumberReq = VerifyCodeReq();
    phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
    phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
    phoneNumberReq.sUserID = userID;
    phoneNumberReq.sMobileNo = _MobileNo;
    phoneNumberReq.sOTP = pinCodeText.text.trim();


    var response = await apiProvider.fetchData(ApiName.VerifyOTP, phoneNumberReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(CheckError.isSuccess(data)){
        doWhenVerifyOTPSuccess(pinCodeText.text.trim());
      }else{
        showErrorMessage("OTP is wrong!");
      }
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }

  Future<void> onSubmitSCCode() async {

    var sc = scText.text.trim().toString();
    var confirmSc = confirmSCText.text.trim().toString();
    final regexp = RegExp(r'^[0-9]*\$');

    try{
      if(sc.isEmpty || confirmSc.isEmpty){
        showErrorMessage("Please enter Security Code and Confirm Security Code.");
      }else if(!regexp.hasMatch(sc) || !regexp.hasMatch(confirmSc) || sc.length != 6 || confirmSc.length!=6){
        showErrorMessage("Security Code must contain 6 digits.");
      }else if(!(sc == confirmSc)){
        showErrorMessage("Security Code does not match the Confirm Security Code.");
      }else{
        final String _MobileNo = countryCode + phoneNumber;

        InputCodeReq inputCodeReq = InputCodeReq();
        inputCodeReq.sUserName = ConfigData.CONSUMER_KEY;
        inputCodeReq.sPassword = ConfigData.CONSUMER_SECRET;
        inputCodeReq.sUserID = userID;
        inputCodeReq.sMobileNo = _MobileNo;
        inputCodeReq.sOTP = otp;
        inputCodeReq.sPin = sc;

        // inputCodeReq.sManufacturer = scText.text.trim();
        // inputCodeReq.sOsVersion = scText.text.trim();
        // inputCodeReq.sModel = scText.text.trim();
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
          }
          //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
        }
      }
    }catch(e){

    }
  }

  Future<void> onSubmitLogin() async {

    Login1Req loginReq = Login1Req();
    loginReq.sUserName = ConfigData.CONSUMER_KEY;
    loginReq.sPassword = ConfigData.CONSUMER_SECRET;
    loginReq.sUserID = userID;
    loginReq.sPin = scCode;

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
        doWhenSuccessLoginWithSecurityCode();
      }else{
        showErrorMessage("Cannot login. Please contact website admin!");
      }
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
  }

  Future<void> onSubmitLoginAgentCode() async {

    Login2Req loginReq = Login2Req();
    loginReq.sUserName = ConfigData.CONSUMER_KEY;
    loginReq.sPassword = ConfigData.CONSUMER_SECRET;
    loginReq.sUserID = userID;
    loginReq.sUserPass = userPassword;

    // loginReq.sManufacturer = scText.text.trim();
    // loginReq.sOsVersion = scText.text.trim();
    // loginReq.sModel = scText.text.trim();
    loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


    var response = await apiProvider.fetchData(ApiName.GetAgentCode, loginReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(CheckError.isSuccess(data)){
        doWhenLoginSuccess(data);
      }else{
        showErrorMessage("Cannot get AgentCode!");
      }
      //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
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
    //missing

    onFocusPage(2);
  }

  String otp = "";
  void doWhenVerifyOTPSuccess(String _otp){
    this.otp = otp;

    pinCodeText.clear();
    onFocusPage(3);
  }

  String scCode = '';
  void doWhenVerifySCSuccess(String scCode){
    this.scCode = scCode;
    onSubmitLogin();
  }

  Future<void> doWhenSuccessLoginWithSecurityCode() async {
    String currentUserType = await SharedConfigName.getCurrentUserType();
    if(currentUserType != ConfigData.AGENT){
      await SharedConfigName.clearUserNotificationCache();
    }

    SharedConfigName.setSC(scCode);
    SharedConfigName.setRegisteredUserType("AGENT");
    SharedConfigName.setPhone(countryCode + phoneNumber);
    onSubmitLoginAgentCode();
  }

  void doWhenLoginSuccess(String data){
    SharedConfigName.setAgentCode(data);

    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"res" : data});
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
      builder: (_) => CountryCodeDialog()
    );
  }

  void onChangeSearchCountry(String value){

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

}