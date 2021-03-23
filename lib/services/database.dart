import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // final CollectionReference brewCollection =
  //     Firestore.instance.collection('brews');

  final String uid;
  DatabaseService({this.uid});
  CollectionReference userList = Firestore.instance.collection("users");

  Future<List> typefun(useridx) async {
    QuerySnapshot res =
        await userList.where("userid", isEqualTo: useridx).snapshots().first;
    print((res.documents.first.data));
    return [
      (res.documents.first.data["userType"]),
      (res.documents.first.data["name"])
    ];
    // print(res.documents[0]["userType"]);
  }

  Future<List> fun() async {
    var userid = await FirebaseAuth.instance.currentUser();
    var res = await typefun(userid.uid);
    return res;
  }

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
