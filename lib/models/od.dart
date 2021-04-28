class OD {
  final String advisor;
  final String date;
  final String time;
  final String faculty;
  final String description;
  final String stuNo;
  final String stuid;
  final String stuname;
  final int steps;
  final String formid;
  final String type;
  final String reasons;
  final String proof;
  final String proofreq;
  OD(
      {this.advisor,
      this.date,
      this.time,
      this.faculty,
      this.description,
      this.stuNo,
      this.stuid,
      this.stuname,
      this.steps,
      this.formid,
      this.type,
      this.reasons,
      this.proof,
      this.proofreq});
}

class GroupOD {
  final List stuNos;
  final List stuids;
  final List stunames;
  final String date;
  final String time;
  final String faculty;
  final String description;
  final List steps;
  final String formid;
  final String type;
  final String proof;
  final List facSteps;
  final List docIds;

  GroupOD({
    this.facSteps,
    this.date,
    this.time,
    this.faculty,
    this.description,
    this.stuNos,
    this.stuids,
    this.stunames,
    this.steps,
    this.formid,
    this.type,
    this.docIds,
    this.proof,
  });
}
