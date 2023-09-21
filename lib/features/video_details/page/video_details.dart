import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/data/api/end_points.dart';
import 'package:gano/main_models/video_model.dart';
import 'package:readmore/readmore.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../widgets/related_videos.dart';
import '../widgets/video_widget/video_player/video_player_handler.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails({Key? key, required this.videoModel}) : super(key: key);
  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Video
            VideoPlayerView(
                id: videoModel.id ?? 1,
                path:EndPoints.imageUrl+ videoModel.videoPath! ??
                    "https://engineering-tracks.com/webroot/eLearning/Courses/CMRP31/CMRP3101-Part2.mp4",
                type: VideoType.network,
                height: context.height * 0.4,
                width: context.width),

            Padding(
              padding: EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_DEFAULT.w,
                  Dimensions.PADDING_SIZE_DEFAULT.h,
                  Dimensions.PADDING_SIZE_DEFAULT.w,
                  4.h),
              child: Text(
                videoModel.title ?? "",
                style: AppTextStyles.semiBold.copyWith(
                    color: Styles.TITLE,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
            ),

            ///Video Description
            Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.PADDING_SIZE_DEFAULT.w,
                0,
                Dimensions.PADDING_SIZE_DEFAULT.w,
                Dimensions.PADDING_SIZE_DEFAULT.h,
              ),
              child: ReadMoreText(
                videoModel.description ?? "",
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
            RelatedVideos(id: videoModel.id ?? 0),
          ],
        ),
      ),
    );
  }
}
