import '../../screens/home_screen/models/category_model/category_model.dart';

abstract class GetCategoryDummyData{
  static List<CategoryModel> categoriesList = [];
  // here i get the data from database(dummy data) and i best practiced a Single Responsibility here,
  // this class make one and only thing.
  static List<CategoryModel> getCategories(){
    categoriesList.add(CategoryModel(name: "Steak"));
    categoriesList.add(CategoryModel(name:"Vegetables"));
    categoriesList.add(CategoryModel(name:"Beverages"));
    categoriesList.add(CategoryModel(name:"Fish"));
    categoriesList.add(CategoryModel(name:"Juice"));
    return categoriesList;
  }
}