import 'package:flutter/material.dart';
import 'package:map_draw/theme/theme.dart';

/// Стандартная круглая кнопка с иконкой
class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const CircleButton({
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Material(
        borderRadius: BorderRadius.circular(100),
        color: AppTheme.coral,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onPressed,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
