import 'package:gano/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/styles.dart';
import '../../app/core/utils/svg_images.dart';
import '../provider/main_page_provider.dart';
import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Container(
          width: context.width,
          decoration: BoxDecoration(
              color: Styles.WHITE_COLOR,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, -2),
                    spreadRadius: 2,
                    blurRadius: 10)
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.homeIcon,
                    isSelected: provider.selectedIndex == 0,
                    onTap: () => provider.updateDashboardIndex(0),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.statisticsIcon,
                    isSelected: provider.selectedIndex == 1,
                    onTap: () => provider.updateDashboardIndex(1),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.profileIcon,
                    isSelected: provider.selectedIndex == 2,
                    onTap: () => provider.updateDashboardIndex(2),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.moreSquareIcon,
                    isSelected: provider.selectedIndex == 3,
                    onTap: () => provider.updateDashboardIndex(3),
                  ),
                ),
              ]));
    });
  }
}
