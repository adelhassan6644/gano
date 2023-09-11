import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../../../helpers/image_picker_helper.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {required this.withEdit,
      this.withPadding = true,
      this.withName = false,
      this.radius = 55,
      Key? key})
      : super(key: key);
  final bool withEdit;
  final double radius;
  final bool withPadding;
  final bool withName;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return provider.isLoading
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerCircleImage(
                  diameter: radius * 2,
                ),
                Visibility(
                  visible: withName,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: CustomShimmerContainer(
                      width: 150,
                      height: 20,
                    ),
                  ),
                )
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          withPadding ? Dimensions.PADDING_SIZE_DEFAULT.w : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (provider.profileImage != null ||
                              provider.profileModel?.image != null) {
                            showDialog(
                                context: context,
                                barrierColor: Colors.black.withOpacity(0.75),
                                builder: (context) {
                                  return ImagePopUpViewer(
                                    image: provider.profileImage ??
                                        provider.profileModel?.image ??
                                        "",
                                    isFromInternet:
                                        provider.profileImage != null
                                            ? false
                                            : true,
                                    title: "",
                                  );
                                });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            provider.profileImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      provider.profileImage!,
                                      height: radius * 2,
                                      width: radius * 2,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Center(
                                              child: Container(
                                                  height: radius * 2,
                                                  width: radius * 2,
                                                  color: Colors.grey,
                                                  child: const Center(
                                                      child: Icon(Icons.replay,
                                                          color:
                                                              Colors.green)))),
                                    ),
                                  )
                                : CustomNetworkImage.circleNewWorkImage(
                                    color: Styles.WHITE_COLOR,
                                    image: provider.profileModel?.image ?? "",
                                    radius: radius),
                            if (withEdit)
                              customContainerSvgIcon(
                                  radius: 100,
                                  height: 30,
                                  width: 30,
                                  imageColor: Styles.WHITE_COLOR,
                                  imageName: SvgImages.cameraIcon,
                                  color: Styles.PRIMARY_COLOR,
                                  onTap: () {
                                    if (withEdit) {
                                      ImagePickerHelper.showOptionSheet(
                                          onGet: provider.onSelectImage);
                                    }
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: withName,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Text(
                        provider.nameTEC.text.trim(),
                        maxLines: 1,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 16,
                          color: Styles.WHITE_COLOR,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
    });
  }
}
