import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/decoration/shadows.dart';
import 'package:map_draw/widgets/bottom_nav_bar/bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final TabsRouter? tabsRouter;

  const BottomNavBar({
    this.tabsRouter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: defaultShadows(),
          ),
          padding: EdgeInsets.only(
            top: 14,
            bottom: MediaQuery.of(context).viewPadding.bottom == 0
                ? 14
                : MediaQuery.of(context).viewPadding.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavBarItem(
                  icon: Icons.home_outlined,
                  isSelected: tabsRouter?.activeIndex == 0,
                  name: 'home',
                  onPressed: () {
                    tabsRouter?.setActiveIndex(0);
                  },
                ),
                BottomNavBarItem(
                  icon: Icons.help_outline_rounded,
                  isSelected: tabsRouter?.activeIndex == 1,
                  name: 'help',
                  onPressed: () {
                    tabsRouter?.setActiveIndex(1);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
