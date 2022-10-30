import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class InputCodeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => InputCodeController());
  }

}

class InputCodeController extends GetxController{

}