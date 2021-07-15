import 'package:flutter/material.dart';
import 'package:shopla_ecommerce_app/db/products.dart';
import 'package:shopla_ecommerce_app/db/user_service.dart';
import 'package:shopla_ecommerce_app/model/products_model.dart';
import 'package:shopla_ecommerce_app/model/user_model.dart';
import 'package:shopla_ecommerce_app/screens/products_screen.dart';
import 'package:shopla_ecommerce_app/screens/users_screen.dart';
import 'screens/admin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<ProductModel>>(
            create: (_) => ProductService().getAllProducts(), initialData: []),
        StreamProvider<List<UserModel>>(
            create: (_) => UserServices().getUsers(), initialData: [])
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Admin(),
        theme: ThemeData(primarySwatch: Colors.red),
        routes: {
          ProductsScreen.id: (context) => ProductsScreen(),
          UsersList.id: (context) => UsersList()
        },
      ),
    );
  }
}
