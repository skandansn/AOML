import 'package:aumsodmll/helpers/groupodlist.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/helpers/od_list.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var arguements = ModalRoute.of(context).settings.arguments;
    print(arguements);

    groupodfun() {
      return GroupODList(flag: false, arg: arguements);
    }

    odfun() {
      return ODList(flag: false, arg: arguements);
    }

    return MultiProvider(
        providers: [
          StreamProvider<List<OD>>.value(value: DatabaseService().ods),
          StreamProvider<List<GroupOD>>.value(
              value: DatabaseService().groupods),
        ],
        child: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: (Text("Track Status")),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                "Your Applications",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(flex: 8, child: odfun()),
              Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Text(
                "Your Group OD Applications",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                flex: 2,
                child: groupodfun(),
              ),
            ]),
          ),
        ));
  }
}
