import 'dart:io';
import 'package:aumsodmll/models/faq.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final CollectionReference odcollection = Firestore.instance.collection('ods');
  final CollectionReference groupodcollection =
      Firestore.instance.collection('groupods');
  final CollectionReference faqcollection =
      Firestore.instance.collection('faqs');

  final String uid;
  DatabaseService({this.uid});

  var currentuserid;
  Future<String> getUserid() async {
    currentuserid = await FirebaseAuth.instance.currentUser();
    currentuserid = currentuserid.uid;
    return currentuserid;
  }

  CollectionReference userList = Firestore.instance.collection("users");

  Future<List> facultyList() async {
    currentuserid = await FirebaseAuth.instance.currentUser();
    currentuserid = currentuserid.uid;
    var list = [];
    var type;
    var typefunout = await typefun(currentuserid);
    list.add(currentuserid);
    list.add(typefunout[1]);
    list.add(typefunout[2]);
    var r = await userList.getDocuments();
    for (int i = 0; i < r.documents.length; i++) {
      type = r.documents.elementAt(i).data["userType"];
      if (type == false) {
        list.add(r.documents.elementAt(i).data);
      }
    }
    return list;
  }

  Future<List> typefun(useridx) async {
    QuerySnapshot res =
        await userList.where("userid", isEqualTo: useridx).snapshots().first;
    return [
      (res.documents.first.data["userType"]),
      (res.documents.first.data["name"]),
      (res.documents.first.data["stuNo"]),
    ];
  }

  Future<List> fun() async {
    var userid = await FirebaseAuth.instance.currentUser();
    var res = await typefun(userid.uid);
    return res;
  }

  Future<List> getUserDetails() async {
    var userid = await FirebaseAuth.instance.currentUser();
    QuerySnapshot res =
        await userList.where("userid", isEqualTo: userid.uid).snapshots().first;
    return [
      (res.documents.first.data["name"]),
      (res.documents.first.data["stuNo"]),
      (res.documents.first.data["userid"]),
    ];
  }

  Stream<List<OD>> get ods {
    return odcollection.snapshots().map(_odsfromsnapshot);
  }

  List<OD> _odsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return OD(
          id: doc.documentID,
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
          proofreq: doc.data['proofreq'],
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
          proofreq: doc.data['proofreq'],
          proof: doc.data['proof'],
          reasons: doc.data['reasons'],
          formid: doc.documentID);
    }).toList();
  }

  Stream<List<FAQClass>> get faqs {
    return faqcollection.snapshots().map(_faqsfromsnapshot);
  }

  List<FAQClass> _faqsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FAQClass(
          time: doc.data['time'],
          question: doc.data['question'],
          answers: doc.data['answers'],
          upvotes: doc.data['upvotes'],
          stuNo: doc.data['stuNo'],
          stuid: doc.data['stuid'],
          stuname: doc.data['stuname'],
          formid: doc.documentID);
    }).toList();
  }

  Future reasonsandproof(String person, String id, String details) async {
    int flag = 1;
    String oldmsg;
    var x = await odcollection.document(id).get();
    if (x.data == null) {
      flag = 2;
      x = await groupodcollection.document(id).get();
    }
    oldmsg = (x.data["proofreq"]);
    if (oldmsg != null) {
      oldmsg = oldmsg + "\n";
      oldmsg = oldmsg + details;
    } else {
      oldmsg = details;
    }
    if (flag == 1) {
      odcollection.document(id).updateData({"proofreq": oldmsg});
    } else {
      groupodcollection.document(id).updateData({"proofreq": oldmsg});
    }
  }

  Future upvoteFaq(String formid, String userid) async {
    var faqitem = await faqcollection.document(formid).get();
    int oldUpvoteValue = faqitem['upvotes'];
    var oldPeopleUpvoted = [];
    oldPeopleUpvoted.addAll(faqitem['upvotedPeople']);
    print(oldPeopleUpvoted);
    if (oldPeopleUpvoted.contains(userid)) {
      oldPeopleUpvoted.remove(userid);
      faqcollection.document(formid).updateData(
          {"upvotes": oldUpvoteValue - 1, "upvotedPeople": oldPeopleUpvoted});
    } else {
      oldPeopleUpvoted.add(userid);
      faqcollection.document(formid).updateData(
          {"upvotes": oldUpvoteValue + 1, "upvotedPeople": oldPeopleUpvoted});
    }
  }

  Future addAnswerFaq(String formid, String userid, Map newAnswer) async {
    var faqitem = await faqcollection.document(formid).get();
    var answers = [];
    answers.addAll(faqitem['answers']);
    answers.add(newAnswer);
    faqcollection.document(formid).updateData({"answers": answers});
  }

  Future addFaq(
    String stuid,
    String stuname,
    String stuNo,
    String question,
  ) async {
    var data = {
      "question": question,
      "stuNo": stuNo,
      "stuid": stuid,
      "stuname": stuname,
      "time": DateTime.now().toString(),
      "upvotes": 0,
      "upvotedPeople": [],
      "answers": []
    };
    faqcollection.add(data);
  }

  Future applyod(
      String stuid,
      String stuname,
      String stuNo,
      String faculty,
      String advisor,
      String date,
      String time,
      String description,
      String type,
      File proof) async {
    String url = "";
    String proofreq;
    int steps = 1;
    if (faculty != "" && advisor != "" && faculty != advisor) {
      steps = 2;
    }
    if (proof != null) {
      var hash = proof.hashCode.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference reference = storage.ref().child('proofs/$hash');
      StorageUploadTask uploadTask = reference.putFile(proof);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      url = await taskSnapshot.ref.getDownloadURL();
    }
    var data = {
      "advisor": advisor,
      "date": date,
      "description": description,
      "faculty": faculty,
      "proof": url,
      "proofreq": proofreq,
      "stuNo": stuNo,
      "stuid": stuid,
      "stuname": stuname,
      "time": time,
      "type": type,
      "steps": steps
    };
    odcollection.add(data);
  }

  Future updateOd(
      String person, String id, int steps, bool val, String reasons) async {
    int flag = 1;
    var x = await odcollection.document(id).get();
    if (x.data == null) {
      flag = 2;
      x = await groupodcollection.document(id).get();
    }
    String msg = x.data["reasons"];
    if (msg != null) {
      msg = msg + "\n" + reasons;
    } else {
      msg = reasons;
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
      odcollection.document(id).updateData({"reasons": msg});
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
      groupodcollection.document(id).updateData({"reasons": msg});
    }
  }
}
