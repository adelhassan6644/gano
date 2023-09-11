import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/navigation/custom_navigation.dart';
import 'package:gano/navigation/routes.dart';

import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../components/custom_button.dart';
import '../../components/custom_images.dart';

class GuestMode extends StatelessWidget {
  const GuestMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        children: [
          Expanded(
            child: ListAnimator(
              data: [
                customImageIcon(
                    imageName: Images.logo, height: 180, width: 200),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  getTranslated("register_with_us", context),
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 32,
                    color: Styles.PRIMARY_COLOR,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  getTranslated(
                      "and_enjoy_all_the_features_available_in_the_application",
                      context),
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 18, color: Styles.ACCENT_COLOR),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CustomButton(
                    text: getTranslated("login", context),
                    onTap: () =>
                        CustomNavigator.push(Routes.LOGIN, arguments: true),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
