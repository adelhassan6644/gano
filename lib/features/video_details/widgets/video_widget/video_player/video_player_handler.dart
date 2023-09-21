import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import 'package:gano/app/core/utils/svg_images.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../../app/core/utils/styles.dart';
import '../../../../../components/custom_app_bar.dart';
import '../../../../../components/custom_images.dart';
import '../../../../../data/config/di.dart';
import '../../../../../main_page/provider/ad_mob_provider.dart';
import '../../../provider/view_video_provider.dart';
import 'video_progress_view.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    required this.id,
    required this.type,
    this.path,
    this.width,
    this.height,
  });
  final VideoType type;
  final String? path;
  final double? width, height;
  final int id;
  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  _initVideo() {
    Future.delayed(const Duration(seconds: 3), () {
      Provider.of<AdMobProvider>(context, listen: false).showRewardedAd();
    });
    switch (widget.type) {
      case VideoType.network:
        _controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.path ?? ""))
              ..setLooping(true)
              ..initialize().then((value) => setState(() {}));
        _controller.play();
        break;
      case VideoType.asset:
        _controller = VideoPlayerController.asset(widget.path!)
          ..initialize().then((value) => setState(() {}));
        break;
      case VideoType.file:
        _controller = VideoPlayerController.file(File(widget.path!))
          ..initialize().then((value) => setState(() {}));
        break;
      default:
    }
    _controller.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  bool showButtons = true;
  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              // Video view
              SizedBox(
                width: widget.width ?? context.width,
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? widget.height
                        : context.height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    width: widget.width ?? context.width,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? widget.height
                        : context.height,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: GestureDetector(
                        onTap: () {
                          SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersive);
                          setState(() => showButtons = !showButtons);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          color: !showButtons
                              ? Colors.transparent
                              : Colors.black.withOpacity(.4),
                          child: Visibility(
                            visible: showButtons,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async => _controller.value.isPlaying
                                      ? await _controller
                                          .seekTo(Duration(
                                              seconds: _controller.value
                                                      .position.inSeconds -
                                                  10))
                                          .then((value) => setState(() {}))
                                      : null,
                                  child: customImageIconSVG(
                                      imageName: SvgImages.backward10Seconds,
                                      color: Colors.white),
                                ),
                                AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 500),
                                  crossFadeState: _controller.value.isPlaying
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  firstChild: GestureDetector(
                                    onTap: () async => await _controller
                                        .play()
                                        .then((value) => setState(
                                            () => showButtons = false)),
                                    child: customImageIconSVG(
                                        imageName: SvgImages.play_1,
                                        color: Colors.white),
                                  ),
                                  secondChild: GestureDetector(
                                    onTap: () async => await _controller
                                        .pause()
                                        .then((value) =>
                                            setState(() => showButtons = true)),
                                    child: customImageIconSVG(
                                        imageName: SvgImages.pause_1,
                                        color: Colors.white),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async => _controller.value.isPlaying
                                      ? await _controller
                                          .seekTo(Duration(
                                              seconds: _controller.value
                                                      .position.inSeconds +
                                                  10))
                                          .then((value) => setState(() {}))
                                      : null,
                                  child: customImageIconSVG(
                                      imageName: SvgImages.forward10Seconds,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // video app bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: const CustomAppBar(),
                  ),

                  // video progress
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      visible: showButtons,
                      child: VideoProgress(
                        onChanged: (value) async {
                          // _controller
                          //     .seekTo(Duration(seconds: value.toInt()))
                          //     .then((value) => setState(() {}));
                        },
                        currentValue: _controller.value.position.inSeconds,
                        duration: _controller.value.duration.inSeconds,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Stack(
            children: [
              Container(
                width: widget.width ?? context.width,
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? widget.height
                        : context.height,
                color: Colors.black,
                child: const Center(
                    child:
                        CircularProgressIndicator(color: Styles.PRIMARY_COLOR)),
              ),
              // video app bar
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: const CustomAppBar(),
              ),
            ],
          );
  }

  //=====================================================
  //=====================================================
  //=====================================================

  @override
  Future<void> dispose() async {
    if (_controller.value.isInitialized) {
      int time = _controller.value.position.inSeconds;
      _controller.dispose();
      // sl<ViewVideoProvider>().viewVideo(id: widget.id, time: time);
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    super.dispose();
  }
}

enum VideoType { asset, network, file }
