import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/features/profile/widgets/profile_image_widget.dart';

import '../../../app/core/utils/images.dart';
import '../widgets/earnings_widget.dart';
import '../widgets/total_coins_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
                child: ListAnimator(
              data: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 160 + context.toPadding,
                      width: context.width,
                      margin: const EdgeInsets.only(bottom: 50),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24)),
                          image: DecorationImage(
                              image: AssetImage(Images.profileBGImage),
                              fit: BoxFit.cover)),
                      child: const SizedBox(),
                    ),
                    const ProfileImageWidget(
                      withEdit: false,
                      withName: true,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const TotalCoinsWidget(),
                SizedBox(height: 24.h),
                const EarningsWidget()
              ],
            )),
          ],
        ));
  }
}
