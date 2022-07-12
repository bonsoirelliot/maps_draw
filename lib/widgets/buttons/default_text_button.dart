import 'package:flutter/material.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/theme/theme.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color disabledColor;
  final Color textColor;
  final VoidCallback? onPressed;
  const DefaultTextButton({
    required this.text,
    this.textColor = Colors.white,
    this.onPressed,
    this.backgroundColor = AppTheme.coral,
    this.disabledColor = AppTheme.gray,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: onPressed != null ? backgroundColor : disabledColor,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 34,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          // side: BorderSide(color: borderColor),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppStyles.h5.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
