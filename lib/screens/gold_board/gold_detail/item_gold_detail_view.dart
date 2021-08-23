import 'package:flutter/material.dart';
import 'package:hava/base/view_all.dart';
import 'package:hava/models/gold_broad_model.dart';
import 'package:hava/themes/styles.dart';

class ItemGoldDetailView extends StatelessWidget {
  final double gbImg, gbAvatar, bgHImg, fSize;
  final List<GoldBroadModel> listModel;
  final int idUser, numList, numRd;

  const ItemGoldDetailView({
    Key? key,
    required this.gbImg,
    required this.gbAvatar,
    required this.bgHImg,
    required this.fSize,
    required this.listModel,
    required this.idUser,
    required this.numList,
    required this.numRd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: width,
                height: 250,
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.only(top: 60),
                decoration: VAll.boxImg2('assets/images/bg_bv2.png'),
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.5, color: Styles.colorY3),
                ),
                child: Text(
                  '$numRd người đã tham gia',
                  style: const TextStyle(color: Styles.colorGreen1, fontSize: 12),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: _buildTable(),
          ),
          (listModel.length == 3) ? _itemLoadData() : Container(),
        ],
      ),
    );
  }

  Widget _itemLoadData() {
    return const Text('Đang cập nhập dữ liệu');
  }

  Widget _itemGold({String imgBg = '', String name = '', String avatar = ''}) {
    return Container(
      width: gbImg,
      height: bgHImg,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    List<TableRow> tbRow = [];
    tbRow.add(tbRow1());
    tbRow.addAll(_buildListGen());
    return Table(
      border: TableBorder.all(width: 0.5, color: Styles.colorG3),
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: FlexColumnWidth(),
      },
      children: tbRow,
    );
  }

  TableRow tbRow1() {
    return TableRow(children: [
      _buildTitle(name: 'TOP'),
      _buildTitle(name: '   Họ và Tên   '),
      _buildTitle(name: 'Điểm'),
      _buildTitle(name: 'Thời gian làm bài'),
    ]);
  }

  List<TableRow> _buildListGen() {
    List<TableRow> tbRow = List<TableRow>.generate(listModel.length, (index) {
      if (listModel[index].userId == idUser) {
        String stt =
            (listModel[index].stt == 0) ? '...' : '${listModel[index].stt}';
        String mark =
            (listModel[index].mark == 0.0) ? '...' : '${listModel[index].mark}';
        String minute = (listModel[index].minute == 0)
            ? '...'
            : '${listModel[index].minute}';
        return tbRowHigh(stt, listModel[index].name, mark, minute);
      }
      return TableRow(children: [
        _buildTxt(name: '${listModel[index].stt}'),
        _buildTxt(name: listModel[index].name),
        _buildTxt(name: '${listModel[index].mark}'),
        _buildTxt(name: '${listModel[index].minute}'),
      ]);
    });
    return tbRow;
  }

  TableRow tbRowHigh(String top, String name, String mark, String time) {
    return TableRow(children: [
      _buildTitleHigh(name: top),
      _buildTitleHigh(name: name),
      _buildTitleHigh(name: mark),
      _buildTitleHigh(name: time),
    ]);
  }

  Widget _buildTitleHigh({String name = ''}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 40,
      color: Colors.white,
      child: Text(
        name,
        style: Styles.copyStyle(
          color: Styles.colorRed3,
          fontSize: fSize,
          height: 1.15,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTitle({String name = ''}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 40,
      color: Styles.colorOr4,
      child: Text(
        name,
        style: Styles.copyStyle(
          color: Colors.black,
          fontSize: fSize,
          height: 1.15,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTxt({String name = ''}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      height: 40,
      child: Text(
        name,
        style: Styles.copyStyle(
          color: Styles.colorB2,
          fontSize: fSize,
          height: 1.15,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
