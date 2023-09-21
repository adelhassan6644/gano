import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:gano/features/profile/widgets/total_coins_widget.dart';
import 'package:provider/provider.dart';

import 'earnings_widget.dart';

class ProfileStatisticsBody extends StatelessWidget {
  const ProfileStatisticsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return provider.isLoading
            ? const _StatisticsBodyShimmer()
            : ListAnimator(
                data: [
                  SizedBox(height: 24.h),
                  TotalCoinsWidget(
                    points: provider.profileModel?.coins ?? "0",
                    weekPoints: provider.profileModel?.coinsThisWeek ?? "0",
                  ),
                  SizedBox(height: 24.h),
                  EarningsWidget(
                    coins: provider.profileModel?.coins ?? "0",
                    views: provider.profileModel?.viewsThisWeek ?? "0",
                  )
                ],
              );
      }),
    );
  }
}

class _StatisticsBodyShimmer extends StatelessWidget {
  const _StatisticsBodyShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      customPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      data: [
        SizedBox(height: 24.h),
        CustomShimmerContainer(
          height: 155.h,
          width: context.width,
          radius: 18,
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
              child: CustomShimmerContainer(
                height: 125.h,
                radius: 18,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CustomShimmerContainer(
                height: 125.h,
                radius: 18,
              ),
            ),
          ],
        )
      ],
    );
  }
}
