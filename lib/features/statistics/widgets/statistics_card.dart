import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../model/statistics_model.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard(
      {Key? key,
      this.isMe = true,
      required this.statistics,
      required this.index})
      : super(key: key);
  final bool isMe;
  final StatisticsModel statistics;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL.h),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: isMe
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Styles.WHITE_COLOR,
                boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        spreadRadius: 2,
                        blurRadius: 5)
                  ])
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomNetworkImage.circleNewWorkImage(
              image: statistics.image ?? "",
              radius: 25,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(statistics.name ?? "",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 14, color: Styles.SUBTITLE)),
                  SizedBox(height: 4.h),
                  Text(
                      "${statistics.views ?? ""} ${getTranslated("view", context)}",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 12, color: Styles.DETAILS_COLOR)),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Text("#$index",
                style: AppTextStyles.semiBold.copyWith(
                    fontSize: 14,
                    color: isMe ? Styles.PRIMARY_COLOR : Styles.SUBTITLE)),
          ],
        ),
      ),
    );
  }
}
