import 'dart:convert';
import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/home_screen/controller/home_controller.dart';
import 'package:grocery_app/screens/home_screen/models/category_model/category_model.dart';
import 'package:grocery_app/screens/home_screen/models/product_model/product_model.dart';
import 'package:grocery_app/utils/colors/colors.dart';
import 'package:grocery_app/utils/dummy/category_dummy_data.dart';
import 'package:grocery_app/utils/dummy/products_dummy_data.dart';
import 'package:grocery_app/utils/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';

Widget getTopPage() =>  Padding(
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
              "Mustafa St.",
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

Widget searchSection( {
  required String label,
  required Widget prefixIcon,
  required TextInputType type,
}) => TextFormField(
  decoration: InputDecoration(
    fillColor: Colors.grey[100],
    filled: true,
    hintText:  label,
    border: InputBorder.none,
    prefixIcon: prefixIcon,
  ),
  keyboardType: type,

);

Widget addressItem({
  required String name,
  required String address
}) => Container(
  color: HexColor('#ffffff'),

  child: Expanded(
    child: Container(
      padding:const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: HexColor('#d7d7d7'),
              borderRadius:const BorderRadiusDirectional.all(Radius.circular(10))
            ),
            width: 39.0,
            height: 38.0,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    name,
                  overflow: TextOverflow.fade, softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),
                Text(
                  address,
                  style:const TextStyle(
                    fontSize: 10
                  ),

                )
                ,
              ],
            ),
          )

        ],
      ),
    ),
  ),
);

Widget addressSection() =>
    Row(
      children: [
        Expanded(child: addressItem(name: 'Home Address',address: 'Mustafa St.No2 street x12')),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: addressItem(name: 'Office Address',address: 'Axis Istanbul B2 blok Floor2 Office 11')),


      ],

    );


List<CategoryModel> getCategoryData(){
  return GetCategoryDummyData.getCategories();
}
List<CategoryModel> categoryDataList=getCategoryData();
Widget categoryItem(index)=>Column(
  children: [
    Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: categoryColors[index],
        borderRadius: BorderRadius.circular(20)
      ),
    ),
    const SizedBox(height: 5,),
    Text(
      categoryDataList[index].name,
        style: TextStyle(
          color: Colors.black54
        ),
    ),
  ],
);


Widget categorySection() =>
    Container(
      height: 120,
      child: Flex(
        direction: Axis.vertical,
  children: [
      Row(
        children: const [
          Text('Explore by category',
            style:  TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Text(
            'See All(36)',
            style: TextStyle(
              color: Colors.grey
            ),
          )
        ],
      ),
      const SizedBox(height: 10.0,),


  Expanded(
      child: ListView.separated(
        itemBuilder: (context,index) => categoryItem(index),
        separatorBuilder: (context,index) => const SizedBox(width: 13.0,),
        itemCount: categoryDataList.length,
        scrollDirection: Axis.horizontal,

        physics: const BouncingScrollPhysics(),
      ),
    ),
  ],
  ),
);




List<ProductModel> getProductData(){
  return GetProductDummyData.getProducts();
}
List<ProductModel> productDataList=getProductData();
Widget productItem(index)=>Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: categoryColors[index],
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        GetBuilder<HomeController>(
          builder: (HomeController controller) {
            return Container(
              width: 34,
              height: 34,
              child: FloatingActionButton(
                onPressed: (){
                  if(controller.productsInCart[productDataList[index].name]!=null||
                      CacheHelper.getData(productDataList[index].name)!=null) {
                    if(controller.productsInCart[productDataList[index].name]!=null)
                      {
                        controller.deleteFromProductInCart(productDataList[index]);
                      }
                    else{
                      String x=CacheHelper.getData(productDataList[index].name);
                      Map result= jsonDecode(x);
                      ProductModel pr =ProductModel(
                          name: result["name"],
                          amount: result["amount"],
                          address: result["address"],
                          price: result["price"],
                          offer: result["offer"],
                      );
                      controller.deleteFromProductInCart(pr);
                    }
                  }
                  else{
                      controller.putProductInCart(productDataList[index]);
                  }
                },
                backgroundColor: Colors.white,
                child:  index!=null&&controller.productsInCart[productDataList[index].name]==null&&
                 CacheHelper.getData(productDataList[index].name)==null?
                const Icon(Icons.favorite_border,color: Colors.grey,size: 15,):
                const Icon(Icons.favorite_outlined,color: Colors.red,size: 15,),

              ),
            );
          },

        )
      ],
    ),
    const SizedBox(
      width: 10.0,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          productDataList[index].name,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          productDataList[index].amount,
          style: const TextStyle(
           color: Colors.grey,
            fontSize: 12.0
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
              size: 12,
            ),
            Text(
              productDataList[index].address,
              style:const TextStyle(
                color: Colors.grey,
                fontSize: 12.0
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
       ConditionalBuilder(
         condition: productDataList[index].offer!=null,
         builder: (context) => Row(
           children: [
             Text(
               '\$${productDataList[index].offer}',

               style: TextStyle(
                 color: mainColor,
                 fontWeight: FontWeight.bold,

               ),

             ),
             const SizedBox(
               width: 8.0,
             ),
             Text(
               '\$${productDataList[index].price}',
               style: const TextStyle(
                   color: Colors.grey,
                   decoration: TextDecoration.lineThrough
               ),
             ),
           ],
         ),
         fallback: (context)=>Row(
           children: [
             Text(
               '\$${productDataList[index].price}',

               style: TextStyle(
                 color: mainColor,
                 fontWeight: FontWeight.bold,

               ),

             ),
           ],
         ),
       )
       ,
        const SizedBox(
          height: 5,
        ),

      ],
    ),
  ],
);


