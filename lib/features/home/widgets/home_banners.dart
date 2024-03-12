import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/custom_network_image.dart';
import '../../on_boarding/widgets/step_widget.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          provider.isGetBanners
              ? const _BannerShimmer()
              : provider.banners != null && provider.banners!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_SMALL.h),
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              disableCenter: true,
                              height: 210.h,
                              onPageChanged: (index, reason) {
                                provider.setBannerIndex(index);
                              },
                            ),
                            itemCount: provider.banners?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return InkWell(
                                onTap: () async {

                                  if(provider.banners![index].url!=null) {
                                    await launchUrl(Uri.parse(provider.banners![index].url!),mode: LaunchMode.externalApplication);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Styles.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CustomNetworkImage.containerNewWorkImage(
                                      image: provider.banners?[index].image ?? "",
                                      width: context.width,
                                      height: 220.h,
                                      fit: BoxFit.cover,
                                      radius: 20),
                                ),
                              );
                            },
                            carouselController: provider.bannerController,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 8.0.h),
                              child: StepWidget(
                                currentIndex: provider.bannerIndex,
                                length: provider.banners?.length ?? 0,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    )
                  : const SizedBox(),
        ],
      );
    });
  }
}

class _BannerShimmer extends StatelessWidget {
  const _BannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      child: CustomShimmerContainer(
        width: context.width,
        height: 230.h,
        radius: 20,
      ),
    );
  }
}
