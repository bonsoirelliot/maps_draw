import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/widgets/notifications/default_notification.dart';

void showNotification(
  BuildContext context,
  String title, {
  String? subtitle,
}) {
  _showNotification(
    context: context,
    title: title,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

void showError(
  BuildContext context,
  String title, {
  String? subtitle,
}) {
  _showNotification(
    context: context,
    title: title,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

void _showNotification({
  required BuildContext context,
  required String title,
  Color? backgroundColor,
  Color? textColor,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(
        StaticData.defaultPadding,
      ),
      backgroundColor: Colors.transparent,
      content: DefaultNotification(
        title: title,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    ),
  );
}