Widget productSection() =>
    Container(
      height: 120,
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Deals with d:',
            style:  TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10.0,),


          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index) => Expanded(child: productItem(index)),
              separatorBuilder: (context,index) => const SizedBox(width: 20.0,),
              itemCount: productDataList.length,
              scrollDirection: Axis.horizontal,

              physics: const BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );

Widget advertiseSection()=>Container(
  height: 141,
  width: double.infinity,
  decoration: BoxDecoration(
    color:HexColor('#fec8bd'),
    borderRadius: BorderRadius.circular(20)
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children:  [
              const Text(
              'Mega',
               style: TextStyle(
                 color: Colors.deepOrange,
                 fontSize: 11.0
               ),
            ),
              Row(
               children: [
                 Stack(
                   clipBehavior: Clip.none,
                   alignment:AlignmentDirectional.centerEnd ,
                   children: [
                     Text(
                       'WHOPP',
                       style: TextStyle(
                           color: HexColor('#21114b'),
                           fontWeight: FontWeight.bold,
                           fontSize: 31.0
                       ),
                     ),

                     Positioned(
                       right: -10,
                       child: Text(
                         'E',

                         style: TextStyle(
                           color: HexColor('#d13a27'),
                           fontWeight: FontWeight.bold,
                           fontSize: 31.0,
                         ),
                       ),
                     )
                   ],
                 ),
                 SizedBox(
                   width: 10.0,
                 ),
                 Text(
                   'R',

                   style: TextStyle(
                     color: HexColor('#21114b'),
                     fontWeight: FontWeight.bold,
                     fontSize: 31.0,
                   ),
                 )


               ],
             ),
             const SizedBox(
               height: 13,
             ),
             Row(
               children: const [
                 Text(
                   '\$ 17',
                   style: TextStyle(
                       color: Colors.deepOrange,
                       fontSize: 17.0,
                       fontWeight: FontWeight.bold
                   ),
                 ),
                 SizedBox(
                   width: 30.0,
                 ),
                 Text(
                   '\$ 32',
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 17.0,
                     fontWeight: FontWeight.bold,
                     decoration: TextDecoration.lineThrough
                   ),
                 ),

               ],
             ),
             const SizedBox(
               height: 13,
             ),
             const Text(
               '* Available until 24 December 2020',
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 9.0,
                   fontWeight: FontWeight.bold,
               ),
             )


           ],
        ),
      ),
    ],
  ),
);



