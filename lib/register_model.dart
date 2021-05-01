class RegisterModel {
  SignUp register;

  RegisterModel({this.register});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    register =
        json['register'] != null ? new SignUp.fromJson(json['register']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.register != null) {
      data['register'] = this.register.toJson();
    }
    return data;
  }
}

class SignUp {
  User user;
  String token;

  SignUp({this.user, this.token});

  SignUp.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String sId;
  String email;
  String phonenumber;

  User({this.sId, this.email, this.phonenumber});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    return data;
  }
}
