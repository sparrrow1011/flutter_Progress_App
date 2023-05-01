class Documents {
  String? id;
  String? number;
  String? country;

  Documents({this.id, this.number, this.country});

  factory Documents.fromJson(Map<String, dynamic> json) {
    String? id = json['id'];
    String? number = json['number'];
    String? country = json['country'];

    return Documents(id: id, number: number, country: country);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['number'] = number;
    data['country'] = country;
    return data;
  }

  @override
  String toString() {
    return '"Documents" : { "id": $id, "number": $number, "country": $country}';
  }
}