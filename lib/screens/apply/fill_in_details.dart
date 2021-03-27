import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aumsodmll/route_generator.dart';
class ApplicationForm extends StatefulWidget {
  @override
  _ApplicationFormState createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OD Application Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Fill in your details",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                hintText: "Your Name"
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                  hintText: "Roll No. in format CB.EN.U4CSEXXXXX"
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8.0,8.0,8.0),
              child: Row(
                children: [
                  Text(
                    "Branch:",

                  ),
                  /*DropdownButtonFormField<String>(
                      items: <String>['B.Tech CSE','B.Tech MECH']
                          .map<DropdownMenuItem<String>>(
                          (String val){
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,);
                          }
                      ).toList(),
                      onChanged: (val){
                        setState(() {

                        });
                      },
                    ),*/
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8.0,8.0,8.0),
              child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              "Semester:",

                            ),
                            /*DropdownButtonFormField<String>(
                      items: <String>['B.Tech CSE','B.Tech MECH']
                          .map<DropdownMenuItem<String>>(
                          (String val){
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,);
                          }
                      ).toList(),
                      onChanged: (val){
                        setState(() {

                        });
                      },
                    ),*/
                          ],
                        )
                    ),
                    SizedBox(width:10.0),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              "Section:",

                            ),
                            /*DropdownButtonFormField<String>(
                      items: <String>['B.Tech CSE','B.Tech MECH']
                          .map<DropdownMenuItem<String>>(
                          (String val){
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,);
                          }
                      ).toList(),
                      onChanged: (val){
                        setState(() {

                        });
                      },
                    ),*/
                          ],
                        )
                    ),
                  ],
                ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Date of Application"
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Submit",
                style: TextStyle(
                  fontSize: 16.0,
                ),),
              ),

            )

          ],
        ),
      ),
    );
  }
}
