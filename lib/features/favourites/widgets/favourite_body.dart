import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/favourites_provider.dart';
import 'favourite_item_widget.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(builder: (context, provider, child) {
      return Expanded(
        child: (provider.isLoading && provider.isGetting)
            ? _ShimmerWidget()
            : (provider.items != null &&
                    provider.items!.data != null &&
                    provider.items!.data!.isNotEmpty)
                ? GridListAnimatorWidget(
                    columnCount: 3,
                    aspectRatio: 0.9,
                    items: List.generate(
                      provider.items!.data!.length,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: 3,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: FavouriteItemWidget(
                                favouriteItem: provider.items!.data![index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      provider.getFavourites();
                    },
                    child: const ListAnimator(
                      data: [
                        EmptyState(
                          spaceBtw: 12,
                          txt: "لا يوجد مواضيع حاليا",
                        ),
                      ],
                    ),
                  ),
      );
    });
  }
}

class _ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridListAnimatorWidget(
      columnCount: 3,
      aspectRatio: 0.9,
      items: List.generate(
        21,
        (int index) {
          return AnimationConfiguration.staggeredGrid(
            columnCount: 3,
            position: index,
            duration: const Duration(milliseconds: 375),
            child: const ScaleAnimation(
              child: FadeInAnimation(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomShimmerCircleImage(diameter: 75),
                    SizedBox(height: 8),
                    CustomShimmerText(width: 100)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
