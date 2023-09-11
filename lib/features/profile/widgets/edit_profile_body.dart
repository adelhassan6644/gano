import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        child: provider.isLoading
            ? const _ProfileBodyShimmer()
            : Column(
                children: [
                  ///Name
                  CustomTextFormField(
                    controller: provider.nameTEC,
                    hint: getTranslated("name", context),
                    inputType: TextInputType.name,
                    valid: Validations.name,
                    pSvgIcon: SvgImages.userIcon,
                  ),

                  ///Phone
                  CustomTextFormField(
                    controller: provider.phoneTEC,
                    hint: getTranslated("phone_number", context),
                    inputType: TextInputType.phone,
                    valid: Validations.phone,
                    pSvgIcon: SvgImages.phoneIcon,
                  ),

                  ///Mail
                  CustomTextFormField(
                    controller: provider.emailTEC,
                    hint: getTranslated("mail", context),
                    inputType: TextInputType.emailAddress,
                    valid: Validations.mail,
                    pSvgIcon: SvgImages.mailIcon,
                    read: true,
                    addBorder: true,
                  ),

                  ///To save Changes
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: CustomButton(
                      text: getTranslated("save_changes", context),
                      onTap: () => provider.updateProfile(),
                      isLoading: provider.isUpdate,
                    ),
                  )
                ],
              ),
      );
    });
  }
}

class _ProfileBodyShimmer extends StatelessWidget {
  const _ProfileBodyShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: const CustomShimmerContainer(
            height: 60,
            radius: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: const CustomShimmerContainer(
            height: 60,
            radius: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: const CustomShimmerContainer(
            height: 60,
            radius: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: const CustomShimmerContainer(
            height: 60,
            radius: 30,
          ),
        ),
      ],
    );
  }
}
