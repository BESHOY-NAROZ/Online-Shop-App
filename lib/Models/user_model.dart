class UserModel {
  String name;
  String email;
  String phone;
  String uID;

  UserModel({this.name, this.email, this.phone, this.uID});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uID = json['uID'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uID': uID,
    };
  }
}
