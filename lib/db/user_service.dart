import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopla_ecommerce_app/model/user_model.dart';
class UserServices{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'users';


  Stream<List<UserModel>> getUsers()=>_firestore.collection(ref).snapshots().map((snaps) => snaps.docs.map((snap) => UserModel.fromSnapShot(snap.data())).toList());

  Future<void> deleteUser(String id)async{
   await _firestore.collection(ref).doc(id).delete();
  }



}