import 'package:flutter/material.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/statistics/widgets/statistics_card.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/empty_widget.dart';
import '../provider/statistics_provider.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticsProvider>(builder: (_, provider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.55,
              minChildSize: 0.55,
              maxChildSize: 0.715,
              expand: false,
              builder: (_, controller) => Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: const Color(0xFFFAFAFA),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 5.0,
                                spreadRadius: 2,
                                offset: const Offset(0, 6))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 16.h),
                            child: Center(
                              child: Container(
                                height: 5,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Styles.BORDER_COLOR,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Consumer<StatisticsProvider>(
                                builder: (_, provider, child) {
                              return provider.isLoading
                                  ? ListAnimator(
                                      controller: controller,
                                      customPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      data: List.generate(
                                          25,
                                          (index) => Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: Dimensions
                                                        .PADDING_SIZE_SMALL.h),
                                                child: CustomShimmerContainer(
                                                  height: 60.h,
                                                  radius: 12,
                                                ),
                                              )),
                                    )
                                  : provider.statistics.length > 3
                                      ? ListAnimator(
                                          data: List.generate(
                                              provider.statistics.length > 3
                                                  ? provider.statistics.length
                                                  : 0,
                                              (index) => StatisticsCard(
                                                    statistics:
                                                        provider.statistics[
                                                            (index + 3)],
                                                    isMe: provider.isMe(provider
                                                        .statistics[(index + 3)]
                                                        .id),
                                                    index: (index + 4),
                                                  )),
                                        )
                                      : ListAnimator(
                                          data: [
                                            EmptyState(
                                              txt: provider
                                                      .statistics.isNotEmpty
                                                  ? "لا يوجد مشتركين اكثر من ${provider.statistics.length} "
                                                  : "لا يوجد مشتركين",
                                              subText:
                                                  "ادعو صديقك حتي يربح معانا",
                                            ),
                                          ],
                                        );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
