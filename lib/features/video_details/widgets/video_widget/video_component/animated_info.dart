import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/extensions.dart';

class AnimatedInfo extends StatelessWidget {
  final controller;
  final animation;

  const AnimatedInfo(
      {Key? key, required this.controller, required this.animation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform(
            transform:
                Matrix4.translationValues(animation.value * 600, 0.0, 0.0),
            child: SizedBox(
              width: context.width,
              height: context.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Gano Test",
                    style: TextStyle(color: Colors.grey[500], fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '01010201884',
                    style: TextStyle(color: Colors.grey[500], fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
