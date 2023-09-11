import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../provider/contact_with_us_provider.dart';
import '../widgets/content_widget.dart';
import '../widgets/user_contact_data_widget.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated("text_us", context),
        ),
        body: Column(
          children: [
            Expanded(child:
                Consumer<ContactWithUsProvider>(builder: (_, provider, child) {
              return ListAnimator(
                customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                data: [
                  Text(
                    getTranslated("contact_with_us_header", context),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 16, color: Styles.SUBTITLE),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ((context.width - 200) / 2)),
                    child: customImageIcon(
                        imageName: Images.contactMail,
                        height: 150,
                        fit: BoxFit.cover),
                  ),
                  const UserContentDataWidget(),
                  const ContentWidget(),
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
