
import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/page/notification/controller/notification_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<NotificationController>{
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.color_bg_settings,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResource.color_appbar_settings,
        automaticallyImplyLeading: false,
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
            child: Text("Notification"),
          ),
          Spacer(flex: 1),
          Container(
            alignment: Alignment.center,
            child: Text("Select"),
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
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (ctx, index){
              return GestureDetector(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(ImageResource.read_notification, width: 25, height: 25),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 10,
                          child: Column(
                            children: [
                              Text(
                                'On test-english.com you will find lots of free practice tests and materials to help you improve your ',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                              SizedBox(height: 2),
                              Text(
                                '(2) On test-english.com you will find lots of free practice tests and materials to help you improve your ',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Divider()
                  ],
                ),
                onTap: (){
                  Get.toNamed(GetListPages.singleton.NOTIFICATION_DETAIL);
                },
              );
            },
          )
        ),
      ),
    );
  }

}