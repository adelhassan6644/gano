import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../auth/provider/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  final Function()? onTap;
  const LogoutButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, provider, child) {
      return Padding(
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: InkWell(
          onTap: () => provider.logOut(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.logout,
                  height: 20,
                  width: 20,
                  color: provider.isLogin ? Styles.IN_ACTIVE : Styles.ACTIVE),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          getTranslated(
                              provider.isLogin ? "logout" : "login", context),
                          maxLines: 1,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: provider.isLogin
                                  ? Styles.IN_ACTIVE
                                  : Styles.ACTIVE)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
