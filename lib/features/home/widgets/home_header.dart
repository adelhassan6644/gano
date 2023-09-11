import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/components/custom_images.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/home/provider/home_provider.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:gano/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../components/tab_widget.dart';
import '../../../navigation/routes.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          getTranslated("welcome_description", context),
                          style: AppTextStyles.medium.copyWith(
                              height: 2,
                              fontSize: 18,
                              color: Styles.PRIMARY_COLOR),
                        ),
                        Consumer<ProfileProvider>(
                            builder: (_, provider, child) {
                          return provider.isLoading
                              ? const CustomShimmerContainer(
                                  width: 100,
                                  height: 16,
                                )
                              : Text(
                                  provider.nameTEC.text.trim() ?? "",
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 18,
                                      height: 2,
                                      color: Styles.PRIMARY_COLOR),
                                );
                        }),
                      ],
                    ),
                  ),
                  customContainerSvgIcon(
                    imageName: SvgImages.notifications,
                    radius: 100,
                    height: 45,
                    width: 45,
                    onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS),
                  )
                ],
              ),
            ],
          ),
        ),
        Consumer<HomeProvider>(builder: (_, provider, child) {
          return AnimatedCrossFade(
            crossFadeState: CrossFadeState.showFirst,
            firstChild: Container(
              width: context.width,
              height: 35,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: Styles.BORDER_COLOR))),
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: provider.isGetCategories
                      ? [
                          ...List.generate(
                            5,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_SMALL.w),
                                child: const CustomShimmerContainer(
                                  width: 80,
                                  height: 35,
                                ),
                              );
                            },
                          )
                        ]
                      : [
                          ...List.generate(
                            provider.categories?.length ?? 0,
                            (index) {
                              return TabWidget(
                                title: provider.categories?[index].title ?? "",
                                width: 100,
                                isSelected: provider.currentTab ==
                                    provider.categories?[index].id,
                                withBorder: false,
                                onTab: () {
                                  if (provider.currentTab !=
                                      provider.categories?[index].id) {
                                    provider.selectTab(index);
                                  }
                                },
                              );
                            },
                          )
                        ],
                ),
              ),
            ),
            secondChild: const SizedBox(),
            duration: const Duration(milliseconds: 500),
          );
        }),
      ],
    );
  }
}
