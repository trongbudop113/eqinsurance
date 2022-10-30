import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }

}

class NotificationController extends GetxController{

}