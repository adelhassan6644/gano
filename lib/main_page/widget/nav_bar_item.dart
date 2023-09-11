import 'package:flutter/material.dart';
import '../../app/core/utils/styles.dart';
import '../../components/custom_images.dart';

class BottomNavBarItem extends StatelessWidget {
  final String? imageIcon;
  final String? svgIcon;
  final VoidCallback onTap;
  final bool isSelected, withIconColor;
  final String? name;
  final double width;
  final double height;

  const BottomNavBarItem({
    super.key,
    this.imageIcon,
    this.svgIcon,
    this.name,
    this.isSelected = false,
    this.withIconColor = true,
    required this.onTap,
    this.width = 18,
    this.height = 18,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Styles.PRIMARY_COLOR : Styles.WHITE_COLOR),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svgIcon != null
                ? customImageIconSVG(
                    imageName: svgIcon!,
                    color: isSelected
                        ? Styles.WHITE_COLOR
                        : withIconColor
                            ? Styles.DISABLED
                            : null,
                    width: width,
                  )
                : customImageIcon(
                    imageName: imageIcon!,
                    height: height,
                    color: isSelected
                        ? Styles.WHITE_COLOR
                        : withIconColor
                            ? Styles.DISABLED
                            : null,
                    width: width,
                  ),
            name != null
                ? Text(
                    name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color:
                          isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 11,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
