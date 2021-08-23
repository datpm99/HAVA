import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hava/themes/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hava/view/guide_permission_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hava/screens/remind/model/remind_model.dart';

class Utils {
  static void showToast(String title, {bool isLong = false}) {
    if (title.isNotEmpty) {
      Fluttertoast.showToast(
        msg: title,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black.withOpacity(0.5),
        textColor: Colors.white,
      );
    }
  }

  static Future navigatePage(BuildContext context, Widget widget) async {
    return await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static Future navigateNotBack(BuildContext context, Widget widget) async {
    return await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static void _askPermission(
      {required BuildContext context,
      required Function handle,
      required Permission permission}) {
    if (Platform.isAndroid) {
      permission.status.then((value) {
        if (value == PermissionStatus.denied) {
          permission.request().then((value2) {
            if (value == PermissionStatus.granted) {
              handle();
            }
          });
        } else if (value == PermissionStatus.granted) {
          handle();
        } else {
          permission.request().then((value3) {
            if (value3 == PermissionStatus.granted) {
              handle();
            }
          });
        }
      });
    } else if (Platform.isIOS) {
      permission.status.then((value) {
        if (value == PermissionStatus.denied) {
          //first request
          permission.request().then((value) {
            if (value == PermissionStatus.granted) {
              handle();
            }
          });
        } else if (value == PermissionStatus.denied ||
                value == PermissionStatus.restricted
            // || value == PermissionStatus.disabled
            ) {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  GuidePermissionView(permission: permission)));
        } else {
          handle();
        }
      });
    }
  }

  static void askPermissionPhotos(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.photos);
  }

  static void askPermissionCamera(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.camera);
  }

  static void askPermissionStore(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.storage);
  }

  static bool validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  static bool validatePhone(String value) {
    String pattern = r"^(?:[+0]9)?[0-9]+$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  static bool validateName(String value) {
    String pattern =
        r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴýÝỶỸửữựỳỵỷỹ\s|_]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  static bool validateClass(String value) {
    String pattern =
        r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴýÝỶỸửữựỳỵỷỹ\s\w|_]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  static bool validateSlogan(String value) {
    String pattern =
        r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴýÝỶỸửữựỳỵỷỹ\s\w\\.\\,\\"|_]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  static bool validatePass(String value) {
    String pattern = r'^[a-zA-Z0-9]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  static bool validateDouble(String value) {
    String pattern = r'^[0-9]+(\.[0-9]+)?$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) return false;
    return true;
  }

  //Average.
  static List<String> listSubject = [
    'Toán học',
    'Vật lý',
    'Hóa học',
    'Sinh học',
    'Ngoại ngữ',
    'Lịch sử',
    'Địa lý',
    'GDCD',
    'Ngữ văn',
    'Tin học',
    'Thể dục',
    'Công nghệ',
    'Âm nhạc',
    'Mĩ thuật',
    'Quốc phòng',
  ];

  static List<bool> listBoolSub = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  //List DAY MONTH .
  static List<String> listDayOfWeek = [
    'T2 ',
    'T3 ',
    'T4 ',
    'T5 ',
    'T6 ',
    'T7 ',
    'CN'
  ];

  //List Default Time
  static List<int> listDfDay = [1, 2, 3, 4, 5, 6, 7];

  //Reminder model Default.
  static RemindModel modelDefault1 = RemindModel(
    id: 1,
    title: 'Đã đến giờ làm bài tập rồi!',
    time: '20:00 giờ',
    isDefault: true,
    isAlarm: false,
    listRepeat: listDfDay,
  );

  //Document
  static List<String> imgDoc = [
    'assets/icons/ic_sub1.png',
    'assets/icons/ic_sub22.png',
    'assets/icons/ic_sub3.png',
    'assets/icons/ic_sub9.png',
    'assets/icons/ic_sub8.png',
    'assets/icons/ic_sub4.png',
    'assets/icons/ic_sub5.png',
    'assets/icons/ic_sub7.png',
    'assets/icons/ic_sub6.png',
  ];

  static List<String> listSubDoc = [
    'Toán học',
    'Vật lý',
    'Hóa học',
    'Sinh học',
    'Tiếng Anh',
    'Lịch sử',
    'Địa lý',
    'GDCD',
    'Ngữ văn',
  ];

  static List<String> listTimeSub = [
    '90',
    '50',
    '50',
    '50',
    '60',
    '50',
    '50',
    '50',
    '120',
  ];

  //List Color Note
  static List<Color> listColorNote = [
    Styles.colorOr5,
    Styles.colorGreen1,
    Styles.colorP2,
    Styles.colorP3,
    Styles.colorBlue8,
    Styles.colorG16,
  ];

  //List Music Home Screen.
  static List<String> listUrlMusic = [
    'https://hava.edu.vn/themes/hava/audio/a1.mp3',
    'https://hava.edu.vn/themes/hava/audio/a2.mp3',
    'http://hava.edu.vn/themes/hava/audio/t2.mp3',
    'https://hava.edu.vn/themes/hava/audio/t1.mp3',
    'https://hava.edu.vn/themes/hava/audio/t3.mp3',
    'https://hava.edu.vn/themes/hava/audio/t4.mp3',
    'https://hava.edu.vn/themes/hava/audio/t5.mp3',
    'https://hava.edu.vn/themes/hava/audio/t6.mp3',
  ];

  //Notify.
  static String notify1 = 'Em chưa hoàn thành hết bài thi. Em có muốn NỘP BÀI?';
  static String notify2 = 'Chưa hết thời gian làm bài thi. Em có muốn NỘP BÀI?';
  static String notify3 =
      'Điểm của em thấp quá. Em bị mất gốc rồi. Hãy ôn tập lại các chương kiến thức thật kỹ rồi tiếp tục làm đề nhé. Chúc Em thành công!';
  static String notify4 =
      'Em đang ở mức trung bình thôi, cố gắng lên nào. Lên mục tiêu và kế hoạch luyện tập với Hava nhé!';
  static String notify5 =
      'Em giỏi quá! Hãy cố gắng để đạt điểm cao hơn nữa nhé. Luyện tập chăm chỉ hơn để đạt mục tiêu nha!';
  static String notify6 = 'Em quá xuất sắc! Hãy tiếp tục phát huy nhé!';
  static String notify7 =
      'Em đang làm bài thi. Em có chắc chắn muốn thoát không?';
  static String notify8 =
      'Em chưa lưu ghi chú. Em có chắc chắn muốn thoát không?';
  static String notify9 =
      'Em chưa lưu bảng điểm. Em có chắc chắn muốn thoát không?';
  static String notify10 =
      'Em có chắc chắn muốn xóa bảng điểm này không?';

  //Image Subject MyCourse.
  static List<String> imgMyCourse = [
    'assets/images/bv_sub1.png',
    'assets/images/bv_sub2.png',
    'assets/images/bv_sub3.png',
    'assets/images/bv_sub4.png',
    'assets/images/bv_sub5.png',
    'assets/images/bv_sub9.png',
    'assets/images/bv_sub9.png',
    'assets/images/bv_sub9.png',
    'assets/images/bv_sub9.png',
  ];

  //List day in gold broad.
  static List<String> dayOfWeek = [
    'Thứ 2',
    'Thứ 3',
    'Thứ 4',
    'Thứ 5',
    'Thứ 6',
    'Thứ 7',
    'Chủ Nhật',
  ];

  //List String Color Note.
  static List<String> stringColorNote = [
    'orange',
    'green',
    'pink',
    'violet',
    'blue',
    'gray',
  ];
}
