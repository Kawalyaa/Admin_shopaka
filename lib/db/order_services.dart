import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopla_ecommerce_app/model/order_model.dart';

class OrderServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'allOrders';

  Stream<List<OrderModel>> ordersList() =>
      _firestore.collection(ref).snapshots().map((snaps) => snaps.docs
          .map((snap) => OrderModel.fromSnapShot(snap.data()))
          .toList());
}
