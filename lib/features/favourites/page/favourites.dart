import 'package:gano/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/dimensions.dart';
import 'package:gano/components/custom_button.dart';
import 'package:gano/features/favourites/repo/favourites_repo.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../provider/favourites_provider.dart';
import '../widgets/favourite_body.dart';
import '../widgets/favourite_header_widget.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key, required this.fromAuth}) : super(key: key);

  final bool fromAuth;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => FavouritesProvider(repo: sl<FavouriteRepo>())
          ..getItems()
          ..getFavourites(),
        child: Scaffold(
          appBar: fromAuth ? null : const CustomAppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Column(
              children: [
                Visibility(
                  visible: fromAuth,
                  child: SizedBox(
                    height: 24.h,
                  ),
                ),
                const FavouriteHeaderWidget(),
                const FavouriteBody(),
              ],
            ),
          ),
          bottomNavigationBar:
              Consumer<FavouritesProvider>(builder: (context, provider, child) {
            return Visibility(
              visible: !provider.isLoading && !provider.isGetting,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                ),
                child: CustomButton(
                  text: getTranslated("save_changes", context),
                  isLoading: provider.isSaving,
                  isActive:
                      provider.isChanged && provider.favouritesId.isNotEmpty,
                  onTap: () => provider.updateFavourites(fromAuth),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
