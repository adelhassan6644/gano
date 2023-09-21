import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/config/di.dart';
import '../../../main_page/provider/ad_mob_provider.dart';
import '../widgets/home_videos.dart';
import '../widgets/home_header.dart';
import '../widgets/home_banners.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<HomeProvider>().scroll(controller);
    });
    Future.delayed(const Duration(seconds: 3), () {
      if(mounted)
      Provider.of<AdMobProvider>(context, listen: false).showRewardedAd();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: RefreshIndicator(
              color: Styles.PRIMARY_COLOR,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                sl<HomeProvider>().getBanners();
                sl<HomeProvider>().getHomeVideos();

                Provider.of<AdMobProvider>(context, listen: false)
                    .showRewardedAd();
              },
              child: ListView(
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: const [
                  HomeBanner(),
                  HomeVideos(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
