import 'dart:io';
import 'package:aumsodmll/models/faq.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final CollectionReference odcollection =
      FirebaseFirestore.instance.collection('ods');
  final CollectionReference groupodcollection =
      FirebaseFirestore.instance.collection('groupods');
  final CollectionReference faqcollection =
      FirebaseFirestore.instance.collection('faqs');

  final String uid;
  DatabaseService({this.uid});

  var currentuserid;
  Future<String> getUserid() async {
    currentuserid = FirebaseAuth.instance.currentUser.uid;
    return currentuserid;
  }

  CollectionReference userList = FirebaseFirestore.instance.collection("users");

  Future<List> typefun(useridx) async {
    QuerySnapshot res =
        await userList.where("userid", isEqualTo: useridx).snapshots().first;
    return [
      (res.docs.first.data()["userType"]),
      (res.docs.first.data()["name"]),
      (res.docs.first.data()["stuNo"]),
      (res.docs.first.data()["grantOD"]),
      (res.docs.first.data()["timeGrantOD"]),
      (res.docs.first.data()["attendance"]),
      (res.docs.first.data()["applyLimiter"]),
      (res.docs.first.data()["daysAbsentList"]),
      (res.docs.first.id),
      (res.docs.first.data()["branch"]),
      (res.docs.first.data()["advisor"]),
    ];
  }

  Future<List> fun() async {
    var userid = FirebaseAuth.instance.currentUser.uid;
    var res = await typefun(userid);
    var type = res[0];
    if (type == true) {
      var absentList = (res[7]);
      var st, end;
      DateFormat format = DateFormat("MM/dd/yyyy");

      dynamic attendance;
      var days = [];
      int workingdaysLeave = 0;
      if (absentList != null)
        absentList.forEach((element) {
          if (element != "") {
            st = (element.split(" - ")[0]);
            end = (element.split(" - ")[1]);
            st = (format.parse(st));
            end = (format.parse(end));

            for (int i = 0; i <= end.difference(st).inDays; i++) {
              if (!days.contains(st.add(Duration(days: i)))) {
                if (st.add(Duration(days: i)).weekday < 6) {
                  workingdaysLeave += 1;
                }
                days.add(st.add(Duration(days: i)));
              }
            }
          }
        });
      attendance = ((180 - workingdaysLeave) / 180) * 100;
      attendance = (attendance.toStringAsFixed(2));
      FirebaseFirestore.instance
          .collection("users")
          .doc(res[8])
          .update({"attendance": attendance});

      return res;
    } else
      return res;
  }

  Future<List> getUsersList(bool typeFromPage) async {
    currentuserid = FirebaseAuth.instance.currentUser.uid;
    var list = [];
    var type;
    var typefunout = await typefun(currentuserid);
    list.add(currentuserid);
    list.add(typefunout[1]);
    list.add(typefunout[2]);
    list.add(typefunout[3]);
    list.add(typefunout[4]);
    list.add(typefunout[5]);
    list.add(typefunout[6]);
    list.add(typefunout[9]);
    list.add(typefunout[10]);

    var r = await userList.get();
    var data;
    for (int i = 0; i < r.docs.length; i++) {
      type = r.docs.elementAt(i).data()["userType"];

      if (type == typeFromPage) {
        data = r.docs.elementAt(i).data();
        data["formid"] = r.docs.elementAt(i).id;
        list.add(data);
      }
    }
    return list;
  }

  Future<List> odList() async {
    currentuserid = FirebaseAuth.instance.currentUser.uid;
    var item;
    var list = [];
    QuerySnapshot user = await userList
        .where("userid", isEqualTo: currentuserid)
        .snapshots()
        .first;
    var absentList = (user.docs.first.data()["daysAbsentList"]);
    var attendance = (user.docs.first.data()["attendance"]);
    var formid = (user.docs.first.id);

    var r = await odcollection.get();
    var r2 = await groupodcollection.get();
    list.add(absentList);
    list.add(attendance);
    list.add(formid);

    for (int i = 0; i < r.docs.length; i++) {
      item = r.docs.elementAt(i);
      if (item.data()["stuid"] == currentuserid) {
        list.add(item);
      }
    }
    for (int i = 0; i < r2.docs.length; i++) {
      item = r2.docs.elementAt(i);
      if (item.data()["stuids"].contains(currentuserid)) {
        list.add(item);
      }
    }
    return list;
  }

  Future<List> getUserDetails() async {
    var userid = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot res =
        await userList.where("userid", isEqualTo: userid).snapshots().first;
    return [
      (res.docs.first.data()["name"]),
      (res.docs.first.data()["stuNo"]),
      (res.docs.first.data()["userid"]),
      (res.docs.first.data()["userType"]),
    ];
  }

  Stream<List<OD>> get ods {
    return odcollection.snapshots().map(_odsfromsnapshot);
  }

  List<OD> _odsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OD(
          advisor: doc.data()['advisor'],
          date: doc.data()['date'],
          time: doc.data()['time'],
          description: doc.data()['description'],
          faculty: doc.data()['faculty'],
          steps: doc.data()['steps'],
          stuNo: doc.data()['stuNo'],
          stuid: doc.data()['stuid'],
          stuname: doc.data()['stuname'],
          type: doc.data()['type'],
          proof: doc.data()['proof'],
          proofreq: doc.data()['proofreq'],
          reasons: doc.data()['reasons'],
          formid: doc.id);
    }).toList();
  }

  Future updateUserData(OD od, String date, String time, String description) {
    odcollection
        .doc(od.formid)
        .update({"date": date, "time": time, "description": description});
  }

  Stream<DocumentSnapshot> get userData {
    return odcollection.doc(uid).snapshots();
  }

  UserData _userDataFromSnapshot(Document) {}

  Stream<List<GroupOD>> get groupods {
    return groupodcollection.snapshots().map(_groupodsfromsnapshot);
  }

  List<GroupOD> _groupodsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return GroupOD(
          date: doc.data()['date'],
          time: doc.data()['time'],
          description: doc.data()['description'],
          faculty: doc.data()['faculty'],
          steps: doc.data()['steps'],
          stuNos: doc.data()['stuNos'],
          stuids: doc.data()['stuids'],
          type: doc.data()['type'],
          stunames: doc.data()['stunames'],
          proof: doc.data()['proof'],
          facSteps: doc.data()['facSteps'],
          formid: doc.id);
    }).toList();
  }

  Stream<List<FAQClass>> get faqs {
    return faqcollection.snapshots().map(_faqsfromsnapshot);
  }

  List<FAQClass> _faqsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FAQClass(
          time: doc.data()['time'],
          question: doc.data()['question'],
          answers: doc.data()['answers'],
          upvotes: doc.data()['upvotes'],
          stuNo: doc.data()['stuNo'],
          stuid: doc.data()['stuid'],
          stuname: doc.data()['stuname'],
          pinned: doc.data()['pinned'],
          formid: doc.id);
    }).toList();
  }

  Future reasonsandproof(String person, String id, String details) async {
    int flag = 1;
    String oldmsg;
    var x = await odcollection.doc(id).get();
    if (x.data() == null) {
      flag = 2;
      x = await groupodcollection.doc(id).get();
    }
    oldmsg = (x["proofreq"]);
    if (oldmsg != null) {
      oldmsg = oldmsg + "\n";
      oldmsg = oldmsg + details;
    } else {
      oldmsg = details;
    }
    if (flag == 1) {
      odcollection.doc(id).update({"proofreq": oldmsg});
    } else {
      groupodcollection.doc(id).update({"proofreq": oldmsg});
    }
  }

  Future upvoteFaq(String formid, String userid) async {
    var faqitem = await faqcollection.doc(formid).get();
    int oldUpvoteValue = faqitem['upvotes'];
    var oldPeopleUpvoted = [];
    oldPeopleUpvoted.addAll(faqitem['upvotedPeople']);
    if (oldPeopleUpvoted.contains(userid)) {
      oldPeopleUpvoted.remove(userid);
      faqcollection.doc(formid).update(
          {"upvotes": oldUpvoteValue - 1, "upvotedPeople": oldPeopleUpvoted});
    } else {
      oldPeopleUpvoted.add(userid);
      faqcollection.doc(formid).update(
          {"upvotes": oldUpvoteValue + 1, "upvotedPeople": oldPeopleUpvoted});
    }
  }

  Future pinOrUnpinFaq(String formid) async {
    var faqitem = await faqcollection.doc(formid).get();
    bool pinstatus = faqitem['pinned'];
    pinstatus = !pinstatus;

    faqcollection.doc(formid).update({"pinned": pinstatus});
  }

  Future addAnswerFaq(String formid, String userid, Map newAnswer) async {
    var faqitem = await faqcollection.doc(formid).get();
    var answers = [];
    answers.addAll(faqitem['answers']);
    answers.add(newAnswer);
    faqcollection.doc(formid).update({"answers": answers});
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
      "answers": [],
      "pinned": false
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
      dynamic proof) async {
    String url = "";
    String proofreq;
    int steps = 1;
    if (faculty != "" && advisor != "" && faculty != advisor) {
      steps = 2;
    }
    if (proof != null) {
      var hash = proof.hashCode.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('proofs/$hash');
      UploadTask uploadTask = reference.putData(proof);
      await Future.value(uploadTask);
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      url = await reference.getDownloadURL();
      print(url);
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
    dynamic docid;
    docid = await odcollection.add(data);
    docid = docid.id;
    currentuserid = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot res = await userList
        .where("userid", isEqualTo: currentuserid)
        .snapshots()
        .first;

    var formid = res.docs.first.id;
    var oldLim = res.docs.first["applyLimiter"];
    userList.doc(formid).update({"applyLimiter": oldLim - 1});
    return docid;
  }

  Future applyGrpOd(List students, String faculty, String date, String time,
      String description, dynamic proof) async {
    var hod;
    String url = "";
    List docIds = [];
    var temp;
    var faclist = await getUsersList(false);
    faclist.removeRange(0, 9);

    for (int i = 0; i < students.length; i++) {
      faclist.forEach((inner) {
        if (inner['hod'] == students[i]["branch"]) {
          hod = inner['userid'];
        }
      });

      temp = await applyod(
          students[i]["userid"],
          students[i]["name"],
          students[i]["stuNo"],
          hod,
          students[i]["advisor"],
          date,
          time,
          description,
          "GroupOd",
          proof);
      docIds.add(temp);
    }

    if (proof != null) {
      var hash = proof.hashCode.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('proofs/$hash');
      UploadTask uploadTask = reference.putData(proof);
      await Future.value(uploadTask);
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      url = await reference.getDownloadURL();
    }
    List stuNosList = [];
    List stunamesList = [];
    List stuidsList = [];
    List steps = [];
    List facSteps = [];
    students.forEach((element) {
      stuNosList.add(element["stuNo"]);
      stuidsList.add(element["userid"]);
      stunamesList.add(element["name"]);
      if (element['advisor'] != "" && hod != "" && element['advisor'] != hod) {
        steps.add(3);
      } else {
        steps.add(2);
      }
      facSteps.add(1);
    });

    var data = {
      "date": date,
      "description": description,
      "faculty": faculty,
      "proof": url,
      "stuNos": stuNosList,
      "stuids": stuidsList,
      "stunames": stunamesList,
      "time": time,
      "type": "GroupOd",
      "steps": steps,
      "facSteps": facSteps,
      "docIds": docIds
    };
    groupodcollection.add(data);
  }

  Future updateOd(
      String person, String id, int steps, bool val, String reasons) async {
    var x = await odcollection.doc(id).get();

    String msg = x["reasons"];
    if (msg != null) {
      msg = msg + "\n" + reasons;
    } else {
      msg = reasons;
    }
    var f = (x["faculty"]);
    if (val == true) {
      if (f == person) {
        odcollection.doc(id).update({"faculty": "Approved"});
      } else {
        odcollection.doc(id).update({"advisor": "Approved"});
      }
      odcollection.doc(id).update({"steps": steps - 1});
      if ((x["type"] == "Daypass" || x["type"] == "Homepass") &&
          x["steps"] == 1) {
        var oldList = [];

        QuerySnapshot res = await userList
            .where("userid", isEqualTo: x["stuid"])
            .snapshots()
            .first;
        if (res.docs.first["daysAbsentList"] != null)
          oldList.addAll(res.docs.first["daysAbsentList"]);
        oldList.add(x["date"]);
        userList.doc(res.docs.first.id).update({"daysAbsentList": oldList});
      }
    } else {
      if (f == person) {
        odcollection.doc(id).update({"faculty": "Denied"});
      } else {
        odcollection.doc(id).update({"advisor": "Denied"});
      }

      odcollection.doc(id).update({"steps": -1});
    }

    if (x['type'] == "GroupOd") {
      dynamic grps = await groupodcollection.get();
      var changesteps = [];
      var facchangesteps = [];

      var templist = [];

      grps = grps.documents;
      grps.forEach((element) {
        templist = element['docIds'];
        for (int i = 0; i < templist.length; i++) {
          if (templist[i] == id) {
            if (val == true) {
              changesteps = element["steps"];

              changesteps[i] -= 1;
              groupodcollection.doc(element.id).update({"steps": changesteps});
            }
            if (val == false) {
              changesteps = element["steps"];
              changesteps[i] = -1;
              facchangesteps = element['facSteps'];
              facchangesteps[i] = 0;
              groupodcollection
                  .doc(element.id)
                  .update({"steps": changesteps, "facSteps": facchangesteps});
            }
          }
        }
      });
    }

    odcollection.doc(id).update({"reasons": msg});
  }
}
