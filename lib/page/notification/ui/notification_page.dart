
import 'package:eqinsurance/page/loading/loading_page.dart';
import 'package:eqinsurance/page/notification/controller/notification_controller.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<NotificationController>{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                controller.onBack();
              },
            ),
            SizedBox(width: 20),
            Container(
              alignment: Alignment.center,
              child: Text("Notifications", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Spacer(flex: 1),
            Obx(() => Visibility(
              visible: !controller.isSelected.value,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                      "Select",
                      style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)
                  ),
                ),
                onTap: (){
                  controller.onSelectListener();
                },
              ),
              replacement: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          "Cancel",
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)
                      ),
                    ),
                    onTap: (){
                      controller.onSetSelect();
                    },
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: (){
                      if(controller.isSelected.value){
                        controller.onDeleteNotificationItem(context);
                      }
                    },
                    child: Container(
                      child: Image.asset(ImageResource.ic_trash, width: 16),
                    ),
                  )
                ],
              ),
            )),
            SizedBox(width: 10)
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.all(7),
              child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Obx(() => Visibility(
                    visible: controller.listNotification.length > 0,
                    child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: controller.listNotification.length,
                        itemBuilder: (ctx, index){
                          if(index == (controller.listNotification.length - 1) && controller.isLoadMore.value){
                            return GestureDetector(
                              onTap: (){
                                controller.loadMoreData();
                              },
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorResource.link_text,
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                                child: Text(
                                  'Read more',
                                  style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }
                          return GestureDetector(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Obx(() => Visibility(
                                              visible: controller.isSelected.value,
                                              child: controller.selectedCheckbox(controller.listNotification[index].isCheck.value),
                                              replacement: SizedBox(height: 12)
                                          )),
                                          SizedBox(height: 2),
                                          Obx(() => Image.asset(
                                              !controller.listNotification[index].isRead.value
                                                  ? ImageResource.unread_notification : ImageResource.read_notification,
                                              width: 30, height: 30)
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              '${controller.listNotification[index].subject}',
                                              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 17, color: ColorResource.color_title_popup, fontWeight: FontWeight.w400),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 1,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              '${controller.listNotification[index].message}',
                                              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 17, color: ColorResource.page_title_textColor, fontWeight: FontWeight.w400),
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
                            ),
                            onTap: (){
                              controller.onSelectItem(index);
                            },
                          );
                        },
                      ),
                      onRefresh: () => controller.refreshNotification(),
                    ),
                    replacement: Stack(
                      children: [
                        Center(
                          child: Text(
                              "No notification data available",
                              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 17, color: ColorResource.color_title_popup, fontWeight: FontWeight.w400)),
                        ),
                        RefreshIndicator(
                          child: ListView(),
                          onRefresh: () => controller.refreshNotification(),
                        )
                      ],
                    ),
                  ))
              ),
            ),
            Obx(() => LoadingPage(isLoading: controller.isLoading.value))
          ],
        ),
      ),
      onWillPop: () async{
        controller.onBack();
        return true;
      },
    );
  }

}