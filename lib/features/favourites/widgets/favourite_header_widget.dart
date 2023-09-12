import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class FavouriteHeaderWidget extends StatelessWidget {
  const FavouriteHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getTranslated("fav_header", context),
          textAlign: TextAlign.center,
          style: AppTextStyles.semiBold
              .copyWith(fontSize: 20, color: Styles.TITLE),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            getTranslated("fav_description", context),
            textAlign: TextAlign.center,
            style: AppTextStyles.medium
                .copyWith(fontSize: 16, color: Styles.SUBTITLE),
          ),
        ),
      ],
    );
  }
}
