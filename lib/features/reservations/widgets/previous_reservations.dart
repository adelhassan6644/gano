import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_page/provider/main_page_provider.dart';
import '../provider/reservations_provider.dart';
import 'reservation_card.dart';

class PreviousAppointments extends StatefulWidget {
  const PreviousAppointments({Key? key}) : super(key: key);

  @override
  State<PreviousAppointments> createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<ReservationsProvider>().previousScroll(controller);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationsProvider>(builder: (_, provider, child) {
      return provider.isLoading
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: ListAnimator(
                controller: controller,
                data: List.generate(
                  10,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                        bottom: Dimensions.PADDING_SIZE_SMALL.h),
                    child: CustomShimmerContainer(
                      height: 100,
                      width: context.width,
                      radius: 15,
                    ),
                  ),
                ),
              ),
            )
          : provider.previousReservations != null &&
                  provider.previousReservations!.isNotEmpty
              ? RefreshIndicator(
                  color: Styles.PRIMARY_COLOR,
                  onRefresh: () async {
                    sl<ReservationsProvider>().getPreviousReservations();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: ListAnimator(
                            controller: controller,
                            data: List.generate(
                              provider.previousReservations?.length ?? 0,
                              (index) => AppointmentCard(
                                reservation:
                                    provider.previousReservations![index],
                                isNext: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: Styles.PRIMARY_COLOR,
                  onRefresh: () async {
                    sl<ReservationsProvider>().getPreviousReservations();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: ListAnimator(
                            data: [
                              EmptyState(
                                img: Images.emptyReservations,
                                imgHeight: 215.h,
                                imgWidth: 215.w,
                                isSvg: false,
                                txt: getTranslated(
                                    "empty_previous_reservations_title",
                                    context),
                                subText: getTranslated(
                                    "empty_previous_reservations_description",
                                    context),
                                btnText:
                                    getTranslated("continue_browsing", context),
                                onTap: () => sl<MainPageProvider>()
                                    .updateDashboardIndex(0),
                                originalButton: false,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
    });
  }
}
