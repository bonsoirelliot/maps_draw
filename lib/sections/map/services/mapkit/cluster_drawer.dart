import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_draw/sections/map/services/mapkit/point_drawer.dart';
import 'package:surf_lint_rules/surf_lint_rules.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Сервис отрисовки кластера
class ClusterDrawer {
  static final Random _rng = Random();

  static Future<Uint8List> buildClusterAppearance(
    Cluster cluster, {
    required Color clusterColor,
    required TextStyle clusterTextStyle,
  }) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    const size = Size(200, 200);

    final fillPaint = Paint()
      ..color = clusterColor
      ..style = PaintingStyle.fill;

    final radius = min(max(cluster.size * 6.0, 30), 50).toDouble();

    final textPainter = TextPainter(
      text: TextSpan(
        text: cluster.size.toString(),
        style: clusterTextStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  static Future<ClusterizedPlacemarkCollection> getPlacemarkCollection({
    required List<Point> points,
    required MapObjectId clusterMapId,
    required Color clusterColor,
    required TextStyle clusterTextStyle,
    Function(ClusterizedPlacemarkCollection, Cluster)? onClusterTap,
    Function(PlacemarkMapObject, Point)? onPlacemarkTap,
    Color? color,
  }) async {
    final pointAppearance = await PointDrawer.buildPointAppearance(
      radius: 20,
      pointColor: color ?? Colors.blue,
    );
    return ClusterizedPlacemarkCollection(
      mapId: clusterMapId,
      radius: 15,
      minZoom: 15,
      onClusterAdded: (
        self,
        cluster,
      ) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 0.75,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await ClusterDrawer.buildClusterAppearance(
                    cluster,
                    clusterColor: clusterColor,
                    clusterTextStyle: clusterTextStyle,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: onClusterTap,
      placemarks: List<PlacemarkMapObject>.generate(
        points.length,
        (i) {
          final rnd = _rng.nextInt(200);
          final placemarkId = 'p_${i}_${rnd}_${points[i]}';

          return PlacemarkMapObject(
            onTap: onPlacemarkTap,
            opacity: 1,
            mapId: MapObjectId(placemarkId),
            point: points[i],
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  pointAppearance,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
