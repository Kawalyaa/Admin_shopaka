import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopla_ecommerce_app/components/single_order.dart';
import 'package:shopla_ecommerce_app/constants.dart';
import 'package:shopla_ecommerce_app/model/order_model.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  static const String id = 'orderScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int selectedIndex = 0;

  List<Widget> tabList = [
    Tab(
      child: Text('NEW'),
    ),
    Tab(
      child: Text('DISPA'),
    ),
    Tab(
      child: Text('ARRIV'),
    ),
    Tab(
      child: Text('DELIV'),
    ),
    Tab(
      child: Text('CANC'),
    ),
  ];
  @override
  void initState() {
    super.initState();

    ///Creat TabController to get the index of current tab
    _controller = TabController( length: tabList.length, vsync: this);
    _controller.addListener(() {
      setState(() {
      selectedIndex = _controller.index;
    });
     });

    
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel> ordersList = Provider.of<List<OrderModel>>(context);

    List<OrderModel> newOrders =
        ordersList.where((item) => item.orderStatus == 'sorting').toList();
    List<OrderModel> dispatchedOrders =
        ordersList.where((item) => item.orderStatus == 'dispatched').toList();
    List<OrderModel> arrivedOrders =
        ordersList.where((item) => item.orderStatus == 'arrived').toList();
          List<OrderModel> deliveredOrders =
        ordersList.where((item) => item.orderStatus == 'delivered').toList();
    List<OrderModel> canceledOrders =
        ordersList.where((item) => item.orderStatus == 'canceled').toList();

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
        bottom: TabBar(controller: _controller,tabs: tabList,labelColor: kColorRed,),
      ),
      body: TabBarView(controller: _controller,children:[_orders(newOrders),_orders(dispatchedOrders),_orders(arrivedOrders),_orders(deliveredOrders),_orders(canceledOrders),]),
    );
  }
  _orders(List<OrderModel> orderList)=>orderList.isEmpty?Center(child:Text('No Orders',style: TextStyle(fontSize: 18.0,color: kColorRed),)):Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 5.0),
        child: Column(
          children: [

                   selectedIndex== 0?   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('New Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ):selectedIndex== 1?   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Dispatched Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ):selectedIndex== 2?   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Arrived Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ):selectedIndex== 3?   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Delivered Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ):selectedIndex== 4?   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Canceled Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ):Container(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Orders with red color are express orders',style: TextStyle(fontWeight: FontWeight.bold),),
                      ),


            Container(
              height: MediaQuery.of(context).size.height-209,
              child: ListView.builder(
              
                itemCount: orderList.length,
                itemBuilder: (context, index) => SingleOrder(
                  firstInfo: 'Order',
                  secondInfo: orderList[index].orderNumber,
                  firstInfo2: 'Date',
                  deliveryMethod: orderList[index].deliveryMethod,
                  secondInfo2:
                      '${DateFormat().format(orderList[index].time.toDate())}',
                  model: OrderModel(
                    id: orderList[index].id,
                    totalPrice: orderList[index].totalPrice,
                    time: orderList[index].time,
                    orderNumber: orderList[index].orderNumber,
                    orderStatus: orderList[index].orderStatus,
                    ordersList: orderList[index].ordersList,
                    paymentMethod: orderList[index].paymentMethod,
                    paymentStatus: orderList[index].paymentStatus,
                    pickupStation: orderList[index].pickupStation,
                    address: orderList[index].address,
                    email: orderList[index].email,
                    deliveryMethod: orderList[index].deliveryMethod,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}


