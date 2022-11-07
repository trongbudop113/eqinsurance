
import 'package:eqinsurance/page/partner_customer/controller/partner_customer_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnerCustomerPage extends GetView<PartnerCustomerController>{
  const PartnerCustomerPage({Key? key}) : super(key: key);

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
            SizedBox(height: 20),
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
                        child: Image.asset(ImageResource.ic_back, width: 12),
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                )
            ),

            SizedBox(height: 50),
            Image.asset(ImageResource.logo1, width: Get.width * 0.5),

            SizedBox(height: 25),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Partner Contact Number'),
            ),
            SizedBox(height: 10),
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
                  child: Text("+${controller.countryCode}"),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                      onSubmit: (value){

                      },
                    controller: controller.phoneText,
                      hint: "Enter phone number",
                  ),
                )
              ],
            ),

            Spacer(flex: 1),
            ButtonWidget.buttonNormal(context, 'Next', onTap: (){
              controller.onSubmitCheckPhone();
            }),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

}