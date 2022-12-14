import 'package:get/get.dart';
import 'package:grocery_app/screens/cart_screen/controller/cart_controller.dart';
import 'package:grocery_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';

import 'local/cache_helper.dart';

class BindingClass implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(),fenix: true);
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => CartController(),fenix: true);

    CacheHelper.init();
  }

}