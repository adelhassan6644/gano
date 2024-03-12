import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/components/custom_images.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:gano/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../navigation/routes.dart';
import '../../profile/widgets/profile_image_widget.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Consumer<ProfileProvider>(builder: (_, provider, child) {
          return provider.isLoading
              ? const _Shimmer()
              : Row(
                  children: [
                    const ProfileImageWidget(
                      withEdit: false,
                      withPadding: false,
                      radius: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getTranslated("welcome", context)} ${provider.nameTEC.text.trim()}",
                            maxLines: 1,
                            style: AppTextStyles.semiBold.copyWith(
                                color: Styles.TITLE,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            getTranslated(
                                "excited_for_what_you_will_see_today", context),
                            style: AppTextStyles.regular.copyWith(
                                color: Styles.SUBTITLE,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    customContainerSvgIcon(
                        imageName: SvgImages.notifications,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS))
                  ],
                );
        }),
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomShimmerCircleImage(diameter: 56),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomShimmerText(
                width: 150,
              ),
              const SizedBox(height: 8),
              CustomShimmerText(width: context.width)
            ],
          ),
        ),
        const SizedBox(width: 12),
        const CustomShimmerCircleImage(diameter: 40)
      ],
    );
  }
}
