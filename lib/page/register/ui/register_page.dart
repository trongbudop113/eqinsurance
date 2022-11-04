
import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/page/register/page/verify_phone_page.dart';
import 'package:eqinsurance/page/register/page/verify_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterPage extends GetView<RegisterController>{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(() => Stack(
        children: [
          Container(
            child:  controller.currentIndex == 0
                ? VerifyUserPage(controller: controller)
                : VerifyPhonePage(controller: controller),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.listCountPage.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex == entry.key ? Colors.brown : Colors.grey
                  ),
                );
              }).toList(),
            ),
          )
        ],
      )),
      onWillPop: () async{
        return true;
      },
    );
  }

}