class User {
  int id;
  String name;
  String username;
  String email;
  String phone;

  User({this.id, this.name, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }

  @override
  bool operator ==(o) => o is User && o.id == id;

  @override
  int get hashCode => id.hashCode;
}
