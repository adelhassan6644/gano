import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/components/custom_app_bar.dart';
import 'package:gano/components/empty_widget.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:gano/features/notifications/provider/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../repo/notifications_repo.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("notifications", context)),
      body: Column(
        children: [
          Expanded(
              child: ChangeNotifierProvider(
            create: (_) => NotificationsProvider(repo: sl<NotificationsRepo>())
              ..getNotifications(),
            child:
                Consumer<NotificationsProvider>(builder: (_, provider, child) {
              return provider.isLoading
                  ? ListAnimator(
                      customPadding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_DEFAULT.w,
                          Dimensions.PADDING_SIZE_DEFAULT.h,
                          Dimensions.PADDING_SIZE_DEFAULT.w,
                          0),
                      data: List.generate(
                          10,
                          (index) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimensions.PADDING_SIZE_SMALL),
                                child: CustomShimmerContainer(
                                  width: context.width,
                                  height: 60,
                                  radius: 12,
                                ),
                              )))
                  : provider.model != null &&
                          provider.model?.data != null &&
                          provider.model!.data!.isNotEmpty
                      ? RefreshIndicator(
                          color: Styles.PRIMARY_COLOR,
                          onRefresh: () async {
                            provider.getNotifications();
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: ListAnimator(
                                    customPadding: EdgeInsets.fromLTRB(
                                        Dimensions.PADDING_SIZE_DEFAULT.w,
                                        Dimensions.PADDING_SIZE_DEFAULT.h,
                                        Dimensions.PADDING_SIZE_DEFAULT.w,
                                        0),
                                    data: List.generate(
                                        provider.model?.data?.length ?? 0,
                                        (index) => Dismissible(
                                              background: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomButton(
                                                    width: 100.w,
                                                    height: 30.h,
                                                    text: getTranslated(
                                                        "delete", context),
                                                    svgIcon: SvgImages.cancel,
                                                    iconSize: 12,
                                                    iconColor: Styles.IN_ACTIVE,
                                                    textColor: Styles.IN_ACTIVE,
                                                    backgroundColor: Styles
                                                        .IN_ACTIVE
                                                        .withOpacity(0.12),
                                                  ),
                                                ],
                                              ),
                                              key: ValueKey(index),
                                              confirmDismiss: (DismissDirection
                                                  direction) async {
                                                provider.deleteNotification(
                                                    provider.model?.data?[index]
                                                            .id ??
                                                        0);
                                                return false;
                                              },
                                              child: NotificationCard(
                                                notification: provider
                                                    .model?.data?[index],
                                              ),
                                            ))),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          color: Styles.PRIMARY_COLOR,
                          onRefresh: () async {
                            provider.getNotifications();
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: ListAnimator(
                                    customPadding: EdgeInsets.fromLTRB(
                                        Dimensions.PADDING_SIZE_DEFAULT.w,
                                        Dimensions.PADDING_SIZE_DEFAULT.h,
                                        Dimensions.PADDING_SIZE_DEFAULT.w,
                                        0),
                                    data: const [
                                      EmptyState(
                                        txt: "لا يوجد اشعارات حاليا",
                                        spaceBtw: 50,
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        );
            }),
          ))
        ],
      ),
    );
  }
}
