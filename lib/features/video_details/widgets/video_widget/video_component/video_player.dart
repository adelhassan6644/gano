import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:video_player/video_player.dart';
import 'video_progress_bar.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String? link;

  const CustomVideoPlayer({
    Key? key,
    this.link,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  double _opacity = 1.0;
  late AnimationController _controller;
  Animation? _animation;

  _fullScreenControl() {
    final videoWidth = context.width;
    final videoHeight = context.height;
    final isLandscapeVideo = videoWidth > videoHeight;
    if (!isLandscapeVideo) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
  }

  _getVideo() async {
    _videoPlayerController = VideoPlayerController.network(widget.link ??
            "https://engineering-tracks.com/webroot/eLearning/Courses/CMRP31/CMRP3101-Part2.mp4"
        )
      // ..addListener(
      //   () {
      //     setState(
      //         () => _animationDuration = _res.data.durationOfAnimation);
      //     if (_videoPlayerController != null) {
      //       if (_videoPlayerController!.value.position.inMinutes == 10) {
      //         if (_count == 0) {
      //           setState(() => _count++);
      //           CourseRepo.storeWatch(
      //               sessionID: int.parse(widget.args.sessionID));
      //         }
      //       }
      //     }
      //   },
      // )
      ..setLooping(true)
      ..initialize();
    _videoPlayerController.addListener(() {
      setState(() {});
    });
    // _videoPlayerController.seekTo(Duration(minutes: 2));
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.repeat(reverse: true);
  }

  @override
  void initState() {
    _getVideo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    log("dispose:");
    _controller.dispose();
    _videoPlayerController.dispose();
  }

  refresh() {
    if (_opacity == 1.0) {
      setState(() => _opacity = 0.0);
    } else {
      setState(() => _opacity = 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? 266
              : context.height,
          padding: const EdgeInsets.all(16),
          width: context.width,
          child: _videoPlayerController.value.isInitialized
              ? InkWell(
                  onTap: () {
                    refresh();
                  },
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        _videoPlayerController.value.isInitialized
            ? InkWell(
                onTap: () => refresh(),
                child: SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 266
                          : context.height,
                  width: context.width,
                  child: VideoProgressBar(
                      opacity: _opacity,
                      videoPlayerController: _videoPlayerController,
                      onAddSpeed: () {
                        _videoPlayerController.setPlaybackSpeed(
                            _videoPlayerController.value.playbackSpeed + 0.1);
                        refresh();
                      },
                      onPlay: () {
                        if (_videoPlayerController.value.isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          _videoPlayerController.play();
                        }

                        refresh();
                      },
                      fullScreenControl: () => _fullScreenControl(),
                      onMinSpeed: () {
                        _videoPlayerController.setPlaybackSpeed(
                            _videoPlayerController.value.playbackSpeed - 0.1);
                        refresh();
                      },
                      onGoBack: () {
                        _videoPlayerController.seekTo(Duration(
                            seconds: _videoPlayerController
                                    .value.position.inSeconds -
                                15));
                        refresh();
                      },
                      onGoForward: () {
                        _videoPlayerController.seekTo(Duration(
                            seconds: _videoPlayerController
                                    .value.position.inSeconds +
                                15));
                        refresh();
                      }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
