import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:video_player/video_player.dart';

import '../../../../../app/core/utils/svg_images.dart';
import '../../../../../components/custom_images.dart';

class VideoProgressBar extends StatelessWidget {
  final opacity;
  final videoPlayerController;
  final onAddSpeed;
  final onMinSpeed;
  final onGoBack;
  final onGoForward;
  final onPlay;
  final fullScreenControl;

  const VideoProgressBar(
      {Key? key,
      required this.onPlay,
      required this.opacity,
      required this.videoPlayerController,
      required this.onAddSpeed,
      required this.onMinSpeed,
      required this.onGoBack,
      required this.fullScreenControl,
      required this.onGoForward})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // InkWell(
                    //   onTap: onMinSpeed,
                    //   child: const Row(
                    //     children: [
                    //       Text('speed',
                    //           style: TextStyle(
                    //               color: Colors.white, fontSize: 12)),
                    //       Icon(Icons.remove, color: Colors.white, size: 15),
                    //     ],
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: onGoBack,
                    //   child: customImageIconSVG(imageName:SvgImages.backward10Seconds, color: Colors.white),
                    // ),
                    Center(
                      child: GestureDetector(
                        onTap: onPlay,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: customImageIconSVG(
                              imageName: videoPlayerController.value.isPlaying
                                  ? SvgImages.pause
                                  : SvgImages.play,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: onGoForward,
                    //   child: customImageIconSVG(imageName: SvgImages.forward10Seconds, color: Colors.white),
                    // ),
                    // GestureDetector(
                    //   onTap: onAddSpeed,
                    //   child: const Row(
                    //     children: [
                    //       Text('speed',
                    //           style: TextStyle(
                    //               color: Colors.white, fontSize: 12)),
                    //       Icon(Icons.add, color: Colors.white, size: 15),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Center(
                  child: VideoProgressIndicator(
                    videoPlayerController,
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w, vertical: 8.h),
                    colors: VideoProgressColors(
                        bufferedColor:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        backgroundColor: Colors.white,
                        playedColor: Theme.of(context).primaryColor),
                    allowScrubbing: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w,right: 16.0.w,top:8),
                child: Row(
                  
                  children: [
                    Text(
                        '${videoPlayerController.value.position}'
                            .substring(0, 7),
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.white)),
                    Expanded(child: SizedBox()),
                    Text(
                      "-" +
                          "${videoPlayerController.value.duration - videoPlayerController.value.position}"
                              .substring(0, 7),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: fullScreenControl,
                      child: SizedBox(
                        
                        height: 24,
                        width: 24,
                        child: Icon(Icons.fullscreen, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              // Center(
              //   child: Text(
              //     "${videoPlayerController.value.playbackSpeed.toStringAsFixed(1)}X",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
