import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:gano/features/invitation/provider/invitation_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../repo/invitation_repo.dart';

class Invitation extends StatelessWidget {
  const Invitation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (_) => InvitationProvider(repo: sl<InvitationRepo>()),
      child: Consumer<InvitationProvider>(builder: (_, provider, child) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIcon(
                  imageName: Images.invitation,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover),
              Text(
                getTranslated("invitation_header", context),
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 18, color: Styles.TITLE),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Text(
                  getTranslated("invitation_description", context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular
                      .copyWith(fontSize: 18, color: Styles.SUBTITLE),
                ),
              ),
              // CustomTextFormField(
              //   controller: provider.mailTEC,
              //   hint: getTranslated("mail", context),
              //   inputType: TextInputType.emailAddress,
              //   valid: Validations.mail,
              //   pSvgIcon: SvgImages.mailIcon,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 12.h,
              //   ),
              //   child: CustomButton(
              //       text: getTranslated("send_invitation", context),
              //       onTap: () {
              //         if (formKey.currentState!.validate()) {
              //           provider.sendInvitation();
              //         }
              //       },
              //       isLoading: provider.isLoading),
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       getTranslated("or_send_it_via", context),
              //       style: AppTextStyles.medium
              //           .copyWith(fontSize: 14, color: Styles.SUBTITLE),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 12.h,
              ),
              Wrap(
                runSpacing: 8,
                spacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.faceBook,
                      height: 45,
                      width: 45,
                      onTap: () => provider.launch(LaunchType.facebook,context)),
                  customImageIconSVG(
                      imageName: SvgImages.twitter,
                      height: 45,
                      width: 45,
                      onTap: () => provider.launch(LaunchType.twitter,context)),
                  customImageIconSVG(
                      imageName: SvgImages.whatsApp,
                      height: 45,
                      width: 45,
                      onTap: () => provider.launch(LaunchType.whatsapp,context)),
                  customImageIconSVG(
                      imageName: SvgImages.instagram,
                      height: 45,
                      width: 45,
                      onTap: () => provider.launch(LaunchType.instagram,context)),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
