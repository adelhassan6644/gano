import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/features/home/models/ads_model.dart';
import 'package:readmore/readmore.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../widgets/related_ads.dart';
import '../widgets/video_widget/video_player/video_player_handler.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails({Key? key, required this.adModel}) : super(key: key);
  final AdsModel adModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ///Video
          VideoPlayerView(
              path: adModel.videoLink ??
                  "https://engineering-tracks.com/webroot/eLearning/Courses/CMRP31/CMRP3101-Part2.mp4",
              type: VideoType.network,
              height: context.height * 0.4,
              width: context.width),

          ///Video Description
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
            child: ReadMoreText(
              adModel.description ?? "",
              trimLines: 3,
              colorClickableText: Styles.PRIMARY_COLOR,
              trimMode: TrimMode.Line,
              trimCollapsedText: " ${getTranslated("read_more", context)}",
              trimExpandedText: " ${getTranslated("read_less", context)}",
              style: AppTextStyles.medium
                  .copyWith(fontSize: 16, color: Styles.SUBTITLE),
              moreStyle: AppTextStyles.medium
                  .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
              lessStyle: AppTextStyles.medium
                  .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
            ),
          ),

          ///Video Related Videos
          RelatedAds(
            id: adModel.id ?? 0,
          ),
        ],
      ),
    );
  }
}
