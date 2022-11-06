import 'package:eqinsurance/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class NewSCPage extends StatelessWidget {
  final ForgetSCController controller;
  const NewSCPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                          controller.onBackPress();
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
                  'For better privacy protection, you are required to set a 6 Digit number security code below. You will need to enter this security code for all future login purposes.',
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    'Security Code'
                ),
              ),
              SizedBox(height: 8),
              TextFieldWidget(onSubmit: (value){

              }, hint: "Enter Security Code",
                  controller: controller.scText,
                  isShowLeftIcon: true,
                  leftIcon: ImageResource.key
              ),

              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    'Confirm Security Code'
                ),
              ),
              SizedBox(height: 8),
              TextFieldWidget(onSubmit: (value){

              }, hint: "Confirm Security Code",
                  controller: controller.confirmSCText,
                  isShowLeftIcon: true,
                  leftIcon: ImageResource.key
              ),

              Spacer(flex: 1),
              SizedBox(height: 10),
              ButtonWidget.buttonNormal(context, "Next", onTap: (){
                controller.onSubmitSCCode();
              }),
              SizedBox(height: 25),
            ],
          ),
        )
    );
  }
}
