import 'package:aumsodmll/models/od.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference odcollection = Firestore.instance.collection('ods');
  final CollectionReference groupodcollection =
      Firestore.instance.collection('groupods');

  final String uid;
  DatabaseService({this.uid});

  var currentuserid;
  Future<String> getUserid() async {
    currentuserid = await FirebaseAuth.instance.currentUser();
    currentuserid = currentuserid.uid;

    return currentuserid;
  }

  CollectionReference userList = Firestore.instance.collection("users");

  Future<List> typefun(useridx) async {
    QuerySnapshot res =
        await userList.where("userid", isEqualTo: useridx).snapshots().first;
    return [
      (res.documents.first.data["userType"]),
      (res.documents.first.data["name"])
    ];
  }

  Future<List> fun() async {
    var userid = await FirebaseAuth.instance.currentUser();
    var res = await typefun(userid.uid);

    return res;
  }

  Stream<List<OD>> get ods {
    return odcollection.snapshots().map(_odsfromsnapshot);
  }

  List<OD> _odsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return OD(
          advisor: doc.data['advisor'],
          date: doc.data['date'],
          time: doc.data['time'],
          description: doc.data['description'],
          faculty: doc.data['faculty'],
          steps: doc.data['steps'],
          stuNo: doc.data['stuNo'],
          stuid: doc.data['stuid'],
          stuname: doc.data['stuname'],
          type: doc.data['type'],
          proof: doc.data['proof'],
          reasons: doc.data['reasons'],
          formid: doc.documentID);
    }).toList();
  }

  Stream<List<GroupOD>> get groupods {
    return groupodcollection.snapshots().map(_groupodsfromsnapshot);
  }

  List<GroupOD> _groupodsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return GroupOD(
          advisor: doc.data['advisor'],
          date: doc.data['date'],
          time: doc.data['time'],
          description: doc.data['description'],
          faculty: doc.data['faculty'],
          steps: doc.data['steps'],
          stuNos: doc.data['stuNos'],
          stuids: doc.data['stuids'],
          stunames: doc.data['stunames'],
          head: doc.data['head'],
          proof: doc.data['proof'],
          reasons: doc.data['reasons'],
          formid: doc.documentID);
    }).toList();
  }

  Future reasonsandproof(String person, String id, String details) async {
    int flag = 1;
    print(details);
    var x = await odcollection.document(id).get();
    if (x.data == null) {
      flag = 2;
      x = await groupodcollection.document(id).get();
    }
    if (flag == 1) {
      odcollection.document(id).updateData({"proof": details});
    } else {
      groupodcollection.document(id).updateData({"proof": details});
    }
  }

  Future updateOd(
      String person, String id, int steps, bool val, String reasons) async {
    int flag = 1;
    var x = await odcollection.document(id).get();
    if (x.data == null) {
      flag = 2;
      x = await groupodcollection.document(id).get();
    }
    var f = (x.data["faculty"]);
    if (flag == 1) {
      if (val == true) {
        if (f == person) {
          odcollection.document(id).updateData({"faculty": "Approved"});
        } else {
          odcollection.document(id).updateData({"advisor": "Approved"});
        }
        odcollection.document(id).updateData({"steps": steps - 1});
      } else {
        if (f == person) {
          odcollection.document(id).updateData({"faculty": "Denied"});
        } else {
          odcollection.document(id).updateData({"advisor": "Denied"});
        }
        odcollection.document(id).updateData({"steps": -1});
      }
      odcollection.document(id).updateData({"reasons": reasons});
    } else {
      var h = (x.data["head"]);
      if (val == true) {
        print("todo accept group");
        //   if (f == person) {
        //     odcollection.document(id).updateData({"faculty": "Approved"});
        //   } else {
        //     odcollection.document(id).updateData({"advisor": "Approved"});
        //   }
        //   odcollection.document(id).updateData({"steps": steps - 1});
      } else {
        if (f == person) {
          groupodcollection.document(id).updateData({"faculty": "Denied"});
        } else if (h == person) {
          groupodcollection.document(id).updateData({"head": "Denied"});
        } else {
          groupodcollection.document(id).updateData({"advisor": "Denied"});
        }
        groupodcollection.document(id).updateData({"steps": -1});
      }
      groupodcollection.document(id).updateData({"reasons": reasons});
    }
  }
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


