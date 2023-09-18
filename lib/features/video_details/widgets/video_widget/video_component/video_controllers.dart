import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';

class VideoControllers extends StatelessWidget {
  final videoPlayerController;
  final onSoundTap;
  final fullScreenControl;

  const VideoControllers(
      {Key? key,
      required this.videoPlayerController,
      required this.onSoundTap,
      required this.fullScreenControl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 20.h,
      end: 10.w,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
            height: 45,
            width: 45,
            child: Center(
              child: InkWell(
                onTap: () {},
                child: Icon(
                  videoPlayerController.value.volume == 1.0
                      ? Icons.volume_up
                      : Icons.volume_off,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: fullScreenControl,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              height: 45,
              width: 45,
              child: const Icon(Icons.fullscreen, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
