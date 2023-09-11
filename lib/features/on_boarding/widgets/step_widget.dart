import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/styles.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                  child: AnimatedContainer(
                    height: 3,
                    width: currentIndex == index ? 50 : 35,
                    decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Styles.PRIMARY_COLOR
                            : Styles.HINT_COLOR,
                        borderRadius: BorderRadius.circular(100)),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  ),
                )));
  }
}
