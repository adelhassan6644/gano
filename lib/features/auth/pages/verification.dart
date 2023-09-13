import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/count_down.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_pin_code_field.dart';
import '../../../data/config/di.dart';
import '../provider/auth_provider.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key, required this.fromRegister}) : super(key: key);
  final bool fromRegister;
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () => sl<AuthProvider>().codeTEC.clear());
    super.initState();
  }

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
                      getTranslated("verify_the_mail", context),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 22, color: Styles.TITLE),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      getTranslated("verify_header", context),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.SUBTITLE),
                    ),
                    Text((provider.mailTEC.text.trim()).hiddenEmail(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 16,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Directionality(
                                textDirection: TextDirection.ltr,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_LARGE.w),
                                  child: CustomPinCodeField(
                                      validation: Validations.code,
                                      controller: provider.codeTEC,
                                      onChanged: (v) {}),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CountDown(
                                  onCount: () =>
                                      provider.resend(widget.fromRegister),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 24.h,
                              ),
                              child: CustomButton(
                                  text: getTranslated("confirm", context),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      provider.verify(widget.fromRegister);
                                    }
                                  },
                                  isLoading: provider.isVerify),
                            ),
                          ],
                        )),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
