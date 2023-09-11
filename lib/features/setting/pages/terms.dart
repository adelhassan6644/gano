import 'package:gano/components/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../provider/config_provider.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
            // title: getTranslated("terms_conditions", context),
            ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ConfigProvider>(builder: (_, provider, child) {
              return !provider.isLoading
                  ? Expanded(
                      child: ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        ),
                        data: [
                          Center(
                            child: customImageIcon(
                                imageName: Images.termsFile,
                                height: 150,
                                width: 150),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Text(
                              getTranslated("terms_conditions", context),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.semiBold
                                  .copyWith(fontSize: 22, color: Styles.TITLE),
                            ),
                          ),
                          provider.setting != null
                              ? HtmlWidget(provider.setting?.terms ?? "")
                              : EmptyState(
                                  txt: getTranslated(
                                      "something_went_wrong", context),
                                )
                        ],
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Styles.PRIMARY_COLOR,
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
