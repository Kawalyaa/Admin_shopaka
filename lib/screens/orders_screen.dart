import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopla_ecommerce_app/components/single_order.dart';
import 'package:shopla_ecommerce_app/model/order_model.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'orderScreen';

  @override
  Widget build(BuildContext context) {
    List<OrderModel> ordersList = Provider.of<List<OrderModel>>(context);

    List<OrderModel> newOrders =
        ordersList.where((item) => item.orderStatus == 'sorting').toList();
    List<OrderModel> dispatchedOrders =
        ordersList.where((item) => item.orderStatus == 'dispatched').toList();
    List<OrderModel> deliveredOrders =
        ordersList.where((item) => item.orderStatus == 'sorting').toList();
    List<OrderModel> canceledOrders =
        ordersList.where((item) => item.orderStatus == 'sorting').toList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.8,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ListView.builder(
          itemCount: newOrders.length,
          itemBuilder: (context, index) => SingleOrder(
            firstInfo: 'Order',
            secondInfo: newOrders[index].orderNumber,
            firstInfo2: 'Date',
            secondInfo2:
                '${DateFormat().format(newOrders[index].time.toDate())}',
            model: OrderModel(
              id: newOrders[index].id,
              totalPrice: newOrders[index].totalPrice,
              time: newOrders[index].time,
              orderNumber: newOrders[index].orderNumber,
              orderStatus: newOrders[index].orderStatus,
              ordersList: newOrders[index].ordersList,
              paymentMethod: newOrders[index].paymentMethod,
              paymentStatus: newOrders[index].paymentStatus,
              pickupStation: newOrders[index].pickupStation,
              address: newOrders[index].address,
              email: newOrders[index].email,
            ),
          ),
        ),
      ),
    );
  }
}















