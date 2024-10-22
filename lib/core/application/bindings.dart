

import 'package:get/get.dart';
import 'package:myapp/module/controller/memes_controller.dart';

class SBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemesController());
  }
}