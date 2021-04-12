import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class AttendanceCalendar extends StatefulWidget {
  @override
  _AttendanceCalendarState createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(getAppointments()),
        monthViewSettings: MonthViewSettings(showAgenda: true),
      )
    );
  }
}

List<Appointment> getAppointments(){
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = 
      DateTime(today.year,today.month,today.day,9,0,0);
  final DateTime endTime = startTime.add(const Duration(hours:2));

  meetings.add(Appointment(
    startTime: startTime, 
    endTime: endTime,
    subject: 'Conference',
    color: Colors.redAccent
    ));
  
  return meetings;
}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source){
    appointments = source;

  }
}