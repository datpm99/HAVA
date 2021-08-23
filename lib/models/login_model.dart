class LoginModel {
  final String username;
  final String password;

  LoginModel({required this.username, required this.password});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'password': password,
      };
}

class InfoLgModel {
  final EntityModel entityModel;
  final String token;

  InfoLgModel({required this.entityModel, required this.token});

  factory InfoLgModel.fromJson(Map<String, dynamic> json) {
    return InfoLgModel(
      entityModel: EntityModel.fromJson(json['UserEntityDTO']),
      token: json['jwt'],
    );
  }
}

class EntityModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String avatar;
  final String birthday;
  final int sex;
  final String classBelong;
  final String school;

  EntityModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.birthday,
    required this.sex,
    required this.classBelong,
    required this.school,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    return EntityModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      avatar: json['avatar'] ?? '',
      birthday: json['birthday'] ?? '',
      sex: json['sex'] ?? 1,
      classBelong: json['classBelong'] ?? '',
      school: json['school'] ?? '',
    );
  }
}

class LoginSocialModel {
  final String? name;
  final String email;
  final String pass;
  final int fbID;
  final String avatar;

  LoginSocialModel(
      {this.name,
      required this.email,
      required this.pass,
      required this.fbID,
      required this.avatar});

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'name': name,
        'email': email,
        'password': pass,
        'fbID': fbID,
        'avatar': avatar,
      };
}

class SendEmailModel {
  final String toEmail;

  SendEmailModel({required this.toEmail});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'toEmail': toEmail,
      };
}

class RegisterModel {
  final String name;
  final String email;
  final String pass;
  final String birthday;
  final int sex;
  final int fbID;
  final String avatar;

  RegisterModel(
      {required this.name,
      required this.email,
      required this.pass,
      required this.birthday,
      required this.sex,
      required this.fbID,
      required this.avatar});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'password': pass,
        'birthday': birthday,
        'sex': sex,
        'fbID': fbID,
        'avatar': avatar,
      };
}

class ChangePassModel {
  final String newPw;
  final String oldPw;

  ChangePassModel({required this.newPw, required this.oldPw});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'newPw': newPw,
        'oldPw': oldPw,
      };
}
