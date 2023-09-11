import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:gano/data/config/di.dart' as di;

import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/contact_with_us/provider/contact_with_us_provider.dart';
import '../../features/favourite/provider/favourite_provider.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/setting/provider/config_provider.dart';
import '../../main_page/provider/main_page_provider.dart';

abstract class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MainPageProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FavouriteProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<NotificationsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ContactWithUsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ConfigProvider>()),
  ];
}
