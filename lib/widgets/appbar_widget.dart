import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/public_user/controller/public_user_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarWidget{
  static PreferredSizeWidget appBarContact(BuildContext context) {
    return AppBar(
        toolbarHeight: 56,
        automaticallyImplyLeading: false,
        backgroundColor: ColorResource.color_button_user,
        elevation: 0,
        actions: [
          Expanded(
            child: Container(
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
                    Text("Contact Us", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 18)),
                    Spacer(flex: 1),
                    SizedBox(width: 27)
                  ],
                )
            ),
          )
        ],
    );
  }

  static PreferredSizeWidget appBarPublicUser(BuildContext context, PublicUserController controller) {
    return AppBar(
      toolbarHeight: 56,
      automaticallyImplyLeading: false,
      backgroundColor: ColorResource.color_button_user,
      elevation: 0,
      actions: [
        Expanded(
          child: Container(
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
                      child: Image.asset(ImageResource.ic_back, width: 12),
                    ),
                  ),
                  SizedBox(width: 64),
                  Spacer(flex: 1),
                  Text("EQ Insurance", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 18)),
                  Spacer(flex: 1),
                  GestureDetector(
                    child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                    onTap: (){
                      Get.toNamed(GetListPages.CONTACT_US);
                    },
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    child: Image.asset(ImageResource.ic_notifications, width: 20, height: 20),
                    onTap: (){
                      Get.toNamed(GetListPages.NOTIFICATION);
                    },
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    child: Image.asset(ImageResource.home2, height: 18, fit: BoxFit.fitHeight,),
                    onTap: (){

                    },
                  ),
                  SizedBox(width: 15),
                ],
              )
          ),
        )
      ],
    );
  }
}