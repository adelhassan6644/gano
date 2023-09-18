import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gano/app/core/utils/dimensions.dart';

import '../../../../../navigation/custom_navigation.dart';

class VideoBack extends StatelessWidget {
  const VideoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 20.h,
      start: 10.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]);
              CustomNavigator.pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              height: 45,
              width: 45,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
