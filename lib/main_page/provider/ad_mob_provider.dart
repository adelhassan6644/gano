import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gano/data/api/end_points.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/config/di.dart';
import '../../features/video_details/provider/view_video_provider.dart';

class AdMobProvider extends ChangeNotifier {
  InterstitialAd? _interstitialAd;
  Timer? _watchingTimer;
  int _numInterstitialLoadAttempts = 0;
  final AdRequest request = const AdRequest(
    keywords: <String>['games'],
    nonPersonalizedAds: true,
  );
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  countTime() {
    _watchingTimer?.cancel();
    notifyListeners();
    _watchingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      log(timer.tick.toString());
      notifyListeners();
    });
  }

  void showRewardedAd() {
    createRewardedAd();
    if (_rewardedAd == null) {
      log('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        log('ad onAdShowedFullScreenContent.');
        countTime();
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');

        _watchingTimer?.cancel();
        notifyListeners();

        // ad.request.
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');

        ad.dispose();
        createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);

    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      sl<ViewVideoProvider>().viewVideo(id: 1, time: _watchingTimer?.tick);

      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      createRewardedAd();
      _watchingTimer?.cancel();

      _rewardedAd!.dispose();
    });
    _rewardedAd = null;
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? EndPoints.rewardedAdAndroid
            : EndPoints.rewardedAdIOS,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');

            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < 10) {
              createRewardedAd();
            }
          },
        ));
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? EndPoints.interstitialAdAndroid
            : EndPoints.interstitialAdIOS,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 5) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
