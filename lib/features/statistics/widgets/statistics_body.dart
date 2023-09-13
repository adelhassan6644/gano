import 'package:flutter/material.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/features/statistics/widgets/statistics_card.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../model/statistics_model.dart';
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
                            child: ListAnimator(
                                controller: controller,
                                customPadding:
                                    EdgeInsets.symmetric(horizontal: 12.w),
                                data: List.generate(
                                    25,
                                    (index) => StatisticsCard(
                                          statistics: StatisticsModel(
                                              image: "",
                                              name: "Adel Tester",
                                              views: "520"),
                                          isMe: index == 1,
                                          index: (index + 4),
                                        ))),
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
