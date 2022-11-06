import 'package:eqinsurance/page/change_sc/controller/change_sc_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChangeSCPage extends GetView<ChangeSCController>{
  const ChangeSCPage({Key? key}) : super(key: key);

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
                    SizedBox(width: 15),
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
                    Text("Change Security Code", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20)),
                    Spacer(flex: 1),
                    SizedBox(width: 27)
                  ],
                )
            ),
            SizedBox(height: 20),
            Image.asset(ImageResource.logo0, width: 50),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Change '),
                  TextSpan(
                    text: 'Security Code',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Follow the steps below to change your Security Code.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Current Security Code'),
            ),
            SizedBox(height: 10),
            TextFieldWidget(onSubmit: (value){

            }, hint: "Enter Current Security Code",
              controller: controller.currentScText,
            ),

            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('New Security Code'),
            ),
            SizedBox(height: 10),
            TextFieldWidget(onSubmit: (value){

            }, hint: "Enter New Security Code",
              controller: controller.newScText,
            ),

            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Confirm New Security Code'),
            ),
            SizedBox(height: 10),
            TextFieldWidget(onSubmit: (value){

            }, hint: "Confirm New Security Code",
              controller: controller.confirmScText,
            ),

            Spacer(flex: 1),
            ButtonWidget.buttonNormal(context, 'Update', onTap: (){
              controller.onSubmitChangeSC();
            })
          ],
        ),
      ),
    );
  }

}