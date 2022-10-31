
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/home/controller/home_controller.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/string_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({Key? key}) : super(key: key);

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
            SizedBox(height: 30),
            Row(
              children: [
                Spacer(flex: 1),
                GestureDetector(
                  child: Image.asset(ImageResource.ic_settings, width: 20, height: 20),
                  onTap: (){
                    Get.toNamed(GetListPages.singleton.SETTINGS);
                  },
                ),
                SizedBox(width: 8),
                GestureDetector(
                  child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                  onTap: (){
                    Get.toNamed(GetListPages.singleton.CONTACT_US);
                  },
                ),
                SizedBox(width: 8),
                GestureDetector(
                  child: Image.asset(ImageResource.ic_notifications, width: 20, height: 20),
                  onTap: (){
                    Get.toNamed(GetListPages.singleton.NOTIFICATION);
                  },
                )
              ],
            ),
            SizedBox(height: 15),
            Image.asset(ImageResource.logo1, width: Get.width * 0.5),

            Spacer(flex: 1),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                StringResource.thank_you,
                textAlign: TextAlign.center,
                style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14),
              ),
            ),
            SizedBox(height: 15),
            ButtonWidget.buttonBorder(context, "Public Users", onTap: (){
              Get.toNamed(GetListPages.singleton.PUBLIC_USER);
            }),
            SizedBox(height: 10),
            ButtonWidget.buttonNormal(context, "Partners", onTap: (){
              Get.toNamed(GetListPages.singleton.INPUT_CODE);
            }),
            SizedBox(height: 10),
            ButtonWidget.buttonNormal(context, "Partner Customer", onTap: (){
              Get.toNamed(GetListPages.singleton.PARTNER_CUSTOMER);
            })
          ],
        ),
      ),
    );
  }

}