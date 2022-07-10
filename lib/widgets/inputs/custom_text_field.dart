import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  const CustomTextField({
    this.hintText,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(),
      ),
      child: Platform.isIOS
          ? CupertinoTextField.borderless(
              controller: controller,
              placeholder: hintText,
              placeholderStyle: AppStyles.h5.copyWith(
                color: AppTheme.gray,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              style: AppStyles.h5,
              cursorColor: Colors.black,
            )
          : TextField(
              controller: controller,
              style: AppStyles.h5,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: AppStyles.h5.copyWith(
                  color: AppTheme.gray,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
    );
  }
}
