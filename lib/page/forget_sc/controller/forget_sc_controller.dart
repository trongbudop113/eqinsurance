import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ForgetSCBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetSCController());
  }

}

class ForgetSCController extends GetxController{

}