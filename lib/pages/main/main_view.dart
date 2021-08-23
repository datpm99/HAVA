import 'package:hava/screens/guide/guide_view.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/pages/document/doc_view.dart';
import 'package:hava/pages/gift/gift_view.dart';
import 'package:hava/pages/home/home_view.dart';
import 'package:hava/pages/user/user_view.dart';
import 'main_presenter.dart';

// ignore: use_key_in_widget_constructors
class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with WidgetsBindingObserver
    implements Contract {
  late MainPresenter _presenter;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _presenter.onPlayResume();
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        _presenter.onPlayPause();
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _presenter = MainPresenter(context, this);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _presenter.reSize(width, height);
    return Scaffold(
      backgroundColor: Styles.colorWhile,
      body: _buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 6,
        backgroundColor: Styles.colorWhile,
        type: BottomNavigationBarType.fixed,
        currentIndex: _presenter.bottomSelectedIndex,
        onTap: _presenter.bottomTapped,
        items: buildBottomNavBarItems(),
        selectedItemColor: Styles.colorMain,
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        onPressed: _presenter.onPlayMusic,
        elevation: 2,
        child: Image.asset(_presenter.img),
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      _btNBItem('assets/icons/ic_home.png', 'Trang chủ'),
      _btNBItem('assets/icons/ic_doc.png', 'Tài liệu'),
      _btNBItem('assets/icons/ic_gift.png', 'Quà tặng'),
      _btNBItem('assets/icons/ic_guide2.png', 'Hướng dẫn'),
      _btNBItem('assets/icons/ic_user.png', 'Cá nhân'),
    ];
  }

  BottomNavigationBarItem _btNBItem(String icon, String label) {
    double size = 24;
    return BottomNavigationBarItem(
      icon: Image(
        image: AssetImage(icon),
        width: size,
        height: size,
        color: Styles.colorG1,
      ),
      activeIcon: Image(
        image: AssetImage(icon),
        width: size,
        height: size,
        color: Styles.colorMain,
      ),
      label: label,
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _presenter.pageController,
      onPageChanged: _presenter.pageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeView(),
        DocView(),
        GiftView(),
        const GuideView(),
        const UserView(),
      ],
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _presenter.audioPlayer.stop();
    super.dispose();
  }
}
