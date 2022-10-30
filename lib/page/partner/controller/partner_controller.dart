import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class PartnerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerController());
  }

}

class PartnerController extends GetxController{

}