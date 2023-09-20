import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import 'dart:ui' as ui;
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../../main_models/video_model.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required this.videoModel,
  }) : super(key: key);
  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          CustomNavigator.push(Routes.VIDEO_DETAILS, arguments: videoModel),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        height: 220.h,
        width: context.width,
        decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Styles.PRIMARY_COLOR.withOpacity(0.15),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 2))
          ],
        ),
        child: Stack(
          children: [
            CustomNetworkImage.containerNewWorkImage(
              image: videoModel.image ?? "",
              height: 220.h,
              width: context.width,
              fit: BoxFit.contain,
              radius: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      color: Styles.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(videoModel.category ?? "category",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 12, color: Styles.WHITE_COLOR)),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(6),
                        child: BackdropFilter(
                          filter:
                              ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                Text("\$ ${videoModel.coins ?? ""}  ",
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFFD69B00))),
                                customImageIcon(
                                    imageName: Images.coin,
                                    height: 20,
                                    width: 20),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          bottomRight: Radius.circular(15))),
                  child: Text("${videoModel.duration ?? ""} m",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 12, color: Styles.WHITE_COLOR)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
