import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/models/user.dart';

class DatabaseService {
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');
  final String uid;
  DatabaseService({this.uid});

  // Future updateUserData(String sugars, String name, int strength) async {
  //   return await brewCollection
  //       .document(uid)
  //       .setData({'sugars': sugars, 'name': name, 'strength': strength});
  // }

  // Stream<UserData> get userData {
  //   return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  // }

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //     uid: uid,
  //     name: snapshot.data['name'],
  //     sugars: snapshot.data['sugars'],
  //     strength: snapshot.data['strength'],
  //   );
  // }
}
