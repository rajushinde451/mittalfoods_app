import 'trey_or_trolley.dart';

class TrolleyInOut {
  int id;
  int workflow_id;
  int trolley_id;
  int product_id;
  int dryer_number;
  double in_weight;
  double out_weight;
  int trey_count;
  String status;

  List<TreyOrTrolly> treylist;

  TrolleyInOut(this.id, this.workflow_id, this.trolley_id, this.product_id, this.dryer_number, this.in_weight, this.out_weight, this.trey_count, this.status,  this.treylist);

  factory TrolleyInOut.fromJson(Map<String, dynamic> json) {

    List<TreyOrTrolly> treylistLocal=[];
    for (Map<String, dynamic> trey in json['TreyList']){
        TreyOrTrolly treyTemp = TreyOrTrolly(trey['id'], trey['weight']);
        treylistLocal.add(treyTemp);
    }


    return TrolleyInOut(
      json['id'],
      json['workflow_id'],
      json['trolley_id'],
      json['product_id'],
      json['dryer_number'],
      json['in_weight'],
      json['out_weight'],
      json['trey_count'],
      json['status'],
      treylistLocal,
    );
  }
}
