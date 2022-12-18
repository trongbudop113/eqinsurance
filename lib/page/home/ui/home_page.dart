
import 'package:eqinsurance/configs/config_button.dart';
import 'package:eqinsurance/configs/device_info_config.dart';
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/home/controller/home_controller.dart';
import 'package:eqinsurance/page/loading/loading_page.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/string_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:eqinsurance/widgets/button_widget.dart';
import 'package:eqinsurance/widgets/icon_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                SizedBox(height: controller.heightAppbar.heightTop),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(flex: 1),
                    GestureDetector(
                      child: Container(
                          color: Colors.transparent,
                          child: Image.asset(ImageResource.ic_settings, width: 20, height: 20)
                      ),
                      onTap: (){
                        controller.goToSetting();
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                      ),
                      onTap: (){
                        controller.getContactInfo();
                      },
                    ),
                    SizedBox(width: 10),
                    IconNotificationWidget(
                      onTap: (){
                        controller.goToNotification();
                      },
                    )
                  ],
                ),
                SizedBox(height: 20),
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
                Obx(() => Column(
                  children: [
                    Visibility(
                      visible: ConfigButton.singleton.isPublicUser.value,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Visibility(
                            visible: ConfigButton.singleton.isPublicUserType.value == 0,
                            child: ButtonWidget.buttonBorder(context, "Public Users", onTap: (){
                              controller.getPublicUser();
                            }),
                            replacement: ButtonWidget.buttonNormal(context, "Public Users", onTap: (){
                              controller.getPublicUser();
                            })
                        ),
                      ),
                    ),
                    Visibility(
                        visible: ConfigButton.singleton.isPartner.value,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Visibility(
                            visible: ConfigButton.singleton.isPartnerType.value == 0,
                            child: ButtonWidget.buttonBorder(context,  "Partners", onTap: (){
                              controller.goToPartnerPage();
                            }),
                            replacement: ButtonWidget.buttonNormal(context, "Partners", onTap: (){
                              controller.goToPartnerPage();
                            }),
                          ),
                        )
                    ),
                    Visibility(
                        visible: ConfigButton.singleton.isPartnerCustomer.value,
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Visibility(
                              visible: ConfigButton.singleton.isPartnerCustomerType.value == 0,
                              child: ButtonWidget.buttonBorder(context,  "Partner Customer", onTap: (){
                                controller.goToPartnerCustomer();
                              }),
                              replacement: ButtonWidget.buttonNormal(context, "Partner Customer", onTap: (){
                                controller.goToPartnerCustomer();
                              }),
                            )
                        )
                    ),
                  ],
                ))
              ],
            ),
          ),
          Obx(() => LoadingPage(isLoading: controller.isLoading.value))
        ],
      ),
    );
  }

}