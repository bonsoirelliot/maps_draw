import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/theme/theme.dart';

class DefaultNotification extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  const DefaultNotification({
    required this.title,
    this.backgroundColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor ?? AppTheme.coral,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: StaticData.defaultPadding,
        vertical: 8,
      ),
      child: Text(
        title,
        style: AppStyles.h5.copyWith(
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
