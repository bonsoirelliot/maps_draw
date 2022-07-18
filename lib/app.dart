import 'package:flutter/material.dart';
import 'package:map_draw/router/router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MapDraw extends StatelessWidget {
  MapDraw({Key? key}) : super(key: key);

  // ignore: member-ordering-extended
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        minWidth: 375,
      ),
    );
  }
}
