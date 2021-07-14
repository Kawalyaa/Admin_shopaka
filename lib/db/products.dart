import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopla_ecommerce_app/model/products_model.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'Products';
  String userRef = 'users';
  String orderRef = 'allOrders';
  var dateTime = DateTime.now();

  void uploadProduct({
    String productName,
    String brand,
    String category,
    List size,
    List images,
    List colors,
    double price,
    double oldPrice,
    int quantity,
    bool featured,
    bool favorite,
    List description,
    List keyFeatures,
  }) {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).doc(productId).set({
      'name': productName,
      'id': productId,
      'brand': brand,
      'category': category,
      'size': size,
      'price': price,
      'oldPrice': oldPrice,
      'quantity': quantity,
      'images': images,
      'colors': colors,
      'featured': featured,
      'favorite': favorite,
      'description': description,
      'keyFeatures': keyFeatures,
      'time': dateTime
    });
  }

  Future<List<DocumentSnapshot>> getBrand() =>
      _firestore.collection(ref).get().then((snaps) => snaps.docs);

  Future<List<ProductModel>> getProducts() async =>
      await _firestore.collection(ref).get().then((snaps) => snaps.docs
          .map((snap) => ProductModel.fromSnapShot(snap.data()))
          .toList());

  Future<void> removeProduct(String id) async {
    _firestore.collection(ref).doc(id).delete();
  }

  Stream<List<ProductModel>> getAllProducts() =>
      _firestore.collection(ref).snapshots().map((snaps) => snaps.docs
          .map((snap) => ProductModel.fromSnapShot(snap.data()))
          .toList());
}

//where('id',isEqualTo: id)
