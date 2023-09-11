import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  final void Function(String?)? onSave;
  final void Function(String) onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validation;

  const CustomPinCodeField(
      {super.key,
      this.onSave,
      this.validation,
      required this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Styles.PRIMARY_COLOR,
      backgroundColor: Colors.transparent,
      autoDisposeControllers: false,
      autoDismissKeyboard: true,
      enableActiveFill: true,
      controller: controller,
      enablePinAutofill: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      textStyle: AppTextStyles.semiBold.copyWith(color: Styles.PRIMARY_COLOR),
      pastedTextStyle: AppTextStyles.semiBold.copyWith(color: Styles.HEADER),
      textInputAction: TextInputAction.done,
      pinTheme: PinTheme(
        borderWidth: 0.5,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60.h,
        fieldWidth: 60.w,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5.w),
        activeFillColor: Styles.FILL_COLOR,
        activeColor: Styles.LIGHT_BORDER_COLOR,
        inactiveColor: Styles.FILL_COLOR,
        inactiveFillColor: Styles.FILL_COLOR,
        selectedFillColor: Styles.FILL_COLOR,
        selectedColor: Styles.PRIMARY_COLOR,
        disabledColor: Styles.LIGHT_BORDER_COLOR,
        errorBorderColor: Styles.FAILED_COLOR,
      ),
      appContext: context,
      length: 4,
      onSaved: onSave,
      onChanged: onChanged,
      errorTextSpace: 30,
    );
  }
}
