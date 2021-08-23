import 'package:hava/src/lib_view.dart';
import 'package:hava/base/const.dart';
import 'package:hava/models/feedback_model.dart';

class ItemHomeView extends StatelessWidget {
  final FeedBackModel model;

  const ItemHomeView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = model.title;
    String image = model.thumbnail;
    String description = model.description;
    String content = model.contents;

    return Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(2, 40, 2, 2),
          padding: const EdgeInsets.only(top: 45),
          decoration: VAll.decoRd5(Colors.white, 0.5, Styles.colorG3),
          child: Column(
            children: [
              Text(title, style: Styles.cusText(color: Styles.colorB2)),
              const SizedBox(height: 2),
              Text(
                description,
                style:
                    const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  content,
                  style: Styles.txtBlack(size: 12, height: 1.1),
                ),
              )
            ],
          ),
        ),
        Center(
          child: SizedBox(height: 245, width: 110, child: _buildImg(image)),
        ),
      ],
    );
  }

  Widget _buildImg(image) {
    return Stack(
      children: [
        const SizedBox(width: 110, height: 80),
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.network(
              '${Const.urlImg}$image',
              height: 80,
              width: 80,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const CircularProgressIndicator();
              },
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/img_gold.png',
            width: 110,
            height: 80,
          ),
        ),
      ],
    );
  }
}
