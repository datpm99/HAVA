import 'package:flutter/material.dart';
import 'package:hava/base/const.dart';
import 'package:hava/themes/icons_ios.dart';
import 'package:hava/themes/styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'row_step_permission.dart';

class GuidePermissionView extends StatelessWidget {
  final Permission permission;

  // ignore: use_key_in_widget_constructors
  const GuidePermissionView({required this.permission});

  _closeGuide(context) {
    Navigator.pop(context);
  }

  _openSetting(context) {
    Navigator.pop(context);
    openAppSettings();
  }

  String get _getText {
    if (permission == Permission.location ||
        permission == Permission.locationAlways) {
      return 'Location';
    } else if (permission == Permission.photos) {
      return 'Photos';
    } else if (permission == Permission.microphone) {
      return 'Microphone';
    } else if (permission == Permission.speech) {
      return 'Speech Recognition';
    }
    return 'Camera';
  }

  String get _getIcon {
    if (permission == Permission.location ||
        permission == Permission.locationAlways) {
      return IconIOS.iLocationPrivacy;
    } else if (permission == Permission.photos) {
      return IconIOS.iPhotosPrivacy;
    } else if (permission == Permission.microphone) {
      return IconIOS.icMicrophone;
    }
    return IconIOS.iPhotosPrivacy;
  }

  String get _getTitle {
    if (permission == Permission.location) {
      return '${Const.appName} need position permission always to operate with background cool fine camera notification feature';
    } else {
      return '${Const.appName} have no access "$_getText". enable this feature to use $_getText';
    }
  }

  String get _getTitleEnd {
    if (permission == Permission.location) {
      return '4. Choose always';
    } else {
      return '4. Allows the app to use it "$_getText"';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // here the desired height
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black.withOpacity(0.85),
          brightness: Brightness.dark,
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: () => _closeGuide(context),
            child: Text('Close', style: Styles.txtBold(size: 16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Text(
            _getTitle,
            textAlign: TextAlign.center,
            style: Styles.copyStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        const RowStep(icon: IconIOS.iSetting, title: '1. Open the settings app'),
        const RowStep(icon: IconIOS.iPrivacy, title: '2. Choose privacy'),
        RowStep(icon: _getIcon, title: '3. Choose "$_getText"'),
        RowStep(icon: IconIOS.iSwitch, title: _getTitleEnd),
        FlatButton(
          onPressed: () => _openSetting(context),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            child: Text(
              'Allow access',
              style: Styles.copyStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
