import 'package:flutter/cupertino.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';

class WinnerWidget extends StatelessWidget {
  const WinnerWidget(
      {super.key,
      required this.height,
      required this.isLoading,
      required this.index,
      this.image,
      this.name,
      this.views});
  final double height;
  final bool isLoading;
  final int index;
  final String? image, name, views;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? _ShimmerWidget(height: height)
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 5),
                    curve: Curves.elasticIn,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
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
                          image: image, color: Styles.WHITE_COLOR, radius: 30),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text("$name",
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 14, color: Styles.SUBTITLE)),
              ),
              Text("${views ?? ""} ${getTranslated("view", context)}",
                  style: AppTextStyles.medium
                      .copyWith(fontSize: 12, color: Styles.DETAILS_COLOR)),
              SizedBox(
                height: context.height * 0.14,
              )
            ],
          );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget({required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomShimmerContainer(
                height: height,
                width: 40,
              ),
            ),
            const CustomShimmerCircleImage(
              diameter: 60,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: const CustomShimmerText(
            width: 70,
          ),
        ),
        const CustomShimmerText(
          width: 70,
        ),
        SizedBox(
          height: context.height * 0.14,
        )
      ],
    );
  }
}
