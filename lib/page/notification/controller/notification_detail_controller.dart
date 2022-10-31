import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class NotificationDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationDetailController());
  }

}

class NotificationDetailController extends GetxController{

}