import 'package:gano/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:gano/features/video_details/repo/related_ads_repo.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../home/widgets/ads_card.dart';
import '../provider/related_ads_provider.dart';

class RelatedAds extends StatelessWidget {
  const RelatedAds({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                  getTranslated("suggestions", context),
                  style: AppTextStyles.semiBold.copyWith(
                      color: Styles.PRIMARY_COLOR,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Expanded(
                child: ListAnimator(
                  data: List.generate(3, (index) => const AdsCard()),
                ),
              ),
              // ChangeNotifierProvider(
              //   create: (context) =>
              //       RelatedAdsProvider(repo: sl<RelatedAdsRepo>())..getAds(id),
              //   child: Consumer<HomeProvider>(builder: (_, provider, child) {
              //     return provider.isLoading
              //         ? ListAnimator(
              //             customPadding: EdgeInsets.symmetric(
              //                 horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              //             data: List.generate(
              //               3,
              //               (index) => const CustomShimmerContainer(),
              //             ),
              //           )
              //         : provider.ads.isNotEmpty
              //             ? ListAnimator(
              //                 data: List.generate(
              //                     provider.ads.length ?? 0,
              //                     (index) => AdsCard(
              //                           adsModel: provider.ads[index],
              //                         )),
              //               )
              //             : const ListAnimator(
              //                 data: [
              //                   EmptyState(
              //                     txt: "لا يوجد اعلانات الان",
              //                     subText: "تابعنا حتي تربح معنا",
              //                   ),
              //                 ],
              //               );
              //   }),
              // ),
            ],
          )),
    );
  }
}
