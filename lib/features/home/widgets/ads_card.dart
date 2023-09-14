import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/main_models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../models/ads_model.dart';

class AdsCard extends StatelessWidget {
  const AdsCard({
    Key? key,
    this.adsModel,
  }) : super(key: key);
  final AdsModel? adsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR, borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () => CustomNavigator.push(Routes.PRODUCT_DETAILS,
            arguments: adsModel!.id),
        child: Stack(
          children: [
            CustomNetworkImage.containerNewWorkImage(
              image: adsModel?.image ?? "",
              height: 220.h,
              width: context.width,
              fit: BoxFit.contain,
              radius: 20.w,
            ),
            // Padding(
            //   padding:
            //       EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Text("${adsModel?.service}",
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: AppTextStyles.semiBold.copyWith(
            //               fontSize: 14, color: Styles.PRIMARY_COLOR)),
            //       Padding(
            //         padding: EdgeInsets.symmetric(vertical: 6.h),
            //         child: Text("${adsModel.name}",
            //             maxLines: 2,
            //             overflow: TextOverflow.ellipsis,
            //             style: AppTextStyles.regular.copyWith(
            //                 height: 1,
            //                 fontSize: 14,
            //                 color: Styles.DETAILS_COLOR)),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
