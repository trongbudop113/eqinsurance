import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodePage extends StatelessWidget {
  final RegisterController controller;
  const VerifyCodePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        controller.onBackPress();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(ImageResource.ic_back, width: 12,),
                      ),
                    ),
                    Spacer(flex: 1),
                    Text("Verify Phone Number", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20)),
                    Spacer(flex: 1),
                    SizedBox(width: 17),
                  ],
                )
            ),

            SizedBox(height: 20),
            Image.asset(ImageResource.logo0, width: 50),

            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Verify '),
                  TextSpan(
                    text: controller.countryCode + controller.phoneNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'We have sent you a text message with a 6 digit numeric code. Please key in the code within 3 minutes and click Next to proceed.',
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 30),
            Form(
              key: controller.formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
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
                    controller: controller.pinCodeText,
                    keyboardType: TextInputType.number,
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                    onCompleted: (v) {

                    },
                    onChanged: (value) {

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
            Text('Enter 6 Digit Code', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15, fontWeight: FontWeight.bold)),

            Spacer(flex: 1),

            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageResource.message, width: 15),
                  SizedBox(width: 10),
                  Text('Resend the Code', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15, decoration: TextDecoration.underline,))
                ],
              ),
            ),
            SizedBox(height: 10),
            ButtonWidget.buttonNormal(context, 'Next', onTap: (){
              controller.onFocusPage(2);
            }),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
