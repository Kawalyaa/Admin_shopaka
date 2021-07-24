
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopla_ecommerce_app/model/order_model.dart';

class OrderServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'allOrders';

  Stream<List<OrderModel>> ordersList() =>
      _firestore.collection(ref).snapshots().map((snaps) => snaps.docs
          .map((snap) => OrderModel.fromSnapShot(snap.data()))
          .toList());


  Future<void> removeOrder(String orderNumber) async {
    await _firestore.collection(ref).where('orderNumber', isEqualTo: orderNumber).get().then((querySnapshot){
      querySnapshot.docs.forEach((documentSnapshot) { 
        documentSnapshot.reference.delete();
      });
    });
   //await _firestore.collection(ref).doc(id).delete();
  }
}
