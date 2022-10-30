import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }

}

class SettingsController extends GetxController{

}