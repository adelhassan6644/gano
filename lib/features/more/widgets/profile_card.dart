import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:gano/components/custom_images.dart';
import 'package:gano/features/more/widgets/profile_tabs_widget.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../profile/widgets/profile_image_widget.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool isExpanded = false;

  onTap() {
    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
        vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
      ),
      child: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  const ProfileImageWidget(
                    withEdit: false,
                    withPadding: false,
                    radius: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.isLogin
                              ? provider.nameTEC.text.trim()
                              : "Guest",
                          maxLines: 1,
                          style: AppTextStyles.semiBold.copyWith(
                              color: Styles.TITLE,
                              fontSize: 16,
                              height: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          provider.isLogin
                              ? provider.emailTEC.text.trim()
                              : "guest@Gano.com",
                          maxLines: 1,
                          style: AppTextStyles.regular.copyWith(
                              color: Styles.SUBTITLE,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 500),
                    turns: isExpanded ? 0 : .5,
                    child: customImageIconSVG(
                      imageName: SvgImages.openButton,
                    ),
                  )
                ],
              ),
            ),
            AnimatedCrossFade(
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
              firstChild: SizedBox(width: context.width),
              secondChild: const ProfileTabs(),
            )
          ],
        );
      }),
    );
  }
}
