import 'package:aumsodmll/helpers/faqlist.dart';
import 'package:aumsodmll/models/faq.dart';
import 'package:aumsodmll/services/database.dart';
//import 'package:aumsodmll/shared/constants.dart';
//import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PinnedFaq extends StatelessWidget {
  //final DatabaseService _db = DatabaseService();
  final TextEditingController qn = new TextEditingController();
  fun() {
    return FAQList(pinned: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FAQClass>>.value(
      initialData: [],
        value: DatabaseService().faqs,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: (Text("Pinned FAQs")),
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
        ));
  }
}
