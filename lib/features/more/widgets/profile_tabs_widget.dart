import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import 'more_button.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          MoreButton(
            title: getTranslated("favourite", context),
            icon: SvgImages.moreIcon,
            onTap: () => CustomNavigator.push(Routes.FAVOURITE),
            isProfileTab: true,
          ),
          MoreButton(
            title: getTranslated("edit_profile", context),
            icon: SvgImages.profileIcon,
            onTap: () => CustomNavigator.push(Routes.EDIT_PROFILE),
            isProfileTab: true,
          ),
          MoreButton(
            title: getTranslated("change_password", context),
            icon: SvgImages.outlineLockIcon,
            onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
            isProfileTab: true,
          ),
        ],
      ),
    );
  }
}
