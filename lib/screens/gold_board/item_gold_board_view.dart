import 'package:hava/base/utils.dart';
import 'package:hava/models/gold_broad_model.dart';
import 'package:hava/src/lib_view.dart';
import 'gold_detail/gold_detail_view.dart';

class ItemGoldBoardView extends StatelessWidget {
  final String img, name, timeExam, dayExam, examTitle;
  final int index, idSubExam, numList;
  final List<GoldBroadModel> listModel;
  final VoidCallback onStart;
  final List listAll;
  final Function seenResult;

  const ItemGoldBoardView({
    Key? key,
    required this.img,
    required this.name,
    required this.index,
    required this.listModel,
    required this.idSubExam,
    required this.timeExam,
    required this.dayExam,
    required this.onStart,
    required this.examTitle,
    required this.listAll,
    required this.seenResult,
    required this.numList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          (idSubExam == index) ? _buildSubExam() : _buildSub(),
          _buildGold(context),
        ],
      ),
    );
  }

  Widget _buildSub() {
    return Container(
      width: 200,
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      margin: const EdgeInsets.only(left: 12),
      decoration: VAll.boxImg2('assets/images/bg_course1.png'),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(img, width: 60, height: 40),
              Text(
                name,
                style: Styles.txtBold(color: Styles.colorY2, size: 16),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Image.asset('assets/images/div_bv.png', height: 2),
          ),
          Text(
            'ĐÃ KẾT THÚC',
            style: Styles.txtBold(color: Colors.white, size: 14),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => seenResult(index, listModel[0].examId),
            child: Image.asset(
              'assets/images/btn_bv.png',
              width: 140,
              height: 40,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSubExam() {
    return Container(
      width: 200,
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      margin: const EdgeInsets.only(left: 12),
      decoration: VAll.boxImg2('assets/images/bg_course1.png'),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(img, width: 60, height: 40),
              Text(
                name,
                style: Styles.txtBold(color: Styles.colorY2, size: 16),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Image.asset('assets/images/div_bv.png', height: 2),
          ),
          Text(
            examTitle,
            style: Styles.txtBold(color: Colors.white, size: 14),
          ),
          const SizedBox(height: 5),
          Text(
            timeExam,
            style: const TextStyle(
              fontSize: 16,
              color: Styles.colorY3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            dayExam,
            style: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onStart,
            child: Image.asset(
              'assets/images/btn_not_ac2.png',
              width: 120,
              height: 30,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'LƯU Ý: SAU THỜI GIAN THI 15 PHÚT HỆ THỐNG SẼ ĐÓNG CỬA',
            style: TextStyle(color: Colors.white, fontSize: 8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGold(context) {
    return Container(
      width: 400,
      height: 250,
      padding: const EdgeInsets.only(top: 55),
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: VAll.boxImg2('assets/images/bg_bv1.png'),
      child: Column(
        children: [
          (listModel.isNotEmpty)
              ? _itemGold(
                  imgBg: 'assets/images/bv_1st.png',
                  avatar: listModel[0].avatar,
                  name: listModel[0].name,
                )
              : const SizedBox.shrink(),
          (listModel.length - numList >= 2)
              ? _itemGold(
                  imgBg: 'assets/images/bv_2st.png',
                  avatar: listModel[1].avatar,
                  name: listModel[1].name,
                )
              : const SizedBox.shrink(),
          (listModel.length - numList >= 3)
              ? _itemGold(
                  imgBg: 'assets/images/bv_3st.png',
                  avatar: listModel[2].avatar,
                  name: listModel[2].name,
                )
              : const SizedBox.shrink(),
          GestureDetector(
            onTap: () => onMore(context, listAll),
            child: Image.asset('assets/images/btn_bv2.png', height: 25),
          )
        ],
      ),
    );
  }

  Widget _itemGold({String imgBg = '', String name = '', String avatar = ''}) {
    return Container(
      width: 220,
      height: 48,
      padding: const EdgeInsets.only(left: 30),
      decoration: BoxDecoration(image: VAll.decoImg2(imgBg)),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 0.5, color: Styles.colorG6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                avatar,
                width: 30,
                height: 30,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : const CircularProgressIndicator();
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            name,
            style: Styles.txtBlack(),
            overflow: TextOverflow.ellipsis,
          )),
        ],
      ),
    );
  }

  void onMore(context, List listAll) {
    Utils.navigatePage(context,
        GoldDetailView(listAll: listAll, numList: numList, index: index));
  }
}
