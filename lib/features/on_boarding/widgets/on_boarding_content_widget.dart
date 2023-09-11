import 'package:flutter/cupertino.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/components/animated_widget.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class OnBoardingContentWidget extends StatelessWidget {
  const OnBoardingContentWidget({
    required this.description,
    Key? key,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      data: [
        ///header
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            getTranslated("on_boarding_header", context),
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 20, color: Styles.HEADER),
          ),
        ),

        ///description
        Text(
          getTranslated(description, context),
          textAlign: TextAlign.center,
          style: AppTextStyles.regular
              .copyWith(fontSize: 18, color: Styles.SUBTITLE),
        ),
      ],
    );
  }
}
