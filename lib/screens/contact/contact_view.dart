import 'package:flutter/material.dart';
import 'package:hava/base/const.dart';
import 'package:hava/base/contract.dart';
import 'package:hava/themes/styles.dart';
import 'contact_presenter.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> implements Contract {
  late ContactPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ContactPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liên hệ')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _itemFirst(),
            const Divider(height: 1, color: Styles.colorG3),
            InkWell(
              splashColor: Colors.greenAccent,
              onTap: _presenter.onCallNumber,
              child: _buildTxt('assets/icons/ic_phone2.png', Const.phoneUs),
            ),
            const Divider(height: 1, color: Styles.colorG3),
            InkWell(
              splashColor: Colors.deepOrange,
              onTap: _presenter.onEmail,
              child:
                  _buildTxt('assets/icons/ic_email2.png', Const.emailContactUs),
            ),
            const Divider(height: 1, color: Styles.colorG3),
            InkWell(
              splashColor: Colors.lightBlueAccent,
              onTap: _presenter.onOpenMap,
              child: _buildTxt('assets/icons/ic_map.png', Const.addressUs),
            ),
            const Divider(height: 1, color: Styles.colorG3),
          ],
        ),
      ),
    );
  }

  Widget _itemFirst() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        children: [
          Image.asset('assets/icons/ic_hava_or.png', width: 34, height: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Phần mềm luyện thi Tốt Nghiệp THPT',
              style: Styles.copyStyle(color: Styles.colorB2),
            ),
          ),
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

  @override
  void updateState() {
    setState(() {});
  }
}
