import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/features/contact_with_us/provider/contact_with_us_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactWithUsProvider>(builder: (_, provider, child) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
              child: Text(
                getTranslated("message_type", context),
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 16,
                  color: Styles.TITLE,
                ),
              ),
            ),
            Center(
              child: Wrap(
                runSpacing: 16,
                spacing: 8,
                children: List.generate(
                    provider.types.length,
                    (index) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () =>
                              provider.onSelectType(provider.types[index]),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                color: provider.type?.index == index
                                    ? Styles.PRIMARY_COLOR
                                    : Styles.WHITE_COLOR,
                                border: Border.all(
                                  color: provider.type?.index == index
                                      ? Styles.PRIMARY_COLOR
                                      : Styles.LIGHT_BORDER_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              getTranslated(
                                  provider.types[index].name, context),
                              style: AppTextStyles.regular.copyWith(
                                fontSize: 14,
                                color: provider.type?.index == index
                                    ? Styles.WHITE_COLOR
                                    : Styles.SUBTITLE,
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomTextFormField(
              controller: provider.messageTEC,
              hint: getTranslated("message_content", context),
              inputType: TextInputType.text,
              minLine: 5,
              maxLine: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24.h,
              ),
              child: CustomButton(
                  text: getTranslated("submit", context),
                  onTap: () {
                    if (provider.checkData()) {
                      provider.sendMessage();
                    }
                  },
                  isLoading: provider.isLoading),
            ),
          ],
        ),
      );
    });
  }
}
