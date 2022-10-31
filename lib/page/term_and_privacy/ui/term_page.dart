
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/term_and_privacy/controller/term_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/string_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermPage extends GetView<TermController>{
  const TermPage({Key? key}) : super(key: key);

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
            SizedBox(height: 50),
            Image.asset(ImageResource.logo1, width: Get.width * 0.5),
            SizedBox(height: 10),
            Text(
              StringResource.code_for_access,
              textAlign: TextAlign.center,
              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14),
            ),

            Spacer(flex: 1),
            Text(
              StringResource.tap_on,
              textAlign: TextAlign.center,
              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                color: Colors.transparent,
                child: Text(
                  StringResource.eq_term,
                  textAlign: TextAlign.center,
                  style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, decoration: TextDecoration.underline,),
                ),
              ),
            ),
            SizedBox(height: 18),

            ButtonWidget.buttonNormal(context, "Agree and Continue", onTap: (){
              Get.toNamed(GetListPages.singleton.HOME);
            })
          ],
        ),
      ),
    );
  }

}