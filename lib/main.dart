import 'package:afpa_demo_firebase/helpers/firebase_database_helper.dart';
import 'package:afpa_demo_firebase/providers/product_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/product.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase database = FirebaseDatabase.instance;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase Demo', database: database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.database}) : super(key: key);

  final String title;
  final FirebaseDatabase database;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseDatabaseHelper _firebaseDatabaseHelper;

  @override
  Widget build(BuildContext context) {
    ProductProvider _productProvider = ProductProvider(firebaseDatabaseHelper: FirebaseDatabaseHelper(database: widget.database));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder(
          future: _productProvider.getProducts(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              //print(snapshot.data);
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SwitchListTile(
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(snapshot.data![index].price.toString()+'€'),
                        value: snapshot.data![index].available,
                        onChanged: (bool value) {
                          setState(() {
                            snapshot.data![index].available = value;
                            _productProvider.updateAvailable(snapshot.data![index].ref, value);
                          });
                        },
                    );
                  }
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }
            return CircularProgressIndicator();
          },
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
