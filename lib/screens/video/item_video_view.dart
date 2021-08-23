import 'package:hava/src/lib_view.dart';
import 'package:flutter/widgets.dart';
import 'package:hava/base/const.dart';
import 'package:hava/base/utils.dart';
import 'package:hava/models/video_model.dart';
import 'play_video/play_video_view.dart';

class ItemVideoView extends StatelessWidget {
  final double margin;
  final VideoModel model;
  final int type;

  const ItemVideoView(
      {Key? key, required this.margin, required this.model, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 45) / 2;
    double height = width / (1 / 0.8) - 40;
    String title = model.title;
    String image = model.thumbnail;
    return GestureDetector(
      onTap: () => onPlayVideo(context, type),
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: margin),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: VAll.boxShadow(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  '${Const.urlImg}$image',
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Text(
                title,
                style: Styles.copyStyle(
                  color: Styles.colorB2,
                  height: 1.15,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: type,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPlayVideo(context, int type) {
    if (type == 2) {
      Utils.navigatePage(context, PlayVideoView(model: model));
    } else {
      Utils.navigateNotBack(context, PlayVideoView(model: model));
    }
  }
}
