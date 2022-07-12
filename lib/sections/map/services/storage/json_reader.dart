// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:io';

import 'package:map_draw/models/figure_model.dart';
import 'package:map_draw/widgets/notifications/notification_methods.dart';
import 'package:path_provider/path_provider.dart';

class JsonReader {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  static Future<void> writeEmptyFile() async {
    final file = await _localFile;

    final models = <FigureModel>[];

    // Write the file
    return file.writeAsStringSync(json.encode(models));
  }

  static Future<void> writeToMemory(List<FigureModel> models) async {
    final file = await _localFile;

    models.map((figure) => figure.toJson()).toList();

    // Write the file
    return file.writeAsStringSync(json.encode(models));
  }

  static Future<List<FigureModel>> readFile() async {
    final file = await _localFile;

    // Read the file
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
