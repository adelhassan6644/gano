import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/images.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/features/statistics/widgets/winner_widget.dart';
import 'package:provider/provider.dart';
import '../provider/statistics_provider.dart';

class StatisticsHeader extends StatelessWidget {
  const StatisticsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: Text(
            getTranslated("statistics_header", context),
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 18, color: Styles.TITLE),
          ),
        ),
        Consumer<StatisticsProvider>(builder: (_, provider, child) {
          return Container(
            height: context.height * 0.47,
            width: context.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: AssetImage(Images.statisticsBGImage),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WinnerWidget(
                    height: context.height * 0.17,
                    isLoading: provider.isLoading,
                    name: "test",
                    image: "",
                    views: "150",
                    index: 2,
                  ),
                  WinnerWidget(
                      height: context.height * 0.215,
                      isLoading: provider.isLoading,
                      name: "test",
                      image: "",
                      views: "150",
                      index: 1),
                  WinnerWidget(
                      height: context.height * 0.13,
                      isLoading: provider.isLoading,
                      name: "test",
                      image: "",
                      views: "150",
                      index: 3),
                ]),
          );
        })
      ],
    );
  }
}
