import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/theme/styles.dart';

class CustomPicker extends StatelessWidget {
  final List<String>? items;
  final VoidCallback? onCreateNewFigurePressed;
  final Function(int)? onFigureSelected;
  const CustomPicker({
    required this.items,
    this.onCreateNewFigurePressed,
    this.onFigureSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: StaticData.defaultPadding,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          if (onCreateNewFigurePressed != null) ...[
            InkWell(
              onTap: onCreateNewFigurePressed,
              child: Row(
                children: const [
                  Icon(Icons.add),
                  Text(
                    'Добавить новую фигуру',
                    style: AppStyles.h5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
          if (items != null)
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, i) => InkWell(
                onTap: () {
                  onFigureSelected?.call(i);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        items![i],
                        style: AppStyles.h5,
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: items!.length,
            ),
        ],
      ),
    );
  }
}
