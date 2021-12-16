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
    List productsListKey = productsListMap.keys.toList();
    print(productsListKey);
    int counterListKey = 0;
    productsListData.forEach((product) {
      productsList.add(Product(
        ref: productsListKey[counterListKey],
        name: product["nom"],
        price: double.parse(product["prix"].toString()),
        available: product["available"]
      ));
      counterListKey++;
    });
    return productsList;
  }

  Future<void> updateAvailable(String reference, bool newValue) async {
    await firebaseDatabaseHelper.updateValue("products/$reference", "available", newValue);
    return;
  }
}