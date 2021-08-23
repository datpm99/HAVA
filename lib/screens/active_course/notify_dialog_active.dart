import 'active_course_view.dart';
import 'package:hava/base/utils.dart';
import 'package:hava/src/lib_view.dart';

class NotifyDialogActive extends StatelessWidget {
  final Function() onBack;

  const NotifyDialogActive({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VAll.sheetTitle(paddingS: 15.0, name: 'Thông báo!', onTap: onBack),
          const Divider(height: 1, color: Styles.colorG3),
          const SizedBox(height: 20),
          const Text('Em chưa kích hoạt khóa học này!'),
          const SizedBox(height: 20),
          Center(
            child: FlatButton(
              color: Styles.colorOr3,
              onPressed: () => onActiveCourse(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text('Kích hoạt ngay!',
                  style: Styles.copyStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void onActiveCourse(context) async {
    await Utils.navigatePage(context, const ActiveCourseView());
    Navigator.pop(context);
  }
}
