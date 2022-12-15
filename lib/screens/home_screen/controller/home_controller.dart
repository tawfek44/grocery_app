import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grocery_app/screens/cart_screen/controller/cart_controller.dart';
import 'package:grocery_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:grocery_app/screens/home_screen/models/product_model/product_model.dart';
import 'package:grocery_app/utils/local/cache_helper.dart';

import '../../../utils/dummy/category_dummy_data.dart';
import '../../../utils/dummy/products_dummy_data.dart';
import '../models/category_model/category_model.dart';

class HomeController extends GetxController{

  static HomeController homeController()=>Get.find<HomeController>();
  List<CategoryModel> categoryList=[];
  void getCategories(){
    categoryList = GetCategoryDummyData.getCategories();
  }

  List<ProductModel> productList=[];
  void getProducts(){
    productList=[];
    productList = GetProductDummyData.getProducts();
  }
  Map<String,ProductModel>productsInCart={};
  List<ProductModel>productsInCartList=[];
  void putProductInCart(ProductModel pr){
    productsInCart[pr.name]=pr;
    productsInCartList.add(pr);

    String productObjectString= jsonEncode(pr.toMap());
    CacheHelper.saveData(key: pr.name, value: productObjectString);
    getProducts();
    CartController.cartController().quantities=[];
    for (var element in productList) {
      if(CacheHelper.getData(element.name)!=null){
        CartController.cartController().quantities.add(1);
      }
    }
    DashboardController.dashboardController().getSumInCart();
    update();
  }

  void deleteFromProductInCart(ProductModel pr){
   productsInCart.remove(pr.name);
   productsInCartList=[];
   CartController.cartController().quantities=[];
   CacheHelper.removeData(pr.name);
   for (var element in productList) {
     if(CacheHelper.getData(element.name)!=null){
       productsInCartList.add(element);
       CartController.cartController().quantities.add(1);
     }
   }
   DashboardController.dashboardController().getSumInCart();
    update();
  }

}