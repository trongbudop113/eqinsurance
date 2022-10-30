import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }

}

class ContactUsController extends GetxController{

}