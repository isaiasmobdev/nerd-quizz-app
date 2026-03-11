// lib/shared/ui_helpers.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<bool?> showAdaptiveConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  String positiveButtonLabel = 'Sim',
  String negativeButtonLabel = 'Não',
}) async {
  final platform = Theme.of(context).platform;

  if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(negativeButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(positiveButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  } else {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(negativeButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(positiveButtonLabel),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
