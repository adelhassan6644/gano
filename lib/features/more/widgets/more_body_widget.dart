import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/features/invitation/page/invitation.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import 'logout_button.dart';
import 'more_button.dart';

class MoreBodyWidget extends StatelessWidget {
  const MoreBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Styles.SMOKED_WHITE_COLOR,
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_LARGE.w,
        vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
      ),
      child: Column(
        children: [
          MoreButton(
            title: getTranslated("notifications", context),
            icon: SvgImages.notifications,
            onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS),
          ),
          MoreButton(
            title: getTranslated("invite_friend", context),
            icon: SvgImages.inviteFriend,
            onTap: () => Future.delayed(
                Duration.zero,
                () => CustomSimpleDialog.parentSimpleDialog(
                    customListWidget: [const Invitation()])),
          ),
          MoreButton(
            title: getTranslated("contact_with_us", context),
            icon: SvgImages.outlineMailIcon,
            onTap: () => CustomNavigator.push(Routes.CONTACT_WITH_US),
          ),
          MoreButton(
            title: getTranslated("terms_conditions", context),
            icon: SvgImages.file,
            onTap: () => CustomNavigator.push(Routes.TERMS),
          ),
          const LogoutButton(),
        ],
      ),
    );
  }
}
