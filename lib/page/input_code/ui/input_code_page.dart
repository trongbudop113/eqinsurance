
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/input_code/controller/input_code_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputCodePage extends GetView<InputCodeController>{
  const InputCodePage({Key? key}) : super(key: key);

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

            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Security Code'),
            ),
            SizedBox(height: 10),
            TextFieldWidget(onSubmit: (value){

            }, hint: "Enter Current Security Code",
            controller: controller.scText,
            isShowLeftIcon: true,
            leftIcon: ImageResource.key),

            Spacer(flex: 1),
            Row(
              children: [
                SizedBox(width: 15),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(GetListPages.FORGET_SC);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Text(
                        'Forget Security Code',
                        style: StyleResource.TextStyleBlack(context).copyWith(
                            decoration: TextDecoration.underline,
                            color: ColorResource.color_appbar_settings
                        )
                    ),
                  ),
                ),
                Spacer(flex: 1),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(GetListPages.CHANGE_SC);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Text(
                        'Change Security Code',
                        style: StyleResource.TextStyleBlack(context).copyWith(
                          decoration: TextDecoration.underline,
                        )
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
            ButtonWidget.buttonNormal(context, "Next", onTap: (){
              controller.onSubmitLoginAgentCode();
            })
          ],
        ),
      ),
    );
  }

}