import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
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
  }) {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).document(productId).setData({
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
    });
  }

//  'size': size,
//  'images': images,
//  'price': price,
//  'quantity': quantity

  Future<List<DocumentSnapshot>> getBrand() => _firestore
      .collection(ref)
      .getDocuments()
      .then((snaps) => snaps.documents);
}
