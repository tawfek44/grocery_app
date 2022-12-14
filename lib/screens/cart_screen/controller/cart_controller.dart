import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:grocery_app/utils/local/cache_helper.dart';
import '../../home_screen/models/product_model/product_model.dart';

class CartController extends GetxController{
  static CartController cartController()=>Get.find<CartController>();

  HomeController homeController = Get.find();
  List<ProductModel>inCartCachedList=[];
  List<int> quantities=[];
  void getCachedItems(){
    quantities=[];
    inCartCachedList=[];
    homeController.getProducts();
    for (var element in homeController.productList) {
      if(CacheHelper.getData(element.name)!=null){
        inCartCachedList.add(element);
        quantities.add(1);
      }
    }}
  void plus(index){
    quantities[index]++;
    update();
  }
  void minus(index){
    if(quantities[index]>1)
      {
        quantities[index]--;
        update();
      }
  }


}