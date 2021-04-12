import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class AttendanceCalendar extends StatefulWidget {
  @override
  _AttendanceCalendarState createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  DatabaseService _db = DatabaseService();
  var events = [];

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
                return Scaffold(
                    body: SfCalendar(
                  view: CalendarView.month,
                  dataSource: MeetingDataSource(getAppointments(events)),
                  monthViewSettings: MonthViewSettings(showAgenda: true),
                ));
              }
          }
        });
  }
}

List<Appointment> getAppointments(List<dynamic> events) {
  List<Appointment> meetings = <Appointment>[];
  DateFormat format = DateFormat("MM/dd/yyyy");

  events.forEach((element) {
    var st = (element['date'].split(" - ")[0]);
    var end = (element['date'].split(" - ")[1]);
    // print(st);
    // print(end);
    st = (format.parse(st));
    end = (format.parse(end));
    // print(st);
    // print(end);
    // print("----------------------------");
    meetings.add(Appointment(
        startTime: st,
        endTime: end,
        subject: element["description"],
        color: Colors.redAccent));
  });
  print(meetings.length);

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
