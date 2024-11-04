class UserModel {
  String? sId;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;
  String? createdDate;

  UserModel(
      {this.sId,
        this.email,
        this.firstName,
        this.lastName,
        this.mobile,
        this.password,
        this.createdDate});

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['password'] = password;
    data['createdDate'] = createdDate;
    return data;
  }
}
