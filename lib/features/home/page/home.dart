import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import '../../../data/config/di.dart';
import '../widgets/home_header.dart';
import '../widgets/home_banners.dart';
import '../widgets/home_products.dart';

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
      // sl<HomeProvider>().scroll(controller);
      sl<HomeProvider>().getBanners();
      // sl<HomeProvider>().getAds();
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
              onRefresh: () async {
                sl<HomeProvider>().getBanners();
                // sl<HomeProvider>().getAds();
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: const [
                        HomeBanner(),
                        // HomeProducts(),
                      ],
                    ),
                  ),
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
