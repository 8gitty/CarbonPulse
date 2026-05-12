import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Future<void> saveCarbonHistory({
    required String source,
    required double carbonScore,
    required int electricityUnits,
  }) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _db
        .collection("users")
        .doc(user.uid)
        .collection("carbon_history")
        .add({
      "source": source,
      "carbonScore": carbonScore,
      "electricityUnits": electricityUnits,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}