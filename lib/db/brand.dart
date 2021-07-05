import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandServices {
  Firestore _firestore = Firestore.instance;
  String ref = 'Brand';

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _firestore.collection(ref).document(brandId).setData({'BrandName': name});
  }

  Future<List<DocumentSnapshot>> getBrand() => _firestore
      .collection(ref)
      .getDocuments()
      .then((snaps) => snaps.documents);
}
