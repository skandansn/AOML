import 'package:cloud_firestore/cloud_firestore.dart';

class FAQClass {
  final String time;
  final String question;
  final String stuNo;
  final String stuid;
  final String stuname;
  final String formid;
  final List upvotedPeople;
  final int upvotes;
  final List answers;
  FAQClass(
      {this.time,
      this.upvotedPeople,
      this.stuNo,
      this.stuid,
      this.stuname,
      this.question,
      this.formid,
      this.upvotes,
      this.answers});
}
