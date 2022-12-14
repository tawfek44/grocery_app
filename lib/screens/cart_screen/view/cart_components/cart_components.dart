import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/cart_screen/controller/cart_controller.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils/colors/colors.dart';

Widget getTopPageCart() =>  Padding(
  padding: const EdgeInsets.symmetric(vertical: 30),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding:const EdgeInsetsDirectional.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(50),
            topRight: Radius.circular(100),
          ),
          color: mainColor,
        ),
        child: Row(
          children:const[
            Icon(Icons.location_on_outlined,color: Colors.white,),
            Text(
              "Oxford Street",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,

              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
            )
          ],
        ),
      ),

      Container(
        margin: const EdgeInsetsDirectional.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: HexColor('5a7081')
        ),
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
      )
    ],
  ),
);

Widget cartSection(){
  HomeController homeController =Get.find();
  CartController cartController=Get.find();
  return Expanded(
    child:Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cart', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0
        ),
        ),
        Expanded(
          child:GetBuilder<CartController>(
            builder: (controller){
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) {
                  return cartItem(index);
                },
                separatorBuilder: (context,index) => const SizedBox(height: 25.0,),
                itemCount:homeController.productsInCartList.isEmpty?
                cartController.inCartCachedList.length:
                homeController.productsInCartList.length,
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget cartItem(index){
  HomeController homeController=Get.find();
  CartController cartController=Get.find();
  return Expanded(
    child: Row(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
              color: categoryColors[index],
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
         Container(
          width: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(homeController.productsInCartList.isEmpty?
                  cartController.inCartCachedList[index].name:
                  homeController.productsInCartList[index].name
                ,
                maxLines:2,
                overflow: TextOverflow.ellipsis,
                style:
                const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height:5.0,),
              Text(homeController.productsInCartList.isEmpty?
              cartController.inCartCachedList[index].amount:
              homeController.productsInCartList[index].amount
                ,style: const TextStyle(
                  color: Colors.grey
              ),
              ),
              const SizedBox(height:5.0,),
              Text(homeController.productsInCartList.isEmpty?
              '\$${cartController.inCartCachedList[index].price}':
              '\$${homeController.productsInCartList[index].price}',
                style: TextStyle(
                  color: HexColor('#b13e55'),
                  fontSize: 18
              ),
              ),

            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        const Spacer(),
        Row(
          children: [
            //button munis
            SizedBox(
              width: 43,
              height: 43,
              child: ElevatedButton(
                style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<HexColor>(HexColor('#b0eafd')),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.5)
                        )
                    )
                ) ,
                onPressed: (){
                  cartController.minus(index);
                },
                child: Center(child: Icon(CupertinoIcons.minus,size: 28.0,color: HexColor('#48b6da'),)),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            GetBuilder<CartController>(
             builder: (controller){
               return Text(controller.quantities[index].toString(),
                 style: const TextStyle(
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold
                 ),);
             },
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: 43,
              height: 43,
              child: ElevatedButton(
                style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<HexColor>(HexColor('#b0eafd')),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.5)
                        )
                    )
                ) ,

                onPressed: (){
                  cartController.plus(index);
                },
                child: Center(child: Icon(CupertinoIcons.plus,size: 28.0,color: HexColor('#48b6da'),)),
              ),
            ),
          ],
        )
      ],
    ),
  );
}