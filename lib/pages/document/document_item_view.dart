import 'package:hava/src/lib_view.dart';
import 'package:hava/base/const.dart';
import 'package:hava/base/utils.dart';
import 'package:hava/models/doc_model.dart';
import 'package:hava/screens/item_doc/doc_more_view.dart';
import 'package:hava/screens/item_doc/item/item_doc_view.dart';

class DocumentItemView extends StatelessWidget {
  final String icon, nameSub;
  final DocModel model;
  final double wImg, icImg1, type;
  final int cateId;

  const DocumentItemView(
      {Key? key,
      required this.icon,
      required this.nameSub,
      required this.model,
      required this.wImg,
      required this.icImg1,
      required this.type,
      required this.cateId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = model.thumbnail;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildImg(icon, icImg1),
              const SizedBox(width: 10),
              Text(
                nameSub,
                style: Styles.cusText(color: Styles.colorB2, size: 16),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => onClickViewMore(context),
                child: Text(
                  'Xem thêm',
                  style: Styles.copyStyle(color: Styles.colorG4, fontSize: 13),
                ),
              ),
            ],
          ),
          VAll.itemSub(
            img: '${Const.urlImg}$image',
            type: type,
            onTap: () => onClickItem(context),
            wImg: wImg,
          ),
          const Divider(color: Styles.colorG3),
        ],
      ),
    );
  }

  Widget _buildImg(String icon, double icImg1) {
    return Image.asset(icon, width: icImg1, height: icImg1, fit: BoxFit.cover);
  }

  void onClickItem(context) {
    Utils.navigatePage(context, ItemDocView(model: model, nameSub: nameSub));
  }

  void onClickViewMore(context) {
    Utils.navigatePage(
        context, DocMoreView(nameSub: nameSub, model: model, cateId: cateId));
  }
}
