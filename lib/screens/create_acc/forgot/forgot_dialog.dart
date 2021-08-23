import 'package:flutter/material.dart';
import 'package:hava/src/lib_view.dart';

class ForgotDialog extends StatelessWidget {
  final String email;

  const ForgotDialog({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thông báo!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Mật khẩu mới đã được gửi đến email',
            style: Styles.txtBlack(size: 15),
          ),
          const SizedBox(height: 5),
          Text(email, style: Styles.cusText(color: Styles.colorB2, size: 15)),
          const SizedBox(height: 5),
          Text(
            'Em vui lòng kiểm tra lại email của mình!',
            style: Styles.txtBlack(size: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => onBack(context),
          child: const Text('OK', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  void onBack(context) {
    Navigator.pop(context);
  }
}
