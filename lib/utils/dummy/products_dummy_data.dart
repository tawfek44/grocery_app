import 'package:grocery_app/screens/home_screen/models/product_model/product_model.dart';


abstract class GetProductDummyData{
  static List<ProductModel> productList = [];
  // here i get the data from database(dummy data)
  // and i best practiced a Single Responsibility here,
  // this class make one and only thing.
  static List<ProductModel> getProducts(){
    productList=[];
    productList.add(ProductModel(name: "Summer Sun Ice Cream", amount: "5 Pieces",
        address: "15 Minutes AWC", price: 18,offer: 12));

    productList.add(ProductModel(name: "Turkish Steak", amount: "173 Grams",
        address: "San Fransisco", price: 25,offer: null));

    productList.add(ProductModel(name: "Salmon", amount: "2 Serving",
        address: "Manchester", price: 40,offer: 30));

    productList.add(ProductModel(name: "Red Juice", amount: "1 bottle",
        address: "Texas", price: 25,offer: null));

    productList.add(ProductModel(name: "Cola", amount: "1 bottle",
        address: "California", price: 15,offer: 11));

    return productList;
  }
}