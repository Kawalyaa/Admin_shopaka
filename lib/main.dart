import 'package:flutter/material.dart';
import 'screens/admin.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin(),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
