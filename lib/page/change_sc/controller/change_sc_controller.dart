import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ChangeSCBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeSCController());
  }

}

class ChangeSCController extends GetxController{

}