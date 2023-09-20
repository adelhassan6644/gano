import 'package:flutter/cupertino.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/statistics/model/statistics_model.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';

class WinnerWidget extends StatelessWidget {
  const WinnerWidget({
    super.key,
    required this.height,
    required this.isLoading,
    required this.index,
    this.statisticsModel,
  });
  final double height;
  final bool isLoading;
  final int index;
  final StatisticsModel? statisticsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.linear,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
              margin: const EdgeInsets.only(top: 8.0),
              height: isLoading ? 10 : height,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Styles.ACCENT_COLOR,
              ),
              alignment: Alignment.bottomCenter,
              child: Text("#$index",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium
                      .copyWith(fontSize: 18, color: Styles.WHITE_COLOR)),
            ),
            isLoading
                ? const CustomShimmerCircleImage(
                    diameter: 60,
                  )
                : CustomNetworkImage.circleNewWorkImage(
                    image: statisticsModel?.image ?? "",
                    color: Styles.WHITE_COLOR,
                    radius: 30),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: isLoading
              ? const CustomShimmerText(
                  width: 70,
                )
              : Text(statisticsModel?.name ?? "",
                  style: AppTextStyles.semiBold
                      .copyWith(fontSize: 14, color: Styles.SUBTITLE)),
        ),
        isLoading
            ? const CustomShimmerText(
                width: 70,
              )
            : Text(
                "${statisticsModel?.views ?? ""} ${getTranslated("view", context)}",
                style: AppTextStyles.medium
                    .copyWith(fontSize: 12, color: Styles.DETAILS_COLOR)),
        SizedBox(
          height: context.height * 0.14,
        )
      ],
    );
  }
}
