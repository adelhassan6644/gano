import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/styles.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/navigation/custom_navigation.dart';
import 'package:gano/navigation/routes.dart';
import '../../../app/core/utils/images.dart';
import '../../../components/custom_button.dart';
import '../widgets/on_boarding_content_widget.dart';
import '../widgets/on_boarding_image_widget.dart';
import '../widgets/step_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int index = 0;

  PageController controller = PageController(initialPage: 0);
  PageController controller2 = PageController(initialPage: 0);

  nextPage() {
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    controller2.animateToPage(controller2.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    index = controller.page!.toInt();
    setState(() {});
  }

  skip() {
    CustomNavigator.push(Routes.LOGIN, clean: true);
  }

  List<String> images = [
    Images.onBoarding1,
    Images.onBoarding2,
    Images.onBoarding3
  ];

  List<String> descriptions = [
    "on_boarding_description_1",
    "on_boarding_description_2",
    "on_boarding_description_3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            children: [
              SizedBox(
                height: context.height * 0.55,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: ((i) => setState(() {
                        index = i;
                      })),
                  children: List.generate(images.length,
                      (index) => OnBoardingImageWidget(image: images[index])

                      ///Image
                      ),
                ),
              ),
              StepWidget(currentIndex: index),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller2,
                  onPageChanged: ((i) => setState(() {
                        index = i;
                      })),
                  children: List.generate(
                      images.length,
                      (index) => OnBoardingContentWidget(
                            description: descriptions[index],
                          )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    ///Skip
                    Visibility(
                      visible: index != 2,
                      child: Expanded(
                        child: CustomButton(
                          text: getTranslated("skip", context),
                          textColor: Styles.SUBTITLE,
                          backgroundColor: Styles.FILL_COLOR,
                          onTap: skip,
                        ),
                      ),
                    ),

                    Visibility(
                      visible: index != 2,
                      child: SizedBox(
                        width: 16.w,
                      ),
                    ),

                    ///Next
                    Expanded(
                      child: CustomButton(
                        text: getTranslated(buttonText(index), context),
                        textColor: Styles.WHITE_COLOR,
                        backgroundColor: Styles.ACCENT_COLOR,
                        onTap: () => buttonFunction(index),
                        lIconWidget: index != 2
                            ? const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 16,
                                color: Styles.WHITE_COLOR,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///Button Text
  String buttonText(index) {
    switch (index) {
      case 0:
        return "next";
      case 1:
        return "next";
      case 2:
        return "login";
      default:
        return "next";
    }
  }

  ///Button function
  dynamic buttonFunction(index) {
    switch (index) {
      case 0:
        return nextPage();
      case 1:
        return nextPage();
      case 2:
        return skip();
      default:
        return nextPage();
    }
  }
}
