import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/router/main_page.dart';
import 'package:map_draw/sections/map/map_screen.dart';
import 'package:map_draw/sections/support/support_screen.dart';

part 'router.gr.dart';

/// Роутер для навигации в приложении
@MaterialAutoRouter(
  replaceInRouteName: 'Screen|Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      path: '/',
      page: MainPage,
      children: [
        AutoRoute<dynamic>(
          path: 'map',
          page: EmptyRouterScreen,
          name: 'MapRouter',
          children: [
            AutoRoute<dynamic>(
              path: '',
              page: MapScreen,
            ),
          ],
        ),
        AutoRoute<dynamic>(
          path: 'support',
          page: EmptyRouterScreen,
          name: 'SupportRouter',
          children: [
            AutoRoute<dynamic>(
              path: '',
              page: SupportScreen,
            ),
          ],
        ),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
