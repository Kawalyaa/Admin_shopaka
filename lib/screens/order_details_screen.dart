import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopla_ecommerce_app/constants.dart';
import 'package:shopla_ecommerce_app/db/order_services.dart';
import 'package:shopla_ecommerce_app/model/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const String id = 'orderDetails';
  final OrderModel model;
  OrderDetailsScreen({this.model});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsScreen args = ModalRoute.of(context).settings.arguments;
    CollectionReference _firestore =
        FirebaseFirestore.instance.collection('orders');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  'ORDERED ITEMS',
                  style: TextStyle(
                    color: kColorRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _itemList(args.model.ordersList),
              ),
            ),
            SizedBox(height: 10.0),
            _richText2(
                'Oreder Number', args.model.orderNumber, Colors.red[900]),
            SizedBox(height: 10.0),
            _richText2('Oredered On',
                DateFormat().format(args.model.time.toDate()), Colors.blueGrey),
            SizedBox(height: 10.0),
            _richText2(
                'Payment Status',
                args.model.paymentStatus == ''
                    ? 'null'
                    : args.model.paymentStatus,
                Colors.blueGrey),
            SizedBox(height: 10.0),
            _richText2(
                'Payment Method', args.model.paymentMethod, Colors.blueGrey),
            SizedBox(height: 10.0),
            _richText2('Total Price', args.model.totalPrice.toString(),
                Colors.blueGrey),
            SizedBox(height: 10.0),
            _richText2(
                'Pickup Station',
                args.model.pickupStation.isEmpty
                    ? 'null'
                    : args.model.pickupStation[0]['placeName'],
                Colors.blueGrey),
            SizedBox(height: 10),
            _richText2(
                'Shipping Method',
                args.model.deliveryMethod == ''
                    ? 'Null'
                    : args.model.deliveryMethod,
                Colors.blueGrey),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 20),
            Text(
              'USER DETAILS',
              style: TextStyle(
                color: kColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            _richText(
                'Name',
                args.model.address.isEmpty
                    ? 'Null'
                    : args.model.address[0]['name']),
            SizedBox(height: 5.0),
            _richText(
                'Phone',
                args.model.address.isEmpty
                    ? 'Null'
                    : args.model.address[0]['phone']),
            SizedBox(height: 5.0),
            _richText(
                'Email', args.model.email == null ? 'Null' : args.model.email),
            SizedBox(height: 5.0),
            _richText(
                'Address',
                args.model.address.isEmpty
                    ? 'Null'
                    : args.model.address[0]['address']),
            SizedBox(height: 5.0),
            _richText(
                'Town',
                args.model.address.isEmpty
                    ? 'Null'
                    : args.model.address[0]['town']),
            SizedBox(height: 5.0),
            _richText(
                'region',
                args.model.address.isEmpty
                    ? 'Null'
                    : args.model.address[0]['region']),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'UPDATE ORDER STATUS',
                style: TextStyle(
                  color: kColorRed,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: _richText2(
                    'Current Status', args.model.orderStatus, Colors.red[900])),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statusButton(() async {
                  await _firestore
                      .where('orderNumber', isEqualTo: args.model.orderNumber)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((documentSnapshot) {
                      documentSnapshot.reference
                          .update({'orderStatus': 'dispatched'});
                    });
                  });
                }, 'DISPATCHED'),
                _statusButton(() async {
                  await _firestore
                      .where('orderNumber', isEqualTo: args.model.orderNumber)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((documentSnapshot) {
                      documentSnapshot.reference
                          .update({'orderStatus': 'arrived'});
                    });
                  });
                }, 'ARRIVED'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statusButton(() async {
                  await _firestore
                      .where('orderNumber', isEqualTo: args.model.orderNumber)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((documentSnapshot) {
                      documentSnapshot.reference.update({
                        'orderStatus': 'delivered',
                        'deliveryDate': DateTime.now()
                      });
                    });
                  });
                }, 'DELIVERED'),
                _statusButton(() async {
                  await _firestore
                      .where('orderNumber', isEqualTo: args.model.orderNumber)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((documentSnapshot) {
                      documentSnapshot.reference
                          .update({'orderStatus': 'canceled'});
                    });
                  });
                }, 'CANCELED')
              ],
            ),
            SizedBox(height: 20),
            _statusButton(() async {
              await OrderServices().removeOrder(args.model.orderNumber);
            }, 'DELETE'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ElevatedButton _statusButton(Function onPressed, String status) =>
      ElevatedButton(
        onPressed: onPressed,
        child: Text(status),
        style: ElevatedButton.styleFrom(primary: kColorRed),
      );

  RichText _richText(String firstText, String secondText) {
    return RichText(
      text: TextSpan(
          text: '$firstText: ',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
          children: [
            TextSpan(
              text: '$secondText',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }

  List<Container> _itemList(List itemsList) => List.generate(
        itemsList.length,
        (index) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Stack(
                  children: [
                    Container(
                        width: 50,
                        height: 60,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.black,
                          ),
                        )),
                    Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(
                              itemsList[index]['image'],
                            ),
                            fit: BoxFit.contain,
                          ),
                        )),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _richText('Name', itemsList[index]['name']),
                    _richText('Color', itemsList[index]['selectedColor']),
                    _richText('Qty', itemsList[index]['qty'].toString()),
                    _richText('Price', itemsList[index]['price'].toString()),
                    _richText(
                        'Size',
                        itemsList[index]['selectedSize'].isEmpty
                            ? 'null'
                            : itemsList[index]['selectedSize']),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      );

  RichText _richText2(String firstText, String secondText, Color secoTxtColor) {
    return RichText(
      text: TextSpan(
          text: '$firstText: ',
          style: TextStyle(
              color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: '$secondText',
              style: TextStyle(
                color: secoTxtColor,
              ),
            ),
          ]),
    );
  }
}
