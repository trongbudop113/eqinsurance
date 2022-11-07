
import 'package:eqinsurance/page/notification/controller/notification_detail_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailPage extends GetView<NotificationDetailController>{
  const NotificationDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                Get.back(result: false);
              },
            ),
            SizedBox(width: 20),
            Container(
              alignment: Alignment.center,
              child: Text("NotificationDetails", style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20, color: Colors.white)),
            ),
            Spacer(flex: 1),
            GestureDetector(
              onTap: (){
                controller.onDeleteNotification(context);
              },
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Image.asset(ImageResource.ic_trash, width: 18)
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.all(7),
          child: Obx(() => Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${controller.notificationRes.value.subject ?? ''}"),
                  SizedBox(height: 15),
                  Text('${controller.notificationRes.value.messageDate}'),
                  SizedBox(height: 20),
                  Text('${controller.notificationRes.value.message}'),
                ],
              )
          )),
        ),
      ),
      onWillPop: () async{
        Get.back(result: false);
        return true;
      },
    );
  }

}