import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokoti/utils/constants.dart';

class Firestore {
  final _firestoreInstance = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get producCol =>
      _firestoreInstance.collection(PRODUCT_COLLECTION);
}
