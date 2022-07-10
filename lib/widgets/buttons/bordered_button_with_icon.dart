import 'package:flutter/cupertino.dart';
import 'package:map_draw/theme/styles.dart';

class BorderedButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BorderedButtonWithIcon({
    required this.text,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: AppStyles.h5,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
