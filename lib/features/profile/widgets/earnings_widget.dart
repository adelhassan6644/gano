import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/components/custom_images.dart';
import '../../../app/core/utils/styles.dart';

class EarningsWidget extends StatelessWidget {
  const EarningsWidget({Key? key, this.views, this.coins}) : super(key: key);
  final String? views;
  final String? coins;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
              ),
              decoration: BoxDecoration(
                color: Styles.GOLD_COLOR.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.earnings,
                      color: Styles.GOLD_COLOR,
                      width: 28,
                      height: 28),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text(
                      getTranslated("earnings", context),
                      style: AppTextStyles.medium
                          .copyWith(color: Styles.GOLD_COLOR, fontSize: 16),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "+$coins ${getTranslated("point", context)} ",
                        style: AppTextStyles.regular
                            .copyWith(color: Styles.TITLE, fontSize: 14),
                        children: [
                          TextSpan(
                            text: getTranslated("in_this_week", context),
                            style: AppTextStyles.regular.copyWith(
                                color: Styles.DETAILS_COLOR, fontSize: 14),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
              ),
              decoration: BoxDecoration(
                color: Styles.PRIMARY_COLOR.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.statisticsIcon,
                      color: Styles.PRIMARY_COLOR,
                      width: 28,
                      height: 28),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text(
                      getTranslated("statistics", context),
                      style: AppTextStyles.medium
                          .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 16),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "+$views ${getTranslated("video", context)} ",
                        style: AppTextStyles.regular
                            .copyWith(color: Styles.TITLE, fontSize: 14),
                        children: [
                          TextSpan(
                            text: getTranslated("in_this_week", context),
                            style: AppTextStyles.regular.copyWith(
                                color: Styles.DETAILS_COLOR, fontSize: 14),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
