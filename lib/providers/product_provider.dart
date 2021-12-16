import 'package:afpa_demo_firebase/constants.dart';
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
    int counterListKey = 0;
    productsListData.forEach((product) {
      productsList.add(Product(
        ref: productsListKey[counterListKey],
        name: product[PRODUCT_NAME],
        price: double.parse(product[PRODUCT_PRICE].toString()),
        available: product[PRODUCT_AVAILABLE]
      ));
      counterListKey++;
    });
    return productsList;
  }

  Future<void> updateAvailable(String reference, bool newValue) async {
    await firebaseDatabaseHelper.updateValue("products/$reference", PRODUCT_AVAILABLE, newValue);
    return;
  }
  
  Future<void> setProduct() async {
    Product product = Product(
      name: "steak",
      price: 15,
      available: true,
      ref: "produit4"
    );
    firebaseDatabaseHelper.setObject("products/${product.ref}", product.toMap());
  }

  Future<void> removeProduct(Product product) async {
    await firebaseDatabaseHelper.deleteObject("products/${product.ref}");
    return;
  }
}