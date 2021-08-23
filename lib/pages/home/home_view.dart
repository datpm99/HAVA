import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/src/lib_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'home_presenter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late HomePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = HomePresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthAd = (MediaQuery.of(context).size.width - 105) / 2;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          height: 130,
          decoration: VAll.boxImg('assets/images/bg_home1.png'),
          child: _itemAppBar(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _presenter.getScheduleGold,
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                _textTitle('Tin Tức'),
                _goldBoard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _textTitle('Môn Học'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _colItem(
                      img: 'assets/images/sub_math.png',
                      name: 'TOÁN HỌC',
                      color: Styles.colorGreen1,
                      onTap: () => _presenter.onSubject(0),
                    ),
                    _colItem(
                      img: 'assets/images/sub_physics.png',
                      name: 'VẬT LÝ',
                      color: Styles.colorRed1,
                      onTap: () => _presenter.onSubject(1),
                    ),
                    _colItem(
                      img: 'assets/images/sub_chemistry.png',
                      name: 'HÓA HỌC',
                      color: Styles.colorOr1,
                      onTap: () => _presenter.onSubject(2),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _colItem(
                        img: 'assets/images/sub_biological.png',
                        name: 'SINH HỌC',
                        color: Styles.colorBlue2,
                        onTap: () => _presenter.onSubject(3),
                      ),
                      _colItem(
                        img: 'assets/images/sub_english.png',
                        name: 'TIẾNG ANH',
                        color: Styles.colorP1,
                        onTap: () => _presenter.onSubject(4),
                      ),
                      _colItem(
                        img: 'assets/images/sub_literature.png',
                        name: 'NGỮ VĂN',
                        color: Styles.colorBlue1,
                        onTap: () => _presenter.onSubject(5),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _colItem(
                      img: 'assets/images/sub_geography.png',
                      name: 'ĐỊA LÝ',
                      color: Styles.colorGreen2,
                      onTap: () => _presenter.onSubject(6),
                    ),
                    _colItem(
                      img: 'assets/images/sub_gdcd.png',
                      name: 'GDCD',
                      color: Styles.colorBlue4,
                      onTap: () => _presenter.onSubject(7),
                    ),
                    _colItem(
                      img: 'assets/images/sub_history.png',
                      name: 'LỊCH SỬ',
                      color: Styles.colorBlue3,
                      onTap: () => _presenter.onSubject(8),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: _textTitle('Tiện Ích'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _colItem(
                      img: 'assets/icons/ic_math.png',
                      name: 'Tính\nđiểm trung bình',
                      color: Styles.colorG1,
                      onTap: () => _presenter.onMore(1),
                      size: 55,
                    ),
                    _colItem(
                      img: 'assets/icons/ic_gt1.png',
                      name: 'Nhắc nhở',
                      color: Styles.colorG1,
                      onTap: () => _presenter.onMore(2),
                      size: 60,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: _textTitle('Người dùng cảm nhận'),
                ),
                CarouselSlider.builder(
                  itemCount: _presenter.list.length,
                  itemBuilder: _presenter.buildCarousel,
                  options: CarouselOptions(
                    initialPage: _presenter.indexCurrent,
                    height: 245,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: _presenter.onChangeIndex,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _presenter.list.map((e) {
                    int index = _presenter.list.indexOf(e);
                    return Container(
                      width: 8,
                      height: 8,
                      margin:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _presenter.indexCurrent == index
                            ? Styles.colorMain
                            : Styles.colorOr2,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            VAll.adView(
              img: 'assets/images/img_ad.png',
              txt: _txtGuide(),
              onTap: _presenter.onHideView,
              isShow: _presenter.isShow,
              width: widthAd,
              hGui: _presenter.userRes.hGuide,
              wGui: _presenter.userRes.wGuide,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/ic_Hava.png', width: 70, height: 25),
              GestureDetector(onTap: _presenter.onSearch, child: _imgSearch()),
            ],
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: _presenter.onUser,
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      _presenter.userRes.user!.userAvatar,
                      width: 35,
                      height: 35,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Xin chào, ', style: TextStyle(color: Colors.white)),
                Text(_presenter.userRes.user!.userName, style: Styles.txtBold())
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _goldBoard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Image.asset('assets/images/bg_exam.png', height: 160),
          Center(child: _timeExam()),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 130),
              child: _btnAccept(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeExam() {
    return Container(
      width: 200,
      height: 50,
      margin: const EdgeInsets.only(top: 84),
      decoration: VAll.boxImg2('assets/images/bg_time.png'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_presenter.titleSub, style: Styles.cusText(size: 12)),
          const SizedBox(height: 2),
          _timeExamBloc(),
        ],
      ),
    );
  }

  Widget _btnAccept() {
    return GestureDetector(
      onTap: _presenter.onGoldBoard,
      child: Image.asset(
        'assets/images/btn_accept.png',
        height: 30,
        width: 100,
      ),
    );
  }

  Widget _textTitle(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(name, style: Styles.cusText(color: Styles.colorG2, size: 15)),
    );
  }

  Widget _colItem(
      {img, name, required Color color, Function()? onTap, double size = 65}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            img,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: Styles.copyStyle(fontSize: 11.5, color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _txtGuide() {
    return GestureDetector(
      onTap: _presenter.onGuide,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Xin chào, tôi là trợ lý Hava. Nếu có thắc mắc gì nhấn ngay ',
          style: Styles.txtBlack(
            size: _presenter.userRes.sizeTxt,
            height: _presenter.userRes.heightTxt,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'vào đây',
              style: Styles.txtBlack(
                  size: _presenter.userRes.sizeTxt, color: Styles.colorBlue5),
            ),
            const TextSpan(text: ' nhé !'),
          ],
        ),
      ),
    );
  }

  Widget _imgSearch() {
    return Image.asset('assets/icons/ic_search.png', width: 35, height: 35);
  }

  Widget _timeExamBloc() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is CDExamScheduleState,
      builder: (context, state) {
        print('vao RDExam123 $state');
        return Text(
          '${_presenter.dayShow} ngày - ${_presenter.hourShow} giờ - ${_presenter.minuteShow} phút - ${_presenter.secondShow} giây',
          style: Styles.cusText(size: 10, color: Styles.colorY1),
        );
      },
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    if (!_presenter.isCancelTime){
      _presenter.timer!.cancel();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
