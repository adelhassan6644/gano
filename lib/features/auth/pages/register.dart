import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/app_snack_bar.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            Consumer<AuthProvider>(builder: (_, provider, child) {
              return Expanded(
                child: ListAnimator(data: [
                  customImageIcon(
                      imageName: Images.authImage,
                      height: 250.h,
                      width: context.width,
                      fit: BoxFit.cover),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    getTranslated("signup", context),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 22, color: Styles.TITLE),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    getTranslated("signup_header", context),
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
                            controller: provider.nameTEC,
                            hint: getTranslated("name", context),
                            inputType: TextInputType.name,
                            valid: Validations.name,
                            pSvgIcon: SvgImages.userIcon,
                          ),

                          CustomTextFormField(
                            controller: provider.mailTEC,
                            hint: getTranslated("mail", context),
                            inputType: TextInputType.emailAddress,
                            valid: Validations.mail,
                            pSvgIcon: SvgImages.mailIcon,
                          ),
                          CustomTextFormField(
                            controller: provider.phoneTEC,
                            hint: getTranslated("phone_number", context),
                            inputType: TextInputType.phone,
                            valid: Validations.phone,
                            pSvgIcon: SvgImages.phoneIcon,
                          ),
                          CustomTextFormField(
                            controller: provider.passwordTEC,
                            hint: getTranslated("password", context),
                            inputType: TextInputType.visiblePassword,
                            valid: Validations.firstPassword,
                            pSvgIcon: SvgImages.lockIcon,
                            isPassword: true,
                          ),

                          CustomTextFormField(
                            keyboardAction: TextInputAction.done,
                            controller: provider.invitationCodeTEC,
                            hint: getTranslated("invitation_code", context),
                            pSvgIcon: SvgImages.inviteFriend,
                            inputType: TextInputType.text,
                          ),

                          ///Accept Terms & Conditions
                          _AgreeToTerms(
                            check: provider.isAgree,
                            onChange: (v) => provider.onAgree(v),
                          ),

                          ///Sign up
                          CustomButton(
                              text: getTranslated("signup", context),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (provider.isAgree) {
                                    provider.register();
                                  } else {
                                    showToast(getTranslated(
                                        "oops_you_must_agree_to_terms_and_conditions",
                                        context));
                                  }
                                }
                              },
                              isLoading: provider.isRegister),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${getTranslated("have_acc", context)} ",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.regular.copyWith(
                                      color: Styles.SUBTITLE,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                InkWell(
                                  onTap: () {
                                    CustomNavigator.push(Routes.LOGIN,
                                        clean: true);
                                    provider.clear();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        " ${getTranslated("login", context)} ",
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.semiBold.copyWith(
                                          color: Styles.PRIMARY_COLOR,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                        ),
                                      ),
                                      customImageIconSVG(
                                          imageName: SvgImages.arrowLeft,
                                          width: 20,
                                          height: 20,
                                          color: Styles.PRIMARY_COLOR)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ]),
              );
            })
          ],
        ),
      ),
    ));
  }
}

class _AgreeToTerms extends StatelessWidget {
  const _AgreeToTerms({
    Key? key,
    this.check = false,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 24.h, 8.w, 8.h),
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () => onChange(!check),
            child: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: check ? Styles.PRIMARY_COLOR : Styles.WHITE_COLOR,
                  border: Border.all(
                      color:
                          check ? Styles.PRIMARY_COLOR : Styles.DETAILS_COLOR,
                      width: 1)),
              child: check
                  ? const Icon(
                      Icons.check,
                      color: Styles.WHITE_COLOR,
                      size: 16,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            getTranslated("agree_to", context),
            style: AppTextStyles.regular
                .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
          ),
          InkWell(
            onTap: () => CustomNavigator.push(Routes.TERMS),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Text(
              " ${getTranslated("terms_conditions", context)} ",
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
            ),
          ),
          Text(
            getTranslated("of_gano", context),
            style: AppTextStyles.regular
                .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
