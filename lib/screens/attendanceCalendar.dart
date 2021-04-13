import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
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
  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      //final CustomAppointment appointmentDetails = details.appointments[0];
      var formid = details.appointments[0].formid;
      Navigator.pushNamed(context, "/track", arguments: formid);
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
                events.addAll(snapshot.data);
                return SafeArea(
                  child: Scaffold(
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
  var color = Colors.redAccent;
  events.forEach((element) {
    color = Colors.redAccent;

    if (element['type'] == "OD" || element['type'] == "ML") {
      color = Colors.orangeAccent;
    }
    var st = (element['date'].split(" - ")[0]);
    var end = (element['date'].split(" - ")[1]);
    // print(st);
    // print(end);
    st = (format.parse(st));
    end = (format.parse(end));

    // print(st);
    // print(end);
    // print("----------------------------");

    meetings.add(CustomAppointment(
        formid: element.documentID,
        startTime: st,
        endTime: end,
        subject: element["description"],
        color: color));
  });

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
