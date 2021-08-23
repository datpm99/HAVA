import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hava/base/view_all.dart';
import 'package:hava/themes/styles.dart';
import 'package:screenshot/screenshot.dart';

class ResultDialog extends StatelessWidget {
  final VoidCallback onBack, onReView, onShare;
  final int numQs, numAllQues;
  final String notifyResult, time, point, nameSub;
  final ConfettiController controller;
  final ScreenshotController screenshotController;

  const ResultDialog(
      {Key? key,
      required this.onBack,
      required this.point,
      required this.numQs,
      required this.notifyResult,
      required this.onReView,
      required this.onShare,
      required this.numAllQues,
      required this.time,
      required this.controller,
      required this.screenshotController,
      required this.nameSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  imgLogo(),
                  GestureDetector(onTap: onBack, child: VAll.btnDelete()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConfettiWidget(
                    confettiController: controller,
                    blastDirectionality: BlastDirectionality.explosive,
                    numberOfParticles: 25,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                      Colors.yellow,
                    ],
                    createParticlePath: VAll.drawStar,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Em đã đạt được số điểm',
                  style: Styles.cusText(color: Styles.colorB2),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$pointđ',
                  style: Styles.cusText(color: Styles.colorMain, size: 24),
                ),
              ),
              _point(),
              Text(
                notifyResult,
                style: Styles.txtBlack(size: 13, height: 1.1),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    _btn('Chia sẻ', onShare, Styles.colorOr3,
                        Colors.white),
                    _btn('Bảng đánh giá', onReView, Styles.colorWhile,
                        Styles.colorB5),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(String name, Function() onTap, Color color1, Color color2) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: color1,
          boxShadow: VAll.boxShadow(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(name, style: Styles.copyStyle(color: color2)),
      ),
    );
  }

  Widget imgLogo() {
    return Image.asset('assets/icons/ic_hava_or.png', width: 60, height: 25);
  }

  Widget _rowTxt(String name, String txt, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: const TextStyle(color: Styles.colorB4)),
        Text(txt, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _point() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: VAll.decoR5C(Styles.colorG7),
      child: Column(
        children: [
          _rowTxt('Môn thi', nameSub, Styles.colorB4),
          const SizedBox(height: 8),
          _rowTxt('Tổng số câu', '$numAllQues', Styles.colorB4),
          const SizedBox(height: 8),
          _rowTxt('Số câu đúng', '$numQs', Styles.colorGreen1),
          const SizedBox(height: 8),
          _rowTxt('Số câu sai', '${numAllQues - numQs}', Styles.colorRed3),
          const SizedBox(height: 8),
          _rowTxt('Thời gian làm bài', time, Styles.colorB5),
        ],
      ),
    );
  }
}
