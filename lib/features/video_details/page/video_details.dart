import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';

import '../widgets/video_widget/video_player/video_player_handler.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayerView(
          path:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          type: VideoType.network,
          height: context.height * 0.4,
          width: context.width),
    );
  }
}
