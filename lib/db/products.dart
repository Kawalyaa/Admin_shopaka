import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'Products';

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
      'description':description,
      'keyFeatures':keyFeatures
    });
  }



  Future<List<DocumentSnapshot>> getBrand() => _firestore
      .collection(ref)
      .get()
      .then((snaps) => snaps.docs);
}
