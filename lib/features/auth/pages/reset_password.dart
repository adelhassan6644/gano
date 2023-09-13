import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<AuthProvider>(builder: (_, provider, child) {
                  return ListAnimator(
                    customPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    data: [
                      customImageIcon(
                          imageName: Images.authImage,
                          height: 250.h,
                          width: context.width,
                          fit: BoxFit.cover),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        getTranslated("reset_password_header", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 22, color: Styles.TITLE),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        getTranslated("reset_password_description", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium
                            .copyWith(fontSize: 16, color: Styles.SUBTITLE),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                keyboardAction: TextInputAction.next,
                                controller: provider.passwordTEC,
                                hint: getTranslated("password", context),
                                inputType: TextInputType.visiblePassword,
                                valid: Validations.firstPassword,
                                pSvgIcon: SvgImages.lockIcon,
                                isPassword: true,
                              ),
                              CustomTextFormField(
                                keyboardAction: TextInputAction.done,
                                controller: provider.confirmPasswordTEC,
                                hint:
                                    getTranslated("confirm_password", context),
                                inputType: TextInputType.visiblePassword,
                                valid: (v) => Validations.confirmPassword(
                                    provider.passwordTEC.text.trim(),
                                    v?.trim()),
                                pSvgIcon: SvgImages.lockIcon,
                                isPassword: true,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 24.h,
                                ),
                                child: CustomButton(
                                    text: getTranslated("confirm", context),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        provider.resetPassword();
                                      }
                                    },
                                    isLoading: provider.isReset),
                              ),
                            ],
                          )),
                    ],
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
