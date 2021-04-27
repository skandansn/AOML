import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
//import 'package:aumsodmll/helpers/tile.dart';

class AttendanceCalendar extends StatefulWidget {
  @override
  _AttendanceCalendarState createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  DatabaseService _db = DatabaseService();
  var events = [];
  calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      var formid = details.appointments[0].formid;
      if (formid != null) {
        Navigator.pushNamed(context, "/track", arguments: formid);
      } else {
        DateFormat format = DateFormat("MM-dd-yyyy");
        dynamic st =
            (format.parse(details.appointments[0].startTime.toString()));

        st = DateTime.parse(
            details.appointments[0].startTime.toString().split(" ")[0]);
        st = st.toString().split(" ")[0];
        var year = st.toString().split("-")[0];
        var month = st.toString().split("-")[1];
        var day = st.toString().split("-")[2];
        var finaldate = "$month/$day/$year - $month/$day/$year";

        Navigator.pushNamed(context, "/od", arguments: finaldate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: _db.odList(), // async work
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Loading();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                DateFormat format = DateFormat("MM/dd/yyyy");

                dynamic attendance;
                snapshot.data.removeAt(0);
                attendance = snapshot.data[0];
                snapshot.data.removeAt(0);
                snapshot.data.removeAt(0);
                events.addAll(snapshot.data);
                return SafeArea(
                  child: Scaffold(
                      appBar: AppBar(
                        elevation: 0.1,
                        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                        title: Text("Current Attendance: $attendance%"),
                      ),
                      body: SfCalendar(
                        onTap: calendarTapped,
                        view: CalendarView.month,
                        dataSource: MeetingDataSource(getAppointments(events)),
                        monthViewSettings: MonthViewSettings(
                          monthCellStyle: MonthCellStyle(
                              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                              trailingDatesBackgroundColor:
                                  Color.fromRGBO(64, 75, 96, .9),
                              leadingDatesBackgroundColor:
                                  Color.fromRGBO(64, 75, 96, .9),
                              todayBackgroundColor: Color(0xFFFFFFFF),
                              textStyle:
                                  TextStyle(fontSize: 12, fontFamily: 'Arial'),
                              todayTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial'),
                              trailingDatesTextStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  fontFamily: 'Arial'),
                              leadingDatesTextStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  fontFamily: 'Arial')),
                          showAgenda: true,
                          agendaStyle: AgendaStyle(
                            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                            appointmentTextStyle: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFFFFFFF)),
                            dateTextStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                            dayTextStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      )),
                );
              }
          }
        });
  }
}

List<CustomAppointment> getAppointments(List<dynamic> events) {
  List<CustomAppointment> meetings = <CustomAppointment>[];
  DateFormat format = DateFormat("MM/dd/yyyy");
  var color;
  var status = "Pending";
  events.forEach((element) {
    if (element["type"] != "GroupOd") {
      color = Colors.redAccent;
      if (element["steps"] == -1) {
        status = "Rejected";
      } else if (element["steps"] == 0) {
        status = "Approved";
      } else {
        status = "Pending";
      }

      if (element['type'] == "OD" || element['type'] == "ML") {
        color = Colors.orange;
      }
      var st = (element['date'].split(" - ")[0]);
      var end = (element['date'].split(" - ")[1]);

      st = (format.parse(st));
      end = (format.parse(end));

      meetings.add(CustomAppointment(
          formid: element.id,
          startTime: st,
          endTime: end,
          subject: "${element['description']} | $status",
          color: color));
    } else {
      var currentUser = FirebaseAuth.instance.currentUser.uid;
      var index = 0;
      if (element.data()["stuids"] != null) {
        index = element.data()["stuids"].indexOf(currentUser);
        color = Colors.redAccent;
        if (element.data()["steps"][index] == -1) {
          status = "Rejected";
        } else if (element.data()["steps"][index] == 0) {
          status = "Approved";
        } else {
          status = "Pending";
        }

        color = Colors.green;

        var st = (element['date'].split(" - ")[0]);
        var end = (element['date'].split(" - ")[1]);

        st = (format.parse(st));
        end = (format.parse(end));

        meetings.add(CustomAppointment(
            formid: element.id,
            startTime: st,
            endTime: end,
            subject: "${element['description']} | $status",
            color: color));
      }
    }
  });

  for (int i = 1; i < 14; i++) {
    var st = DateTime.now().add(Duration(days: i));
    var end = DateTime.now().add(Duration(days: i));

    meetings.add(CustomAppointment(
        startTime: st,
        endTime: end,
        subject: "Apply for an OD/ML/Daypass/Homepass",
        color: Colors.black));
  }

  for (int i = 0; i < 14; i++) {
    var st = DateTime.now().add(Duration(days: -i));
    var end = DateTime.now().add(Duration(days: -i));

    meetings.add(CustomAppointment(
        startTime: st,
        endTime: end,
        subject: "Apply for an OD/ML/Daypass/Homepass",
        color: Colors.black));
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CustomAppointment> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }
}

class CustomAppointment extends Appointment {
  String formid;

  CustomAppointment(
      {startTime, endTime, color, subject, appointements, this.formid})
      : super(
          startTime: startTime,
          endTime: endTime,
          subject: subject,
          color: color,
        );
}
