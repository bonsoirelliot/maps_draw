import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';

class BottomSheetTrack extends StatelessWidget {
  const BottomSheetTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 84,
      margin: const EdgeInsets.symmetric(
        vertical: StaticData.defaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.black,
      ),
    );
  }
}
