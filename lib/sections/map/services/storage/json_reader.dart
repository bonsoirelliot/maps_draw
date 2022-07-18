// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:io';

import 'package:map_draw/models/figure_model.dart';
import 'package:path_provider/path_provider.dart';

/// Класс для работы с json
class JsonReader {
  /// Возвращает путь, где лежат файлы приложения
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  /// Возвращает файл data.json, если он есть
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  /// Создает пустой json файл
  static Future<void> writeEmptyFile() async {
    final file = await _localFile;

    final models = <FigureModel>[];

    return file.writeAsStringSync(json.encode(models));
  }

  /// Записывает список фигур в файл
  static Future<void> writeToMemory(List<FigureModel> models) async {
    final file = await _localFile;

    models.map((figure) => figure.toJson()).toList();

    return file.writeAsStringSync(json.encode(models));
  }

  /// Возвращает список фигур из файла
  static Future<List<FigureModel>> readFile() async {
    final file = await _localFile;

    final contents = await file.readAsString();
    final models = (jsonDecode(contents) as List<dynamic>)
        .map(
          (dynamic e) => FigureModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();

    return models;
  }
}
