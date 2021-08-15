import 'package:flutter/material.dart';

import '../constants.dart';

class SingleProduct extends StatelessWidget {
  final String id;
  final String name;
  final String brand;
  final String category;
  final List images;
  final int price;
  final int oldPrice;
  final int quantity;
  final List colors;
  final String color;
  final List sizes;
  final List similarProduct;
  final Function deleteCallback;
  final bool featured;
  final Function toggleFavorite;
  final Widget placeholder;
  final heroTag;
  final List description;
  final List keyFeatures;
  Function toggleFeatured;

  SingleProduct({
    this.id,
    this.name,
    this.heroTag,
    this.brand,
    this.category,
    this.images,
    this.price,
    this.oldPrice,
    this.quantity,
    this.colors,
    this.sizes,
    this.deleteCallback,
    this.featured,
    this.toggleFavorite,
    this.placeholder,
    this.similarProduct,
    this.description,
    this.keyFeatures,
    this.color,
    this.toggleFeatured
  });
  @override
  Widget build(BuildContext context) {
    //var _time = DateTime.now().toString();
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: deleteCallback,
                    child: Icon(
                      Icons.delete,
                      color: kColorRed,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6.2,
              width: MediaQuery.of(context).size.height / 5.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.scaleDown,
                placeholder: 'images/loading_gif/Spin-1s-200px.gif',
                image: images[0],
                imageErrorBuilder: (context, url, error) => Icon(
                  Icons.error,
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'UGX$oldPrice',
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'UGX$price',
                  style:
                      TextStyle(color: kColorRed, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          featured ? Colors.greenAccent[700] : Colors.black38),
                  onPressed: toggleFeatured,
                  child: Text('Featured'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
