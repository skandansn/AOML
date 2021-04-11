class OD {
  final String id;
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
      {
      this.id,
      this.advisor,
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

class GroupOD extends OD {
  final String head;
  final List stuNos;
  final List stuids;
  final List stunames;

  GroupOD(
      {advisor,
      date,
      time,
      faculty,
      description,
      steps,
      formid,
      type,
      reasons,
      proof,
      proofreq,
      this.head,
      this.stuNos,
      this.stuids,
      this.stunames})
      : super(
            proofreq: proofreq,
            reasons: reasons,
            proof: proof,
            advisor: advisor,
            date: date,
            time: time,
            faculty: faculty,
            description: description,
            steps: steps,
            formid: formid);
}
