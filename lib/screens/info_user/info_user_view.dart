import 'info_user_presenter.dart';
import 'package:hava/src/lib_view.dart';

class InfoUserView extends StatefulWidget {
  final bool isFirstLg;

  const InfoUserView({Key? key, required this.isFirstLg}) : super(key: key);

  @override
  _InfoUserViewState createState() => _InfoUserViewState();
}

class _InfoUserViewState extends State<InfoUserView> implements Contract {
  late InfoUserPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = InfoUserPresenter(context, this, widget.isFirstLg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin cá nhân')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(width: 0.5, color: Styles.colorG11),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    _presenter.userRes.user!.userAvatar,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Thông tin cơ bản',
              style: Styles.cusText(color: Styles.colorB4, size: 15),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: VAll.txtField(name: 'Họ và tên', con: _presenter.txtName),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: _txtFieldDate(),
            ),
            VAll.txtField(name: 'Email', con: _presenter.txtEmail, read: true),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: VAll.txtField(
                  name: 'Số điện thoại', con: _presenter.txtPhone),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: VAll.txtField(name: 'Lớp', con: _presenter.txtClass),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: VAll.txtField(name: 'Trường', con: _presenter.txtSchool),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: VAll.txtField(
                  name: 'Địa chỉ hiện tại', con: _presenter.txtAddress),
            ),
            const SizedBox(height: 30),
            Text('Giới tính', style: Styles.txtBlack(size: 14)),
            Row(
              children: [
                _buildRadio(1),
                const Text('Nam'),
                const SizedBox(width: 10),
                _buildRadio(0),
                const Text('Nữ'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          VAll.btnUpdate(name: 'Cập nhật', onTap: _presenter.onUpdate),
    );
  }

  Widget _buildRadio(int value) {
    return Radio(
      value: value,
      groupValue: _presenter.isGender,
      onChanged: _presenter.onChange,
    );
  }

  Widget _txtFieldDate() {
    return TextField(
      focusNode: AlwaysDisabledFocusNode(),
      controller: _presenter.txtDate,
      decoration: InputDecoration(
        labelText: 'Ngày sinh',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Styles.colorG3, width: 0.5),
        ),
      ),
      onTap: () => _selectDate(context),
    );
  }

  _selectDate(BuildContext context) async {
    _presenter.selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return child ?? Container();
        });
    _presenter.onChangeDate();
  }

  @override
  void updateState() {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
