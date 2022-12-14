import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:grocery_app/utils/local/cache_helper.dart';

import '../../../utils/constants_ui_components/home_component_constances.dart';
import '../controller/cart_controller.dart';
import 'cart_components/cart_components.dart';

class CartScreen extends GetView<CartController>{
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController=Get.find();
    cartController.getCachedItems();
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            getTopPageCart(),
            const SizedBox(
              height: 20.0,
            ),
            cartSection(),



          ],
        ),
      ),
    );
  }

}