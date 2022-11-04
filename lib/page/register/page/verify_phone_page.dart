import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPhonePage extends StatelessWidget {
  final RegisterController controller;
  const VerifyPhonePage({Key? key, required this.controller}) : super(key: key);

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
        padding: EdgeInsets.all(15),
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
                        Get.back();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(ImageResource.ic_back, width: 12,),
                      ),
                    ),
                    Spacer(flex: 1),
                    Text("Verification", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20)),
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
                  TextSpan(text: 'Verify your '),
                  TextSpan(
                    text: 'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'In order to protect the security of your account, we would need you to verify your mobile phone number. We will send you a text message with the verification code that you will need to enter on the next screen.',
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Location'
              ),
            ),
            SizedBox(height: 8),
            TextFieldWidget(
              onSubmit: (value){

              },
              hint: "Enter User ID",
              isShowLeftIcon: true,
              leftIcon: ImageResource.user,
            ),

            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Phone'
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  height: 38,
                  width: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: Text("+65"),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    onSubmit: (value){

                    },
                    hint: "Enter phone number",
                  ),
                )
              ],
            ),

            Spacer(flex: 1),
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
