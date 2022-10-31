
import 'package:eqinsurance/page/notification/controller/notification_detail_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailPage extends GetView<NotificationDetailController>{
  const NotificationDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.color_bg_settings,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorResource.color_appbar_settings,
        actions: [
          SizedBox(width: 20),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Image.asset(ImageResource.arrow_back_notification, width: 20)
            ),
            onTap: (){
              Get.back();
            },
          ),
          SizedBox(width: 20),
          Container(
            alignment: Alignment.center,
            child: Text("NotificationDetails"),
          ),
          Spacer(flex: 1),
          Container(
            alignment: Alignment.center,
            child: Image.asset(ImageResource.ic_trash, width: 20)
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(7),
        child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('For Everyone Subject 2'),
                SizedBox(height: 15),
                Text('07/08/2018'),
                SizedBox(height: 20),
                Text('On test-english.com you will find lots of free practice tests and materials to help you improve your '),
              ],
            )
        ),
      ),
    );
  }

}