class HomeModel {
  String? name;
  String? phone;

  HomeModel({this.name, this.phone});

  HomeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
