import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/components/custom_button.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';

class TotalCoinsWidget extends StatelessWidget {
  const TotalCoinsWidget({Key? key, this.points, this.weekPoints})
      : super(key: key);

  final String? points;
  final String? weekPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: const DecorationImage(
              image: AssetImage(Images.coinsBg), fit: BoxFit.cover)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated("my_points", context),
              style: AppTextStyles.medium
                  .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 16),
            ),
            SizedBox(
              height: 6.h,
            ),
            RichText(
              text: TextSpan(
                  text: "+$weekPoints ${getTranslated("point", context)} ",
                  style: AppTextStyles.regular
                      .copyWith(color: Styles.GREEN, fontSize: 14),
                  children: [
                    TextSpan(
                      text: getTranslated("in_this_week", context),
                      style: AppTextStyles.regular
                          .copyWith(color: Styles.DETAILS_COLOR, fontSize: 14),
                    )
                  ]),
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: "+$points ",
                        style: AppTextStyles.semiBold
                            .copyWith(color: Styles.TITLE, fontSize: 42),
                        children: [
                          TextSpan(
                            text: getTranslated("point", context),
                            style: AppTextStyles.regular
                                .copyWith(color: Styles.TITLE, fontSize: 14),
                          )
                        ]),
                  ),
                ),
                CustomButton(
                    text: getTranslated("transfer", context),
                    backgroundColor: Styles.PRIMARY_COLOR,
                    width: 120,
                    height: 40,
                    lIconWidget: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                      color: Styles.WHITE_COLOR,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
