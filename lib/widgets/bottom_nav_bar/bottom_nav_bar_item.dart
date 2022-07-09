import 'package:flutter/material.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/theme/theme.dart';

class BottomNavBarItem extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isSelected;
  final IconData icon;
  final String name;
  const BottomNavBarItem({
    required this.icon,
    required this.name,
    this.onPressed,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      color: isSelected ? AppTheme.coral.withOpacity(.3) : Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 24,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                name.toUpperCase(),
                style: AppStyles.h5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
