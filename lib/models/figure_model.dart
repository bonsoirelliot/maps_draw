import 'package:flutter/material.dart';
import 'package:map_draw/models/point_model.dart';

/// Модель фигуры на карте
class FigureModel {
  /// Название
  final String name;

  /// цвет соединяющей линии
  final Color lineColor;

  /// Список точек
  final List<PointModel> points;

  FigureModel({
    required this.name,
    required this.lineColor,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'lineColor': lineColor.toString(),
      'points': points,
    };
  }

  factory FigureModel.fromJson(Map<String, dynamic> json) => FigureModel(
        name: json['name'] as String,
        lineColor: Color(int.parse(json['lineColor'] as String, radix: 16)),
        points: (json['points'] as List<dynamic>)
            .map((dynamic e) => PointModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
