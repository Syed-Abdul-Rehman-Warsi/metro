import 'dart:developer';

import 'package:dubai_metro_app/logger.dart';
import 'package:dubai_metro_app/splash.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  // FirebaseCrashlytics.instance.crash();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dubai Metro',
      color: const Color(0xFF50A4D7),
      theme: ThemeData(
        primaryColor: const Color(0xFF50A4D7),
      ),
      home: const Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BannerAd _bannerAd;

  bool _isAdLoaded = false;

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-4134896162060991/4111406950',
      listener: BannerAdListener(onAdLoaded: ((ad) {
        setState(() {
          _isAdLoaded = true;
        });
      }), onAdFailedToLoad: ((ad, error) {
        logger.i(error);
      })),
      request: const AdRequest(),
    );

    _bannerAd.load();
  }

  @override
  void initState() {
    _initBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: const Color(0xFF50A4D7),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.center,
                  child: InteractiveViewer(
                    maxScale: 150,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://pumsuoysnovuyqwdfxvm.supabase.co/storage/v1/object/public/maps/Images/dubai_metro_map.jpg?t=2022-11-06T14%3A19%3A20.112Z",
                      alignment: Alignment.center,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                _isAdLoaded
                    ? Container(
                        height: _bannerAd.size.height.toDouble(),
                        width: _bannerAd.size.width.toDouble(),
                        color: Colors.blue[50],
                        child: AdWidget(
                          ad: _bannerAd,
                        ),
                      )
                    : Container(
                        height: 70,
                        width: 150,
                        color: Colors.blue[50],
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Ad not loaded",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
