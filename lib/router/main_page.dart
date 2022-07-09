import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/router/router.dart';
import 'package:map_draw/widgets/bottom_nav_bar/bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // scaffoldKey: Keys.scaffoldKey,
      routes: const [
        MapRouter(),
        SupportRouter(),
      ],

      bottomNavigationBuilder: (_, tabsRouter) {
        final hideBottomNav = tabsRouter.topMatch.meta['hideBottomNav'] == true;

        return hideBottomNav
            ? const SizedBox()
            : BottomNavBar(
                tabsRouter: tabsRouter,
              );
      },
    );
  }
}
