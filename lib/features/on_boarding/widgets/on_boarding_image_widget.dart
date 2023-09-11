import 'package:flutter/cupertino.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/components/animated_widget.dart';
import '../../../components/custom_images.dart';

class OnBoardingImageWidget extends StatelessWidget {
  const OnBoardingImageWidget({
    required this.image,
    Key? key,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      data: [
        Container(
          height: context.height * .55,
          width: context.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: customImageIcon(
              imageName: image,
              fit: BoxFit.cover,
              height: context.height * .55,
              width: context.width),
        )
      ],
    );
  }
}
