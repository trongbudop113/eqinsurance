import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyUserPage extends StatelessWidget {
  final RegisterController controller;
  const VerifyUserPage({Key? key, required this.controller}) : super(key: key);

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
                    Text("User Account", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20)),
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
                    text: 'User Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Please key in your existing User ID and Password to verify your user account.  Your user ID is the same login ID as the EQI Partners e-portal.',
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'User ID'
              ),
            ),
            SizedBox(height: 8),
            TextFieldWidget(
              controller: controller.userIDText,
              onSubmit: (value){
                //controller.onChangeUserName(value);
              },
              hint: "Enter User ID",
              isShowLeftIcon: true,
              leftIcon: ImageResource.user,
            ),

            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Password'
              ),
            ),
            SizedBox(height: 8),
            TextFieldWidget(
              controller: controller.userPasswordText,
              onSubmit: (value){
                //controller.onChangePassword(value);
              },
              hint: "Enter Password",
              isShowLeftIcon: true,
              leftIcon: ImageResource.lock,
            ),

            Spacer(flex: 1),
            ButtonWidget.buttonNormal(context, 'Next', onTap: (){
              controller.onSubmitUserAccount();
            }),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
