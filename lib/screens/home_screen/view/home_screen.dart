import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/cart_screen/controller/cart_controller.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constants_ui_components/home_component_constances.dart';

class HomeScreen extends GetView<HomeController>{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController.cartController().getCachedItems();
    return  Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:  [
              getTopPage(),
              searchSection(
                  label: "Search in Thousands of Products",
                  prefixIcon:const Icon(Icons.search),
                  type: TextInputType.text
              ),
              const SizedBox(height: 20,),
              addressSection(),
              const SizedBox(height: 20,),
              categorySection(),
              const SizedBox(height: 20,),
              productSection(),
              const SizedBox(height: 20,),
              advertiseSection(),



            ],
          ),
        ),
      ),
    );
  }

}