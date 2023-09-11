import 'package:gano/app/core/utils/images.dart';
import 'package:gano/features/notifications/model/notifications_model.dart';
import 'package:gano/features/notifications/provider/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    this.notification,
  }) : super(key: key);
  final NotificationItem? notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (widget.notification?.isRead != true) {
          sl<NotificationsProvider>()
              .readNotification(widget.notification?.id ?? 0);
          setState(() => widget.notification?.isRead = true);
        }
      },
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL.h,
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        decoration: BoxDecoration(
            color: widget.notification?.isRead == true
                ? Styles.WHITE_COLOR
                : Styles.PRIMARY_COLOR.withOpacity(0.1),
            border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Styles.PRIMARY_COLOR,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: customImageIcon(
                  imageName: Images.logo,
                  height: 15,
                  width: 30,
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      widget.notification?.notificationBody?.title ??
                          "jrbfefefjbjkg",
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 16,
                          color: widget.notification?.isRead == true
                              ? Styles.DETAILS_COLOR
                              : Styles.TITLE)),
                  SizedBox(
                    width: 8.w,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          widget.notification?.createdAt
                                  ?.dateFormat(format: "EEE dd/mm") ??
                              "efe",
                          style: AppTextStyles.regular.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
