import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DialogHelper {
  static Future<void> showNoInternetDialog(BuildContext context) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'You have lost your internet connection. Please check your settings and try again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //   RouteNames.splash,
                //   (route) => false,
                // );
              },
            ),
          ],
        ),
      );

  static Future<void> showAppVersionDialog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final appName = packageInfo.appName;
    final version = packageInfo.version;
    String running = '';
    String model = '';

    if (Platform.isAndroid) {
      AndroidDeviceInfo andInfo = await deviceInfo.androidInfo;
      running = 'Android ${andInfo.version.release}';
      model = andInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      running = iosInfo.utsname.machine;
      model = iosInfo.model;
    }

    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text(appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Running on: $running'),
            SizedBox(height: 8),
            Text('Model: $model'),
            SizedBox(height: 8),
            Text('Version: $version'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'OK',
              style: TextStyle().copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }

  static Future<void> showPrivacyAgreementDialog(
    BuildContext context, {
    VoidCallback? yes,
    VoidCallback? no,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Dear user!'),
        content: Text(
            'We would be very grateful if you would read the policy of our application and accept the consent. Do you want to continue?'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('YES'),
            onPressed: () {
              Navigator.of(context).pop();
              yes?.call();
            },
          ),
          CupertinoDialogAction(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop();
              no?.call();
            },
          ),
        ],
      ),
    );
  }

  static Future<void> showRemoveDialog(
    BuildContext context, {
    required String title,
    VoidCallback? yes,
    VoidCallback? no,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Dear user!'),
        content: Text(title),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('YES'),
            onPressed: () {
              Navigator.of(context).pop();
              yes?.call();
            },
          ),
          CupertinoDialogAction(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop();
              no?.call();
            },
          ),
        ],
      ),
    );
  }
}
