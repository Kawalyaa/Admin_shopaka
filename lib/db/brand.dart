import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'Brand';

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _firestore.collection(ref).doc(brandId).set({'BrandName': name});
  }

  Future<List<DocumentSnapshot>> getBrand() => _firestore
      .collection(ref)
      .get()
      .then((snaps) => snaps.docs);
}
