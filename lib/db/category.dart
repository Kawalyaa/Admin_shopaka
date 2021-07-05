import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryServices {
  Firestore _firestore = Firestore.instance;
  String _ref = 'Category';

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore
        .collection(_ref)
        .document(categoryId)
        .setData({'categoryName': name});
  }

  Future<List<DocumentSnapshot>> getCategories() => _firestore
      .collection(_ref)
      .getDocuments()
      .then((snaps) => snaps.documents);

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(_ref)
          .where('categoryName', isEqualTo: suggestion)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });
}
