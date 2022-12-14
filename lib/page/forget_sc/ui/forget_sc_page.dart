import 'package:eqinsurance/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsurance/page/loading/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ForgetSCPage extends GetView<ForgetSCController>{
  const ForgetSCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() => Stack(
          children: [
            controller.getWidgetContent(),
            Obx(() => LoadingPage(isLoading: controller.isLoading.value))
          ],
        )),
      ),
      onTap: (){
        controller.hideKeyboard(context: context);
      },
    );
  }

}