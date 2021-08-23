import 'package:hava/src/lib_view.dart';
import 'package:hava/base/utils.dart';
import 'model/remind_model.dart';

class ItemRemindView extends StatefulWidget {
  final RemindModel model;
  final Function onAlarm;
  final Function timeDetail;
  final Function boxDetail;
  final Function onDelete;

  const ItemRemindView(
      {Key? key,
      required this.model,
      required this.onAlarm,
      required this.timeDetail,
      required this.boxDetail,
      required this.onDelete})
      : super(key: key);

  @override
  _ItemRemindViewState createState() => _ItemRemindViewState();
}

class _ItemRemindViewState extends State<ItemRemindView> {
  bool isSwitch = true;

  @override
  void initState() {
    super.initState();
    isSwitch = widget.model.isAlarm;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: VAll.decoRd5NonBr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => widget.timeDetail(widget.model),
                child: Text(
                  widget.model.time,
                  style: Styles.cusText(size: 18, color: Styles.colorB2),
                ),
              ),
              _buildSwitch(),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () =>
                widget.model.isDefault ? null : widget.boxDetail(widget.model),
            child: Text(
              widget.model.title,
              style: Styles.appBar(color: Styles.colorB2),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Lặp lại',
            style: Styles.cusText(size: 15, color: Styles.colorB2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.model.isDefault
                      ? null
                      : widget.boxDetail(widget.model),
                  child: _buildTextDay(),
                ),
              ),
              widget.model.isDefault
                  ? Container()
                  : GestureDetector(
                      onTap: () => widget.onDelete(
                          widget.model.id, widget.model.listRepeat),
                      child: const Icon(Icons.delete, color: Colors.black45),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextDay() {
    String textTemp = '';
    for (int value in widget.model.listRepeat) {
      textTemp += Utils.listDayOfWeek[value - 1];
    }
    return Text(textTemp, style: const TextStyle(color: Colors.grey));
  }

  Widget _buildSwitch() {
    return Switch(
      activeTrackColor: Colors.deepOrange,
      activeColor: Colors.white,
      value: isSwitch,
      onChanged: (value) {
        setState(() {
          isSwitch = value;
        });
        widget.onAlarm(widget.model.id, widget.model.listRepeat,
            widget.model.time, widget.model.title, isSwitch);
      },
    );
  }
}
