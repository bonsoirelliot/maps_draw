import 'package:flutter/material.dart';
import 'package:map_draw/sections/map/map_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MapDraw extends StatelessWidget {
  const MapDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(Nikita): запилить автоРоут
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        const MapScreen(),
        minWidth: 375,
      ),
    );
  }
}
