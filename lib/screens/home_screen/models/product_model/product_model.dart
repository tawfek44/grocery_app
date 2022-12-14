import 'package:flutter/cupertino.dart';

class ProductModel{
  @required late String name,amount,address;
  @required late double price;
  @required double? offer;
  ProductModel({required this.name, required this.amount, required this.address, required this.price, required this.offer});

  toMap(){
    return {
      'name':name,
      'amount':amount,
      'address':address,
      'price':price,
      'offer':offer
    };
  }
}