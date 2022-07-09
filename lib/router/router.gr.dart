// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainPage());
    },
    MapRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterScreen());
    },
    SupportRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterScreen());
    },
    MapRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MapScreen());
    },
    SupportRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SupportScreen());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MainRoute.name, path: '/', children: [
          RouteConfig(MapRouter.name,
              path: 'map',
              parent: MainRoute.name,
              children: [
                RouteConfig(MapRoute.name, path: '', parent: MapRouter.name)
              ]),
          RouteConfig(SupportRouter.name,
              path: 'support',
              parent: MainRoute.name,
              children: [
                RouteConfig(SupportRoute.name,
                    path: '', parent: SupportRouter.name)
              ])
        ]),
        RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(MainRoute.name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [EmptyRouterScreen]
class MapRouter extends PageRouteInfo<void> {
  const MapRouter({List<PageRouteInfo>? children})
      : super(MapRouter.name, path: 'map', initialChildren: children);

  static const String name = 'MapRouter';
}

/// generated route for
/// [EmptyRouterScreen]
class SupportRouter extends PageRouteInfo<void> {
  const SupportRouter({List<PageRouteInfo>? children})
      : super(SupportRouter.name, path: 'support', initialChildren: children);

  static const String name = 'SupportRouter';
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute() : super(MapRoute.name, path: '');

  static const String name = 'MapRoute';
}

/// generated route for
/// [SupportScreen]
class SupportRoute extends PageRouteInfo<void> {
  const SupportRoute() : super(SupportRoute.name, path: '');

  static const String name = 'SupportRoute';
}
