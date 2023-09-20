import 'package:gano/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import 'video_card.dart';

class HomeVideos extends StatelessWidget {
  const HomeVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Styles.SMOKED_WHITE_COLOR,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
              child: Text(
                getTranslated("watch_and_win", context),
                style: AppTextStyles.semiBold.copyWith(
                    color: Styles.PRIMARY_COLOR,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Consumer<HomeProvider>(builder: (_, provider, child) {
              return provider.isLoading
                  ? Column(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: const CustomShimmerContainer(
                            height: 220,
                            radius: 20,
                          ),
                        ),
                      ),
                    )
                  : provider.videos.isNotEmpty
                      ? Column(
                          children: List.generate(
                              provider.videos.length,
                              (index) => VideoCard(
                                    videoModel: provider.videos[index],
                                  )),
                        )
                      : const Column(
                          children: [
                            EmptyState(
                              txt: "لا يوجد فديوهات الان",
                              subText: "تابعنا حتي تربح معنا",
                            ),
                          ],
                        );
            }),
          ],
        ));
  }
}
