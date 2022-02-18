import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_basic_example/models/user_model.dart';

import '../models/brew_model.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});
  FirestoreService.withoutUid() : uid = "";
  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<BrewModel> _brewListFromSnahpsho(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      // print("Document snahpashot : ${documentSnapshot["sugars"]}");
      return BrewModel(
        name: documentSnapshot["name"],
        strength: documentSnapshot["strength"],
        sugars: documentSnapshot["sugars"],
      );
    }).toList();
  }

  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnahpsho);
  }

  //User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot["name"],
      sugars: snapshot["sugars"],
      strength: snapshot["strength"],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
