import 'package:flutter/material.dart';
import 'package:hava/base/const.dart';
import 'package:hava/src/lib_view.dart';

class DialogActive extends StatelessWidget {
  final Function() onBack;
  final VoidCallback onCallNumber, onEmail, onOpenMap;

  const DialogActive(
      {Key? key,
      required this.onBack,
      required this.onCallNumber,
      required this.onEmail,
      required this.onOpenMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VAll.sheetTitle(
              paddingS: 15.0, name: 'Liên hệ với chúng tôi', onTap: onBack),
          const Divider(height: 1, color: Styles.colorG3),
          InkWell(
            splashColor: Colors.greenAccent,
            onTap: onCallNumber,
            child: _buildTxt('assets/icons/ic_phone2.png', Const.phoneUs),
          ),
          const Divider(height: 1, color: Styles.colorG3),
          InkWell(
            splashColor: Colors.deepOrange,
            onTap: onEmail,
            child:
                _buildTxt('assets/icons/ic_email2.png', Const.emailContactUs),
          ),
          const Divider(height: 1, color: Styles.colorG3),
          InkWell(
            splashColor: Colors.lightBlueAccent,
            onTap: onOpenMap,
            child: _buildTxt('assets/icons/ic_map.png', Const.addressUs),
          ),
          const Divider(height: 1, color: Styles.colorG3),
        ],
      ),
    );
  }

  Widget _buildTxt(String img, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        children: [
          Image.asset(img, width: 24, height: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Text(name, style: Styles.copyStyle(color: Styles.colorB2)),
          ),
        ],
      ),
    );
  }
}
