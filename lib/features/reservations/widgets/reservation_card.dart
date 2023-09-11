import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/components/custom_images.dart';
import 'package:gano/features/ratting/view/ratting_view.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../model/reservation_model.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(
      {Key? key, this.isNext = true, required this.reservation})
      : super(key: key);
  final bool isNext;
  final ReservationModel reservation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL.h),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Styles.WHITE_COLOR,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNetworkImage.containerNewWorkImage(
              image: reservation.image ?? "",
              height: 95.h,
              width: 100.w,
              fit: BoxFit.cover,
              radius: 12.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(reservation.subService ?? "",
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 16,
                                      color: Styles.PRIMARY_COLOR)),
                            ),
                            CustomButton(
                              width: 100,
                              height: 30.h,
                              text: getTranslated(
                                  isNext ? "again" : "rate", context),
                              svgIcon: SvgImages.arrowLeft,
                              iconSize: 16,
                              iconColor: Styles.WHITE_COLOR,
                              onTap: () {
                                if (isNext) {
                                  CustomNavigator.push(Routes.PRODUCT_DETAILS,
                                      arguments: reservation.subService);
                                }
                                if (!isNext) {
                                  CustomSimpleDialog.parentSimpleDialog(
                                    customListWidget: [
                                      RattingView(reservation: reservation)
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Text("اليوم  ",
                                style: AppTextStyles.regular.copyWith(
                                    height: 1,
                                    fontSize: 12,
                                    color: Styles.DETAILS_COLOR)),
                            Expanded(
                              child: Text(
                                  reservation.date!
                                      .dateFormat(format: "EEEE dd/MM"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium.copyWith(
                                      height: 1,
                                      fontSize: 14,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Text("الساعة  ",
                                style: AppTextStyles.regular.copyWith(
                                    height: 1,
                                    fontSize: 12,
                                    color: Styles.DETAILS_COLOR)),
                            Expanded(
                              child: Text(
                                  reservation.date!
                                      .dateFormat(format: "hh:mm aa"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium.copyWith(
                                      height: 1,
                                      fontSize: 14,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  customImageIconSVG(
                                      imageName: SvgImages.location,
                                      height: 20,
                                      width: 20,
                                      color: Styles.DETAILS_COLOR),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      reservation.address ?? "",
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("${reservation.price ?? 0} ريال",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14, color: Styles.PRIMARY_COLOR)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
