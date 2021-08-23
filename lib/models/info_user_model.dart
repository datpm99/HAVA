class InfoUserModel {
  final String name;
  final String phone;
  final String birthday;
  final int sex;
  final String address;
  final String school;
  final String classBelong;

  InfoUserModel({
    required this.name,
    required this.phone,
    required this.birthday,
    required this.sex,
    required this.address,
    required this.school,
    required this.classBelong,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'phone': phone,
        'birthday': birthday,
        'sex': sex,
        'address': address,
        'school': school,
        'classBelong': classBelong,
      };
}
