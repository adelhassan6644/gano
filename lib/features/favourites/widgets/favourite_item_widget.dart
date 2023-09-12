import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/app/core/utils/text_styles.dart';
import 'package:gano/components/custom_network_image.dart';
import 'package:gano/features/favourites/model/favourite_model.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
import '../provider/favourites_provider.dart';

class FavouriteItemWidget extends StatelessWidget {
  final FavouriteItem favouriteItem;

  const FavouriteItemWidget({super.key, required this.favouriteItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
      builder: (_, provider, child) {
        bool isFav = false;
        isFav =
            provider.favouritesId.indexWhere((e) => e == favouriteItem.id!) !=
                -1;
        return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => provider.addItem(id: favouriteItem.id!, isFav: isFav),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage.circleNewWorkImage(
                    image: favouriteItem.image,
                    radius: 37.5,
                    padding: 12,
                    backGroundColor:
                        isFav ? const Color(0xFFFFF6DE) : Styles.WHITE_COLOR,
                    color: Styles.SELECTED_BORER_COLOR),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  favouriteItem.title ?? "",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium
                      .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 16),
                ),
              ],
            ));
      },
    );
  }
}
