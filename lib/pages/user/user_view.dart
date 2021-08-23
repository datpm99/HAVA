import 'user_presenter.dart';
import 'package:hava/src/lib_view.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late UserPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Cá nhân')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildItemFirst(),
            _conDivider(width),
            _buildItem(
              name: 'Giới thiệu về Hava',
              icon: 'assets/icons/ic_user1.png',
              onTap: _presenter.onIntroduction,
            ),
            _buildItem(
              name: 'Kích hoạt khóa học',
              icon: 'assets/icons/ic_user3.png',
              onTap: _presenter.onActivate,
            ),
            _buildItem(
              name: 'Khóa học của tôi',
              icon: 'assets/icons/ic_user4.png',
              onTap: _presenter.onMyCourse,
            ),
            _buildItem(
              name: 'Lịch Sử',
              icon: 'assets/icons/ic_user11.png',
              onTap: _presenter.onHistory,
              type: 0,
            ),
            _conDivider(width),
            _buildItem(
              name: 'Liên hệ',
              icon: 'assets/icons/ic_user5.png',
              onTap: _presenter.onContact,
            ),
            _buildItem(
              name: 'Chia sẻ với bạn bè',
              icon: 'assets/icons/ic_user7.png',
              onTap: _presenter.onShare,
            ),
            _buildItem(
              name: 'Góp ý với chúng tôi',
              icon: 'assets/icons/ic_user8.png',
              onTap: _presenter.onEmail,
            ),
            Visibility(
              visible: _presenter.isChangePass,
              child: _buildItem(
                name: 'Đổi mật khẩu',
                icon: 'assets/icons/ic_user9.png',
                onTap: _presenter.onChangePass,
              ),
            ),
            _buildItem(
              name: 'Đăng xuất',
              icon: 'assets/icons/ic_user10.png',
              onTap: _presenter.onSignOut,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      {String name = '', String icon = '', Function()? onTap, int type = 1}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Image.asset(icon, width: 30, height: 30, fit: BoxFit.cover),
                const SizedBox(width: 7),
                Text(name, style: Styles.txtBlack(size: 14)),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Styles.colorG3),
              ],
            ),
          ),
        ),
        (type == 1) ? _buildDivider() : Container(),
      ],
    );
  }

  Widget _buildItemFirst() {
    return GestureDetector(
      onTap: _presenter.onInfoUser,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 0.5, color: Styles.colorG11),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  _presenter.userRes.user!.userAvatar,
                  width: 50,
                  height: 50,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _presenter.userRes.user!.userName,
                  style: Styles.cusText(color: Styles.colorB2),
                ),
                const SizedBox(height: 5),
                Text(
                  'Thông tin cá nhân của bạn',
                  style: Styles.txtBlack(color: Styles.colorG4),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward, color: Styles.colorG6),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
        height: 1, color: Styles.colorG3, endIndent: 15, indent: 50);
  }

  Widget _conDivider(width) {
    return Container(width: width, height: 4, color: Styles.colorG7);
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
