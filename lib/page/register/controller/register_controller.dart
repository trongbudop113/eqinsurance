import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }

}

class RegisterController extends GetxController{

}