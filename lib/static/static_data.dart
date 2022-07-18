import 'package:flutter/material.dart';

class StaticData {
  //* Стандартный отступ от края экрана
  static const defaultPadding = 12.0;
}

class Keys {
  //* Ключ для показа bottomSheet'ов над навигацией
  static final scaffoldKey = GlobalKey<ScaffoldState>();
}
