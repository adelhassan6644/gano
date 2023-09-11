import 'package:gano/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import '../../app/core/utils/text_styles.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/images.dart';
import '../app/core/utils/styles.dart';
import 'custom_button.dart';
import 'custom_images.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {required this.mainTextButton,
      this.subTextButton,
      required this.title,
       this.image,
       this.description,
      required this.onTapMain,
      Key? key})
      : super(key: key);
  final String? subTextButton, mainTextButton,description;
  final String title;
  final String? image;
  final Function() onTapMain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customImageIcon(
            imageName: image ?? Images.success, height: 120, width: 120),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 18, color: Styles.HEADER),
          ),
        ),
        Visibility(
          visible: description != null,
          child: Text(
            description??"",
            textAlign: TextAlign.center,
            style: AppTextStyles.regular
                .copyWith(fontSize: 14, color: Styles.SUBTITLE),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          children: [
            Visibility(
              visible: mainTextButton != null,
              child: Expanded(
                  child: CustomButton(
                onTap: onTapMain,
                text: mainTextButton ?? "",
              )),
            ),
            Visibility(
              visible: subTextButton != null,
              child: SizedBox(
                width: 16.w,
              ),
            ),
            Visibility(
              visible: subTextButton != null,
              child: Expanded(
                  child: CustomButton(
                onTap: () => CustomNavigator.pop(),
                text: subTextButton ?? getTranslated("back", context),
                backgroundColor: Styles.WHITE_COLOR.withOpacity(0.1),
                textColor: Styles.PRIMARY_COLOR,
              )),
            )
          ],
        )
      ],
    );
  }
}
