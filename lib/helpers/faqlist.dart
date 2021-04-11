import 'package:aumsodmll/helpers/tile.dart';
import 'package:aumsodmll/models/faq.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService();
    final ScrollController _scrollcontroller = ScrollController();
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
              final faqs = Provider.of<List<FAQClass>>(context);
              var userid = "${snapshot.data[2]}";
              var userNo = "${snapshot.data[1]}";

              var arr = [];
              if (faqs != null) {
                faqs.forEach((element) {
                  arr.add(element);
                });
              }

              return Scrollbar(
                thickness: 10.0,
                controller: _scrollcontroller,
                isAlwaysShown: true,
                child: ListView.builder(
                  controller: _scrollcontroller,
                  itemCount: arr.length,
                  itemBuilder: (context, index) {
                    return Tile(
                        appl: arr[index], userid: userid, userNo: userNo);
                  },
                ),
              );
            }
        }
      },
    );
  }
}
