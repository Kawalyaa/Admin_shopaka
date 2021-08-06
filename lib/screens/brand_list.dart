import 'package:flutter/material.dart';
import 'package:shopla_ecommerce_app/constants.dart';
import 'package:shopla_ecommerce_app/db/brand.dart';

class BrandList extends StatefulWidget {
  static const String id = 'brandList';
  @override
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  List _brandList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.5,
          iconTheme: IconThemeData(color: Colors.black45),
          title: Text('Brands', style: TextStyle(color: Colors.black45)),
        ),
        body: FutureBuilder<List>(
          future: BrandServices().getBrand(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'No Brands',
                  style: TextStyle(color: kColorRed, fontSize: 16.0),
                ),
              );
            }
            _brandList = snapshot.data;
            return snapshot.hasData
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                    itemCount: _brandList.length,
                    itemBuilder: (context, index) {
                      return _singleBrand(_brandList[index]['BrandName']);
                    })
                : Center(
                    child: Text(
                      'Loading.....',
                      style: TextStyle(color: kColorRed, fontSize: 16.0),
                    ),
                  );
          },
        ));
  }

  Padding _singleBrand(String brand) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        brand,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
