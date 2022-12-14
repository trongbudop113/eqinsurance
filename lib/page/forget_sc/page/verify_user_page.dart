import 'package:eqinsurance/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyUserPage extends StatelessWidget {
  final ForgetSCController controller;
  const VerifyUserPage({Key? key, required this.controller}) : super(key: key);

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
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                            width: 22,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(ImageResource.ic_back, width: 12,),
                          ),
                        ),
                        Spacer(flex: 1),
                        Text("Forgot Security Code", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: ColorResource.page_title_textColor, fontWeight: FontWeight.bold)),
                        Spacer(flex: 1),
                        SizedBox(width: 27)
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
                            TextSpan(text: 'Change '),
                            TextSpan(
                              text: 'Security Code',
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorResource.color_title_popup),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'In order to reset your Security Code, please key in your existing User ID and Password.  Your user ID is the same login ID as the EQI Partners e-portal.',
                        style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'User ID',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          onSubmit: (value){

                          },
                          controller: controller.userIDText,
                          hint: "Enter User ID",
                          isShowLeftIcon: true,
                          leftIcon: ImageResource.user
                      ),

                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          onSubmit: (value){

                          },
                          controller: controller.userPasswordText,
                          hint: "Enter Password",
                          isShowLeftIcon: true,
                          obscureText: true,
                          leftIcon: ImageResource.lock
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Obx(() => ButtonWidget.buttonNormal(context, 'Next', onTap: (){
              controller.onSubmitUserAccount();
            }, isDisable: controller.isDisable.value)),
          )
        ],
      ),
    );
  }
}
