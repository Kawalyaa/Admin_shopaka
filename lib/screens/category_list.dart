import 'package:flutter/material.dart';
import 'package:shopla_ecommerce_app/db/category.dart';

import '../constants.dart';
class CategoryList extends StatefulWidget {
  static const String id = 'categoryList';
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List _categoryList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.5,
          iconTheme: IconThemeData(color: Colors.black45),
          title: Text('Categories', style: TextStyle(color: Colors.black45)),
        ),
        body: FutureBuilder<List>(future:CategoryServices().getCategories() ,builder:(context,AsyncSnapshot<List> snapshot){
          if(snapshot.hasError){
            return Center(
                child: Text(
                  'No Categories',
                  style: TextStyle(color: kColorRed, fontSize: 16.0),
                ),
              );
          }
          _categoryList = snapshot.data;
          return snapshot.hasData?ListView.builder(
            padding: EdgeInsets.symmetric(vertical:8.0,horizontal:5),
                itemCount: _categoryList.length,
                itemBuilder: (context, index) {
                  return _singleCategory(_categoryList[index]['categoryName']);
                }):Center(
                child: Text(
                  'Loading.....',
                  style: TextStyle(color: kColorRed, fontSize: 16.0),
                ),
              );
        } ,));



  }
   Padding _singleCategory(String brand) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(brand,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
    );
   }
}