import 'package:flutter/material.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../data/config/di.dart';
import '../provider/statistics_provider.dart';
import '../widgets/statistics_body.dart';
import '../widgets/statistics_header.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics>
    with AutomaticKeepAliveClientMixin<Statistics> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<StatisticsProvider>().scroll(controller);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: const Stack(
          children: [StatisticsHeader(), StatisticsBody()],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
