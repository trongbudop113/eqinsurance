
import 'package:eqinsurance/configs/device_info_config.dart';
import 'package:eqinsurance/resource/color_resource.dart';
import 'package:eqinsurance/resource/image_resource.dart';
import 'package:eqinsurance/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconNotificationWidget extends StatelessWidget {
  final VoidCallback onTap;
  const IconNotificationWidget ({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Obx(() => Container(
          color: Colors.transparent,
          width: 25,
          height: 25,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Image.asset(ImageResource.ic_notifications, width: 20, height: 20)
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                  visible: DeviceInfoConfig.singleton.countNotification.value > 0,
                  replacement: SizedBox(width: 15, height: 15),
                  child: Container(
                    width: 15,
                    height: 15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(120)),
                        color: ColorResource.color_bg_notify
                    ),
                    child: Text(DeviceInfoConfig.singleton.countNotification.value.toString(), style: StyleResource.TextStyleBlack(context).copyWith(color: Colors.white, fontSize: 10, height: 1)),
                  ),
                ),
              )
            ],
          ),
        )),
        onTap: onTap
    );
  }
}
