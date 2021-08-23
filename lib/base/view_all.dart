import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hava/themes/styles.dart';

class VAll {
  static List<BoxShadow> boxShadow() {
    return [
      const BoxShadow(
        color: Colors.black26,
        blurRadius: 1.0,
        offset: Offset(0.0, 1.0),
      ),
    ];
  }

  static Decoration decoRd5(color, width, color1) {
    return BoxDecoration(
      color: color,
      border: Border.all(width: width, color: color1),
      borderRadius: BorderRadius.circular(5),
      boxShadow: boxShadow(),
    );
  }

  static Decoration decoRd5Non() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(width: 0.5, color: Styles.colorG11),
    );
  }

  static Decoration decoRd30(color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
      boxShadow: boxShadow(),
    );
  }

  static Decoration deco2Rd5(color) {
    return BoxDecoration(
      color: color,
      border: Border.all(width: 0.5, color: Styles.colorG3),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    );
  }

  static Decoration deco3Rd5() {
    return BoxDecoration(
      color: Styles.colorG10,
      border: Border.all(width: 0.5, color: Styles.colorG3),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
    );
  }

  static Decoration decoRd5NonBr() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: boxShadow(),
      borderRadius: BorderRadius.circular(5),
    );
  }

  static DecorationImage decoImg(img) {
    return DecorationImage(image: AssetImage(img), fit: BoxFit.cover);
  }

  static DecorationImage decoImg2(img) {
    return DecorationImage(image: AssetImage(img), fit: BoxFit.contain);
  }

  static Decoration decoCR() {
    return BoxDecoration(
      color: Styles.colorMain,
      borderRadius: BorderRadius.circular(5),
    );
  }

  static Decoration decoCR2() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(width: 0.5, color: Styles.colorG6),
    );
  }

  static Decoration decoR5C(Color color) {
    return BoxDecoration(borderRadius: BorderRadius.circular(5), color: color);
  }

  static Decoration boxImg(img) {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
    );
  }

  static Decoration boxImg22(img) {
    return BoxDecoration(
      color: Colors.deepOrange,
      image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
    );
  }

  static Decoration boxImg2(img) {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage(img)),
    );
  }

  static Decoration decoNonShadow(color, width, color1) {
    return BoxDecoration(
      color: color,
      border: Border.all(width: width, color: color1),
      borderRadius: BorderRadius.circular(5),
    );
  }

  static Decoration decoCirImg(img) {
    return BoxDecoration(
      shape: BoxShape.circle,
      image: decoImg(img),
    );
  }

  static Widget txtField(
      {name, required TextEditingController con, bool read = false}) {
    return TextField(
      controller: con,
      decoration: InputDecoration(
        labelText: name,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Styles.colorG3, width: 0.5),
        ),
      ),
      readOnly: read,
    );
  }

  static Widget imgLight() {
    return Image.asset('assets/icons/ic_lb1.png', width: 20, height: 20);
  }

  ///Login Screen.
  static Widget iconLogin(
      {double mrTop = 0, double mrBot = 0, double hImg = 0, double width = 0}) {
    return Container(
      margin: EdgeInsets.only(
        top: mrTop,
        bottom: mrBot,
      ),
      child: Image(
        image: const AssetImage('assets/images/Svg_Hava.png'),
        height: hImg,
        width: width / 1.5,
      ),
    );
  }

  static Widget cBox(context, bool isBool, Function(bool?)? onTap) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white,
      ),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Checkbox(
          value: isBool,
          onChanged: onTap,
        ),
      ),
    );
  }

  static Widget btnAcc(
      {String name = '', Function()? onTap, double width = 0}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width / 1.4,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: decoRd30(Styles.colorOr3),
        child: Text(
          name,
          style: Styles.copyStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  static Widget fieldName(
      {String name = '', required TextEditingController con}) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: decoRd5Non(),
      child: TextField(
        controller: con,
        decoration: InputDecoration(
          hintText: name,
          hintStyle: Styles.copyStyle(color: Styles.colorG2),
          border: InputBorder.none,
        ),
      ),
    );
  }

  static Widget fieldPass({name, controller, pass, Function()? onTap}) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: decoRd5Non(),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
          hintStyle: Styles.copyStyle(color: Styles.colorG2),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              pass ? Icons.visibility_off : Icons.visibility,
              color: Colors.black45,
            ),
          ),
        ),
        obscureText: pass,
      ),
    );
  }

  ///Home Screen.
  static Widget adView(
      {img, isShow, width, wGui, hGui, txt, Function()? onTap}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Visibility(
        visible: isShow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 8, left: 8),
                  alignment: Alignment.center,
                  decoration: decoRd5(Colors.white, 0.75, Styles.colorMain),
                  child: txt,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Image.asset(
                    'assets/icons/ic_delete.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Image.asset(img, width: wGui, height: hGui),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  ///Document Screen.
  static Widget itemSub(
      {double type = 0, double wImg = 0, img, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150 - wImg,
        height: 150 - type - wImg,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 7, bottom: 15),
        decoration: decoRd5(Colors.white, 0.5, Styles.colorG3),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Styles.colorG6),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(img, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }

  ///Bottom Sheet.
  static Widget btnUpdate({name = 'Cập nhật', Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: decoRd30(Styles.colorOr3),
        child: Text(name, style: Styles.cusText(color: Colors.white)),
      ),
    );
  }

  static Widget sheetTitle({name, paddingS, Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.all(paddingS),
      child: Row(
        children: [
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              name,
              style: Styles.txtBold(color: Styles.colorB2, size: 16),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: btnDelete(),
          ),
        ],
      ),
    );
  }

  static Widget sheetField(
      {name, required TextEditingController txtName, ver = 20.0, hor = 10.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      child: TextField(
        controller: txtName,
        decoration: InputDecoration(
          labelText: name,
          labelStyle: Styles.copyStyle(color: Styles.colorG9),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Styles.colorG3, width: 0.5),
          ),
        ),
      ),
    );
  }

  static Decoration decoSheet() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
    );
  }

  //Note
  static Widget btnNote(Function()? onTap) {
    return FlatButton(
      shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      splashColor: Colors.white12,
      onPressed: onTap,
      child: Image.asset('assets/icons/ic_note.png', width: 24, height: 24),
    );
  }

  static Widget fabSubject(Function()? onTap) {
    return FloatingActionButton(
      backgroundColor: Styles.colorMain,
      elevation: 0,
      onPressed: onTap,
      child: const Icon(Icons.check_box),
    );
  }

  static ShapeBorder shapeSheet() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(18),
        topLeft: Radius.circular(18),
      ),
    );
  }

  static Widget btnDelete() {
    return Image.asset('assets/icons/ic_delete.png', width: 24, height: 24);
  }

  static Widget rowSheet(Function()? onTap, String name, String length) {
    return Row(
      children: [
        Expanded(child: txtBloc(name, length)),
        GestureDetector(
          onTap: onTap,
          child: btnDelete(),
        ),
      ],
    );
  }

  static Widget txtBloc(String name, String length) {
    return RichText(
      text: TextSpan(
        text: 'Đã trả lời ',
        style: Styles.cusText(color: Styles.colorB2),
        children: <TextSpan>[
          TextSpan(
            text: '$name/$length',
            style: Styles.cusText(color: Styles.colorGreen1, size: 16),
          ),
          TextSpan(
            text: ' câu',
            style: Styles.cusText(color: Styles.colorB2),
          ),
        ],
      ),
    );
  }

  static Widget btnPrint(Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(right: 8),
        decoration: decoCR(),
        child: Row(
          children: const [
            Icon(Icons.print, size: 14, color: Colors.white),
            SizedBox(width: 4),
            Text('In đề', style: TextStyle(fontSize: 11, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  static Widget leadingAppbar(Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  static Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
