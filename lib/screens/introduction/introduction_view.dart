import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hava/base/const.dart';
import 'package:hava/themes/styles.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayerController.convertUrlToId(Const.videoYoutube) ?? '',
      params: const YoutubePlayerParams(
        autoPlay: false,
        showFullscreenButton: true,
        showControls: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Giới thiệu'),
          leading: GestureDetector(
            onTap: onBackS,
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Styles.colorOr3),
                ),
                child: YoutubePlayerIFrame(
                  controller: _controller,
                  aspectRatio: 16 / 9,
                ),
              ),
              _buildView1(width),
              _buildView2(width),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _buildView3(width),
              ),
              _buildView4(width),
              const SizedBox(height: 30),
              _buildView5(),
            ],
          ),
        ),
      ),
      onWillPop: onWillPopBack,
    );
  }

  Widget _buildView1(width) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/img_gt.png', width: width / 3),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 1),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/icons/ic_hava_or.png',
                          width: 60,
                          height: 20,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'CHÚNG TÔI LÀ AI?',
                          style:
                              Styles.txtBold(size: 13, color: Styles.colorMain),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/img_gt2.png',
                      width: 50,
                      height: 70,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Text(
                    'Hava là đơn vị chuyên cung cấp giải pháp phần mềm áp dụng công nghệ vào việc học và luyện thi THPT.\n\nHava được sáng lập bởi các bạn trẻ đam mê giáo dục, khao khát mang một nền gió mới đến cho Giáo dục Việt Nam. Mỗi sản phẩm của Hava đều nhằm khai phá và nuôi dưỡng khả năng tìm tòi, sáng tạo và tự học của mỗi học sinh.',
                    style: Styles.txtBlack(size: 11, height: 1.1),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildView2(width) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/bg_light.png',
                  width: 50,
                  height: 56,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sứ Mệnh',
                  style: Styles.txtBold(size: 13, color: Styles.colorMain),
                ),
                const SizedBox(height: 10),
                Text(
                  'Chúng tôi khao khát Giúp tất cả các bạn trẻ Việt Nam có cơ hôi trải nghiệm môi trường Đại học.\n\nBởi chúng tôi quan niệm rằng: “Đại học không phải là con đường duy nhất, song đại học lại là con đường thuận lợi nhất cho mỗi chúng ta để tiến gần hơn với ước mơ, hoài bão của mình".',
                  style: Styles.txtBlack(size: 11, height: 1.1),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Image.asset(
              'assets/images/bg_active.png',
              width: width / 2.5,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildView3(width) {
    return Image.asset(
      'assets/images/bg_gt3.png',
      width: width,
      fit: BoxFit.cover,
    );
  }

  Widget _buildView4(width) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Image.asset('assets/images/bg_gt4.png', width: width / 3),
          Expanded(
            child: Column(
              children: [
                Image.asset('assets/images/bg_gt5.png', width: 50, height: 30),
                const SizedBox(height: 30),
                Image.asset('assets/images/bg_gt6.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildView5() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tại sao bạn nên sử dụng phần mềm của chúng tôi?',
                  style: Styles.txtBold(size: 12, color: Styles.colorMain),
                ),
              ),
              Image.asset(
                'assets/images/bg_gt7.png',
                width: 80,
                height: 70,
              )
            ],
          ),
          _itemView5(
            img: 'assets/icons/ic_gt1.png',
            title: 'Đồng hồ đếm ngược',
            name: 'Giúp các em quản lý thời gian và rèn kỹ năng thi.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt2.png',
            title: 'Tư duy dưới mỗi câu hỏi',
            name: 'Định hướng tư duy, rèn trí não.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt3.png',
            title: 'Ma trận thống kê kết quả bài thi',
            name:
                'Phân tích điểm mạnh- điểm yếu, đánh giá năng lực, giúp các em định hướng ôn tập hiệu quả hơn.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt4.png',
            title: 'Nhật ký điện tử',
            name:
                'Giúp học sinh ghi chú trực tiếp những thông tin hữu ích, đặc biệt.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt5.png',
            title: 'Hệ thống chấm điểm tự động',
            name: 'Tiết kiệm thời gian học.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt6.png',
            title: 'Lời giải chi tiết',
            name:
                'Được giải bởi các bạn sinh viên xuất sắc ĐH Ngoại Thương, ĐH Kinh tế Quốc Dân, Đại học Y Hà Nội, ĐH Dược Hà Nội.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt7.png',
            title: 'Lưu kết quả làm bài',
            name:
                'Giúp học sinh biết tiến độ học tập trong suốt quá trình tự luyện tại nhà.',
          ),
          const SizedBox(height: 20),
          _itemView5(
            img: 'assets/icons/ic_gt8.png',
            title: 'Tự động chọn chế độ: Luyện tập hoặc Thi',
            name:
                'Phù hợp cho học sinh học suốt từ khi chưa đủ kiến thức đến khi sát kỳ thi.',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _itemView5({String img = '', String title = '', String name = ''}) {
    return Row(
      children: [
        Image.asset(img, width: 40, height: 40),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Styles.cusText(color: Styles.colorB2, size: 12),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: Styles.copyStyle(color: Styles.colorG2, fontSize: 10),
              ),
            ],
          ),
        )
      ],
    );
  }

  void onBackS() {
    _controller.pause();
    Navigator.of(context).pop();
  }

  Future<bool> onWillPopBack() async {
    _controller.pause();
    return true;
  }

  @override
  void dispose() {
    _controller.close();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
