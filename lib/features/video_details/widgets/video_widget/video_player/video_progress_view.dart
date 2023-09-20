import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'dart:ui' as ui;

import '../../../../../app/core/utils/styles.dart';
import '../../../../../app/core/utils/text_styles.dart';

class VideoProgress extends StatelessWidget {
  const VideoProgress(
      {super.key,
      required this.onChanged,
      required this.currentValue,
      required this.duration});
  final Function(num value) onChanged;
  final num currentValue, duration;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currentValue.toTimerFormatter,
                textDirection: TextDirection.ltr,
                style: AppTextStyles.medium
                    .copyWith(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Slider.adaptive(
                  value: currentValue.toDouble(),
                  activeColor: Styles.ACCENT_COLOR,
                  inactiveColor: Styles.WHITE_COLOR,
                  secondaryActiveColor: Styles.WHITE_COLOR,
                  onChanged: onChanged,

                  max: duration.toDouble(),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                duration.toTimerFormatter,
                textDirection: TextDirection.ltr,
                style: AppTextStyles.medium
                    .copyWith(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                  onTap: () {
                    if (MediaQuery.of(context).orientation ==
                        Orientation.portrait) {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    } else {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.portraitUp,
                      ]);
                    }
                  },
                  child: Icon(
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Icons.fullscreen
                          : Icons.fullscreen_exit,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
