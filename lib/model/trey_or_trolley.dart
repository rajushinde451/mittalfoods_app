
class TreyOrTrolly {
  int id;
  double weight;

  TreyOrTrolly(
      this.id,
      this.weight
      );

    factory TreyOrTrolly.fromJson(Map<String, dynamic> json) {
      return TreyOrTrolly(
              json['id'],
              json['weight'],
            );
  }
}
