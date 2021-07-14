import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopla_ecommerce_app/components/single_product.dart';
import 'package:shopla_ecommerce_app/constants.dart';
import 'package:shopla_ecommerce_app/db/products.dart';
import 'package:shopla_ecommerce_app/model/products_model.dart';

class ProductsScreen extends StatefulWidget {
  static const String id = 'productsScreen';
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductService productService = ProductService();

  //  @override
  // void initState() {
  //   super.initState();
  //   loadProducts();
  // }


  List<ProductModel> allProducts = [];

  // loadProducts() async {

  //       allProducts = await productService.getProducts();

  // }

 

  @override
  Widget build(BuildContext context) {
    allProducts = Provider.of<List<ProductModel>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: allProducts.isEmpty
          ? Center(
              child: Container(
                height: 100,
                child: Text(
                  'No Data',
                  style: TextStyle(
                      color: kColorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
            )
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
              itemCount: allProducts.length,
              itemBuilder: (context, index) => SingleProduct(
                    name: allProducts[index].name,
                    images: allProducts[index].images,
                    price: allProducts[index].price,
                    oldPrice: allProducts[index].oldPrice,
                    deleteCallback: ()async{
                      await productService.removeProduct(allProducts[index].id);
                    },
                  )),
    );
  }
}
