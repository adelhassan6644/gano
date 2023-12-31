import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/components/animated_widget.dart';
import 'package:gano/features/profile/widgets/profile_image_widget.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../provider/profile_provider.dart';
import '../widgets/edit_profile_body.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("edit_profile", context),
      ),
      body: SafeArea(
        child: Consumer<ProfileProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              Expanded(
                  child: ListAnimator(
                data: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                    child: const ProfileImageWidget(withEdit: true),
                  ),
                  const EditProfileBody(),
                ],
              ))
            ],
          );
        }),
      ),
    );
  }
}
