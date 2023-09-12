import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/components/custom_images.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class Login extends StatefulWidget {
  final bool fromMain;
  const Login({Key? key, required this.fromMain}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            children: [
              Consumer<AuthProvider>(builder: (_, provider, child) {
                return Expanded(
                  child: ListAnimator(
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
                        getTranslated("login", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 22, color: Styles.TITLE),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        getTranslated("login_header", context),
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
                                controller: provider.mailTEC,
                                hint: getTranslated("mail", context),
                                inputType: TextInputType.emailAddress,
                                valid: Validations.mail,
                                pSvgIcon: SvgImages.mailIcon,
                              ),
                              CustomTextFormField(
                                keyboardAction: TextInputAction.done,
                                controller: provider.passwordTEC,
                                hint: getTranslated("password", context),
                                inputType: TextInputType.visiblePassword,
                                valid: Validations.password,
                                pSvgIcon: SvgImages.lockIcon,
                                isPassword: true,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      CustomNavigator.push(
                                          Routes.FORGET_PASSWORD);
                                      provider.clear();
                                    },
                                    child: Text(
                                      getTranslated("forget_password", context),
                                      style: AppTextStyles.medium.copyWith(
                                        color: Styles.PRIMARY_COLOR,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Styles.WHITE_COLOR,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 24.h,
                                ),
                                child: CustomButton(
                                    text: getTranslated("login", context),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        provider.logIn();
                                      }
                                      // CustomNavigator.push(Routes.DASHBOARD,arguments: 0,clean: true);
                                    },
                                    isLoading: provider.isLoading),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated("do_not_have_acc", context),
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.regular.copyWith(
                                        color: Styles.SUBTITLE,
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      CustomNavigator.push(Routes.REGISTER,
                                          clean: true);
                                      provider.clear();
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          " ${getTranslated("signup", context)} ",
                                          textAlign: TextAlign.start,
                                          style:
                                              AppTextStyles.semiBold.copyWith(
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
                            ],
                          )),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
