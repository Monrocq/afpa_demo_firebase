import 'package:afpa_demo_firebase/helpers/firebase_database_helper.dart';
import 'package:afpa_demo_firebase/models/product.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductProvider {
  final FirebaseDatabaseHelper firebaseDatabaseHelper;
  ProductProvider({required this.firebaseDatabaseHelper});

  Future<List<Product>> getProducts() async {
    List<Product> productsList = [];
    DataSnapshot dataSnapshot = await firebaseDatabaseHelper.getObject("products");
    Object? productsValue = dataSnapshot.value;
    Map productsListMap = productsValue as Map;
    List productsListData = productsListMap.values.toList();
    productsListData.forEach((product) {
      productsList.add(Product(
        name: product["nom"],
        price: double.parse(product["prix"].toString())
      ));
    });
    return productsList;
  }
}