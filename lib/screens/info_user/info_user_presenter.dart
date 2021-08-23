import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/pages/main/main_view.dart';

import 'info_user_api_client.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/user_model.dart';
import 'package:hava/models/info_user_model.dart';

class InfoUserPresenter extends Presenter {
  InfoUserPresenter(BuildContext context, Contract view, this.isFirstLg)
      : super(context, view);
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtSchool = TextEditingController();
  TextEditingController txtClass = TextEditingController();
  int isGender = 1;
  DateTime? selectedDate;
  String dateAdd = '';
  late InfoUserApiClient _infoUserApiClient;
  final bool isFirstLg;
  String txtTitle = 'Thông tin cá nhân';

  @override
  void init() {
    super.init();
    _infoUserApiClient = InfoUserApiClient(context);
    DateTime date = DateTime.parse(userRes.user!.birthDay);
    txtName.text = userRes.user!.userName;
    String day = '${date.day}';
    if (date.day < 10) day = '0${date.day}';
    String month = '${date.month}';
    if (date.month < 10) month = '0${date.month}';
    dateAdd = '${date.year}-$month-$day';
    txtDate.text = '$day/$month/${date.year}';
    txtEmail.text = userRes.user!.userEmail;
    txtPhone.text = userRes.user!.userPhone;
    isGender = userRes.user!.sex;
    txtAddress.text = userRes.user!.address;
    txtSchool.text = userRes.user!.school;
    txtClass.text = userRes.user!.classBelong;
    if (isFirstLg) txtTitle = 'Cập nhật thông tin';
  }

  void onChange(int? value) {
    isGender = value!;
    view.updateState();
  }

  void onChangeDate() {
    if (selectedDate != null) {
      String day = '${selectedDate!.day}';
      if (selectedDate!.day < 10) day = '0${selectedDate!.day}';
      String month = '${selectedDate!.month}';
      if (selectedDate!.month < 10) month = '0${selectedDate!.month}';
      dateAdd = '${selectedDate!.year}-$month-$day';
      txtDate.text = '$day/$month/${selectedDate!.year}';
      view.updateState();
    }
  }

  void onUpdate() async {
    String name = txtName.text.trim();
    String phone = txtPhone.text.trim();
    String address = txtAddress.text.trim();
    String school = txtSchool.text.trim();
    String classBelong = txtClass.text.trim();
    if (name.isEmpty) {
      Utils.showToast('Em chưa nhập tên!');
    } else if (name.length < 3) {
      Utils.showToast('Em nhập tên quá ngắn!');
    } else if (name.length > 100) {
      Utils.showToast('Em nhập tên quá dài!');
    } else if (!Utils.validateName(name)) {
      Utils.showToast('Tên không được chứa số và ký tự đặc biệt!');
    } else if (txtDate.text.isEmpty) {
      Utils.showToast('Em chưa nhập ngày sinh!');
    } else if (phone.isEmpty) {
      Utils.showToast('Em chưa nhập số điện thoại!');
    } else if (!Utils.validatePhone(phone)) {
      Utils.showToast('Em nhập số điện thoại sai!');
    } else if (phone.substring(0, 1) != '0') {
      Utils.showToast('Em nhập số điện thoại sai!');
    } else if (phone.length < 10 || phone.length > 11) {
      Utils.showToast('Em nhập số điện thoại sai!');
    } else if (classBelong.isEmpty) {
      Utils.showToast('Em chưa nhập tên lớp!');
    } else if (classBelong.length < 2 || classBelong.length > 15) {
      Utils.showToast('Nhập tên lớp có độ dài từ 2 - 15 ký tự!');
    } else if (!Utils.validateClass(classBelong)) {
      Utils.showToast('Tên lớp không được chứa ký tự đặc biệt!');
    } else if (school.isEmpty) {
      Utils.showToast('Em chưa nhập tên trường!');
    } else if (!Utils.validateClass(school)) {
      Utils.showToast('Tên trường không được chứa ký tự đặc biệt!');
    } else if (school.length < 3) {
      Utils.showToast('Tên trường quá ngắn!');
    } else if (school.length > 190) {
      Utils.showToast('Tên trường quá dài!');
    } else if (address.isEmpty) {
      Utils.showToast('Em chưa nhập địa chỉ hiện tại!');
    } else if (address.length < 5) {
      Utils.showToast('Địa chỉ quá ngắn!');
    } else if (address.length > 190) {
      Utils.showToast('Địa chỉ quá dài!');
    } else if (!Utils.validateClass(address)) {
      Utils.showToast('Địa chỉ không được chứa ký tự đặc biệt!');
    } else {
      showLoading();
      name = name.replaceAll(RegExp(r"\s+"), " ");
      address = address.replaceAll(RegExp(r"\s+"), " ");
      school = school.replaceAll(RegExp(r"\s+"), " ");
      InfoUserModel model = InfoUserModel(
        name: name,
        phone: phone,
        birthday: dateAdd,
        sex: isGender,
        address: address,
        school: school,
        classBelong: classBelong,
      );
      await _infoUserApiClient.updateInfoUser(jsonEncode(model));
      await hideLoading();
      Utils.showToast('Cập nhập thông tin thành công!');
      UserModel userModel = UserModel(
        userId: userRes.user!.userId,
        userName: name,
        userEmail: userRes.user!.userEmail,
        userPhone: phone,
        userAvatar: userRes.user!.userAvatar,
        birthDay: dateAdd,
        sex: isGender,
        userToken: userRes.user!.userToken,
        isSocial: userRes.user!.isSocial,
        isMath: userRes.user!.isMath,
        isPhysics: userRes.user!.isPhysics,
        isChemistry: userRes.user!.isChemistry,
        isBiology: userRes.user!.isBiology,
        isEnglish: userRes.user!.isEnglish,
        isLiterature: userRes.user!.isLiterature,
        isGeography: userRes.user!.isGeography,
        isGDCD: userRes.user!.isGDCD,
        isHistory: userRes.user!.isHistory,
        address: address,
        school: school,
        classBelong: classBelong,
      );
      if (userRes.isRemember) {
        await userRes.updateUser(userModel);
      } else {
        userRes.user = userModel;
      }
      if (isFirstLg) {
        BlocProvider.of<AuthBloc>(context).add(LoginEvent(userModel));
        Utils.navigateNotBack(context, MainView());
      } else {
        userRes.isUpdateInfo = true;
        view.updateState();
      }
    }
  }
}
