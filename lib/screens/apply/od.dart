import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex:1,
            child: GestureDetector(
              onTap: (){
                //Navigator.of(context).pushNamed('/fillIn',arguments: '');
              },
              child: Card(
                margin: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: IconButton(
                            icon: Icon(Icons.group_add),
                            iconSize: 115.0,
                            onPressed: (){

                            },

                          ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "Group OD",
                        style: TextStyle(
                          fontSize: 30.0,
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex:1,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/fillIn',arguments: '');
              },
              child: Card(
                margin: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.person_add),
                          iconSize: 100.0,
                          onPressed: (){
                            Navigator.of(context).pushNamed('/fillIn',arguments: '');
                          },

                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Individual OD",
                        style: TextStyle(
                            fontSize: 30.0,
                        ),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
