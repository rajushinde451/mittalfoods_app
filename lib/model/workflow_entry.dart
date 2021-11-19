import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class WorkflowEntry {
  int id;
  DateTime startTime;
  DateTime entryTime;
  DateTime exitTime;
  int shiftNumber;
  String operatorName;
  String status;
  int dryer;
  int trolleys;
  int treys;
  double inWeight;
  double outWeight;

  WorkflowEntry(
      this.id,
      this.startTime,
      this.entryTime,
      this.exitTime,
      this.shiftNumber,
      this.operatorName,
      this.status,
      this.dryer,
      this.trolleys,
      this.treys,
      this.inWeight,
      this.outWeight);

    factory WorkflowEntry.fromJson(Map<String, dynamic> json) {
      DateTime x= DateFormat("dd MMM yyyy hh:mm", "en_US").parse(json['start_time'].substring(5,22));
      return WorkflowEntry(
              json['id'],
              x,
              x,
              x,
              //DateTime.parse(json['start_time'].substring(5,22)),
              //DateTime.parse(json['start_time']),
              //DateTime.parse(json['start_time']),
              json['shift_number'],
              json['operator_name'],
              json['status'],
              json['shift_number'],
              json['shift_number'],
              json['shift_number'],
              10.0,//double.parse(json['shift_number']),
              11.0 //double.parse(json['shift_number'])
            );
  }
}
