import 'package:aumsodmll/helpers/faqlist.dart';
import 'package:aumsodmll/models/faq.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

bool sorted = false;
fun() {
  return FAQList(
    sorted: sorted,
  );
}

DatabaseService _db = DatabaseService();
TextEditingController qn = new TextEditingController();

class _FaqState extends State<Faq> {
  var list;
  var name;
  var stuNo;
  var userid;
  _addFaqItem() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            elevation: 8,
            title: Text('Add a question',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: qn,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: textInputDecoration.copyWith(
                      labelText: "Question",
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _db.addFaq(userid, name, stuNo, qn.text);
                      qn.clear();
                    },
                    style: buttonStyle,
                    child: Text("Submit"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: _db.getUserDetails(), // async work
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Loading();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                list = snapshot.data;
                name = list[0];
                stuNo = list[1];
                userid = list[2];
                bool type = list[3];

                return StreamProvider<List<FAQClass>>.value(
                    initialData: [],
                    value: DatabaseService().faqs,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                      appBar: AppBar(
                        actions: [
                          IconButton(
                              icon: Icon(Icons.push_pin_rounded,
                              key: Key("pinned"),),
                              onPressed: () {
                                Navigator.pushNamed(context, '/pinnedfaq');
                              }),
                          IconButton(
                              icon: Icon(Icons.sort,
                              key: Key("sort-button"),),
                              onPressed: () {
                                setState(() {
                                  sorted = !sorted;
                                });
                                if (sorted == true) {
                                  final snackBar = SnackBar(
                                      content:
                                          Text('Sorted by the most upvotes.'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                      content: Text('Sorted by new posts'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              })
                        ],
                        elevation: 0.1,
                        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                        title: (Text("FAQs")),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: fun(),
                          )
                        ]),
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          _addFaqItem();
                        },
                        child: const Icon(Icons.add,
                        key: Key("add-button")),
                        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
                      ),
                    ));
              }
          }
        });
  }
}
