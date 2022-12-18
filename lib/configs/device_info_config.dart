import 'package:get/get.dart';

class DeviceInfoConfig {
  static final DeviceInfoConfig singleton = DeviceInfoConfig._internal();

  factory DeviceInfoConfig() {
    return singleton;
  }

  DeviceInfoConfig._internal();

  HeightAppbar heightAppbar = HeightAppbar(heightTop: 25, heightBody: 56);

  final RxInt countNotification = 0.obs;
}

class HeightAppbar {
  double heightTop;
  double heightBody;
  HeightAppbar({required this.heightTop, required this.heightBody});
}