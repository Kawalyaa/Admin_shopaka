import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryServices {
 FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _ref = 'Category';

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore
        .collection(_ref)
        .doc(categoryId)
        .set({'categoryName': name});
  }

  Future<List<DocumentSnapshot>> getCategories() => _firestore
      .collection(_ref)
      .get()
      .then((snaps) => snaps.docs);

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(_ref)
          .where('categoryName', isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
