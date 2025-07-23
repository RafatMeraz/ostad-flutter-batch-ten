import 'package:get/get.dart';
import 'counter_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}