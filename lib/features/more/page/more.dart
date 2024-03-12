import 'package:gano/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/extensions.dart';
import '../widgets/more_body_widget.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const Column(
            children: [
              ProfileCard(),
              Expanded(
                child: ListAnimator(
                  data: [
                    SizedBox(height: 24),
                    MoreBodyWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
