import 'package:flutter/material.dart';

/// Стандартные тени, во всем приложении такие
List<BoxShadow> defaultShadows() => [
      BoxShadow(
        blurRadius: 14,
        offset: const Offset(2, 2),
        color: Colors.black.withOpacity(.3),
      ),
    ];

/// Стандартные тени, но двойные
List<BoxShadow> doubleShadows() => [
      BoxShadow(
        blurRadius: 14,
        offset: const Offset(2, 2),
        color: Colors.black.withOpacity(.3),
      ),
      BoxShadow(
        blurRadius: 14,
        offset: const Offset(-2, -2),
        color: Colors.black.withOpacity(.3),
      ),
    ];
