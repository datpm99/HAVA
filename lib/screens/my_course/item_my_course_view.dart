import 'package:hava/base/utils.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/models/course_model.dart';

class ItemMyCourseView extends StatelessWidget {
  final CourseModel model;
  final Function onCourse;

  const ItemMyCourseView(
      {Key? key, required this.model, required this.onCourse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = model.title;
    if (title == 'Toán') title = 'Toán Học';
    return GestureDetector(
      onTap: () => onCourse(model.id - 1),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_course1.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(Utils.imgMyCourse[model.id - 1]),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: Styles.txtBold(color: Styles.colorY2, size: 18),
            )
          ],
        ),
      ),
    );
  }
}
