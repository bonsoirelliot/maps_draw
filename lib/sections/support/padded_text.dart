// ignore_for_file: avoid-returning-widgets

import 'package:flutter/material.dart';
import 'package:map_draw/theme/styles.dart';

List<Widget> paddedText(List<String> texts) {
  return List.generate(
    texts.length,
    (i) => Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Text(
        texts[i],
        style: AppStyles.h5,
      ),
    ),
  );
}
