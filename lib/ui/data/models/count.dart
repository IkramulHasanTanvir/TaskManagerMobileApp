class Count {
  String? sId;
  int? sum;

  Count({this.sId, this.sum});

  Count.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }
}