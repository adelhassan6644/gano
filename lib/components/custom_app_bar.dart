import 'package:flutter/services.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import '../../app/core/utils/styles.dart';
import '../../app/core/utils/dimensions.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withCart;
  final bool withBack;
  final int? savedItemId;
  final bool withBorder;
  final bool withBackGround;
  final bool isOffer;
  final double? actionWidth;
  final Color? colorBG;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.withCart = false,
      this.savedItemId,
      this.withBackGround = true,
      this.withBorder = false,
      this.withBack = true,
      this.isOffer = true,
      this.actionWidth,
      this.colorBG,
      this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: context.width,
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        decoration: BoxDecoration(color: colorBG),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            withBack
                ? InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.portraitUp,
                      ]);
                      CustomNavigator.pop();
                    },
                    radius: 100,
                    child: customImageIconSVG(
                        imageName: SvgImages.arrowRight,
                        width: 30,
                        height: 30,
                        color: Styles.PRIMARY_COLOR),
                  )
                : SizedBox(
                    width: actionWidth ?? 30,
                  ),
            const Expanded(child: SizedBox()),
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold
                  .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 18),
            ),
            const Expanded(child: SizedBox()),
            actionChild ??
                const SizedBox(
                  width: 30,
                ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(15005, 45);
}
