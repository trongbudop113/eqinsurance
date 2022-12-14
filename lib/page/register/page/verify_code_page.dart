import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodePage extends StatefulWidget {
  final RegisterController controller;
  const VerifyCodePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(ImageResource.bg),
                    fit: BoxFit.fill
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SizedBox(height: 25),
                Container(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: (){
                            widget.controller.onBackPress();
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: 22,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(ImageResource.ic_back, width: 12,),
                          ),
                        ),
                        Spacer(flex: 1),
                        Text("Verify Phone Number", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: ColorResource.page_title_textColor, fontWeight: FontWeight.bold)),
                        Spacer(flex: 1),
                        SizedBox(width: 27),
                      ],
                    )
                ),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset(ImageResource.logo0, width: 50),

                      SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 22, color: ColorResource.page_title_textColor),
                          children: [
                            TextSpan(text: 'Verify '),
                            TextSpan(
                              text: "+" + widget.controller.countryCode + widget.controller.phoneNumber,
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorResource.color_title_popup),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'We have sent you a text message with a 6 digit numeric code. Please key in the code within 3 minutes and click Next to proceed.',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 30),
                      Form(
                        key: widget.controller.formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PinCodeTextField(
                              controller: textEditingController,
                              appContext: context,
                              length: 6,
                              obscureText: false,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                borderWidth: 0,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(3),
                                fieldHeight: 38,
                                fieldWidth: (Get.width - 90) / 6 ,
                                activeFillColor: Colors.white,
                                activeColor: Colors.white,
                                disabledColor: Colors.white,
                                selectedColor: Colors.white,
                                inactiveColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                selectedFillColor: Colors.white,
                              ),
                              cursorColor: Colors.blue,
                              cursorHeight: 20,
                              enableActiveFill: true,
                              //controller: controller.pinCodeText,
                              keyboardType: TextInputType.number,
                              textStyle: StyleResource.TextStyleBlack(context).copyWith(fontSize: 16, color: Colors.black),
                              onCompleted: (v) {
                                widget.controller.pinCodeText = v.toString();
                              },
                              onChanged: (value) {
                                widget.controller.pinCodeText = value.toString();
                              },
                              beforeTextPaste: (text) {
                                return true;
                              },
                            )),
                      ),

                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text('Enter 6 Digit Code', style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 16, color: ColorResource.color_button_partner)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 15,
            right: 15,
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    widget.controller.onSubmitResendCode();
                    widget.controller.pinCodeText = "";
                    textEditingController.clear();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageResource.message, width: 15),
                        SizedBox(width: 10),
                        Text('Resend the Code', style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 15, color: ColorResource.link_text))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Obx(() => ButtonWidget.buttonNormal(context, 'Next', onTap: (){
                  widget.controller.onSubmitVerifyCodeOTP();
                  //controller.onFocusPage(3);
                }, isDisable: widget.controller.isDisable.value)),
              ],
            )
          )
        ],
      ),
    );
  }
}
