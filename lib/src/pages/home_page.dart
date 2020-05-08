import 'dart:ui';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tarotcardapp/src/admob/admob_config.dart';
import 'package:tarotcardapp/src/pages/tutorial_cards_page.dart';
import 'package:tarotcardapp/src/providers/all_deck.dart';
import 'package:tarotcardapp/src/providers/interstitial_counter.dart';
import 'package:tarotcardapp/src/routes/spread_routes.dart';
import 'package:tarotcardapp/src/widgets/admob_banner_wrapper.dart';
import 'package:tarotcardapp/src/widgets/privacy_policy.dart';
import 'single_tarot_spread_page.dart';

import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  static AdmobBannerSize bannerSize = AdmobBannerSize.FULL_BANNER;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdmobBannerWrapper fixedAdmobBanner = AdmobBannerWrapper(
    adSize: HomePage.bannerSize,
    adUnitId: getBannerAdUnitId(),
  );

  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();

    super.initState();
    // Add code after super
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _allDeckChoice = Provider.of<AllDeck>(context);
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    Future<bool> getInterstitial() async {
      bool myBool = await interstitialAd.isLoaded;
      if (myBool && _interstitialCounter.counter >= 10) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          interstitialAd.show();
        });
        _interstitialCounter.counter = 0;
      }
      return myBool;
    }

    getInterstitial();

    Future<void> _displayDialog(BuildContext context) async {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return PrivacyPolicy();
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text(
          'Tarot',
          style: GoogleFonts.galada(
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/oracle.jpg'),
                ),
              ),
              ListTile(
                enabled: true,
                title: Text(
                  S.of(context).optionHome,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(
                  S.of(context).useAllCards,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                trailing: Switch.adaptive(
                  value: _allDeckChoice.allDeck,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    _allDeckChoice.allDeck = value;
                  },
                ),
              ),
              ListTile(
                title: Text(
                  S.of(context).onlyUprightReading,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                trailing: Switch.adaptive(
                  value: _allDeckChoice.onlyUpright,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    _allDeckChoice.onlyUpright = value;
                  },
                ),
              ),
              ListTile(
                title: Text(
                  S.of(context).optionShare,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  Share.share(
                      'Tarot App https://play.google.com/store/apps/details?id=com.mundodiferente.tarotcardapp');
                },
              ),
              ListTile(
                title: Text(
                  S.of(context).privacyPolicy,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _displayDialog(context);
                },
              ),
              ListTile(
                title: Text(
                  S.of(context).optionExit,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 60.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _SingleCardChoice(),
                    SizedBox(
                      height: 10.0,
                    ),
//                _TarotCardsDescription(),
                    SizedBox(
                      height: 10.0,
                    ),
                    SpreadSwiper(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/arcana.jpg',
                      title: S.of(context).tutorialMajor,
                      isMayorArcana: true,
                      startPosition: 0,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/wands.jpg',
                      title: S.of(context).tutorialMinorWands,
                      isMayorArcana: false,
                      startPosition: 22,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/swords.jpg',
                      title: S.of(context).tutorialMinorSwords,
                      isMayorArcana: false,
                      startPosition: 64,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/cups.jpg',
                      title: S.of(context).tutorialMinorCups,
                      isMayorArcana: false,
                      startPosition: 50,
                    ),

                    _TarotTutorial(
                      image: 'assets/images/pentacles.jpg',
                      title: S.of(context).tutorialMinorPentacles,
                      isMayorArcana: false,
                      startPosition: 36,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: fixedAdmobBanner,
            ),
          ),
        ],
      ),
    );
  }
}

class _TarotTutorial extends StatelessWidget {
  final String image;
  final String title;
  final bool isMayorArcana;
  final int startPosition;

  _TarotTutorial(
      {this.image, this.title, this.isMayorArcana, this.startPosition});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          _TarotTutorialSlivers(
            image: this.image,
            title: this.title,
            page: TutorialCardsPage(
              isMayorArcana: this.isMayorArcana,
              startPosition: this.startPosition,
              title: this.title,
              image: this.image,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class _TarotTutorialSlivers extends StatelessWidget {
  final String image;
  final String title;
  final page;

  _TarotTutorialSlivers(
      {@required this.image, @required this.title, @required this.page});

  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    return GestureDetector(
      onTap: () {
        _interstitialCounter.counter += 1;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => this.page,
          ),
        );
      },
      child: Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: this.title,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
                  child: Parallax.inside(
                    mainAxisExtent: 200.0,
                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      color: Colors.pink,
                      colorBlendMode: BlendMode.darken,
                      image: AssetImage(
                        this.image,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  this.title,
                  style: GoogleFonts.galada(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpreadSwiper extends StatelessWidget {
  SpreadSwiper();

  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    List<String> pagesTitles = [
      S.of(context).titleAstrologicalSpread,
      S.of(context).titleBirthdaySpread,
      S.of(context).titleCelticCrossSpread,
      S.of(context).titleCrossAndTriangleSpread,
      S.of(context).titleDreamExplorationSpread,
      S.of(context).titleMandalaSpread,
      S.of(context).titlePastLifeSpread,
      S.of(context).titlePlanetarySpread,
      S.of(context).titleRelationshipSpread,
      S.of(context).titleStarGuideSpread,
      S.of(context).titleTetraktysSpread,
      S.of(context).titleThreeCardsSpread,
      S.of(context).titleTreeOfLifeSpread,
      S.of(context).titleTrueLoveSpread,
    ];

    return Container(
      width: double.infinity,
      height: 400.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                child: Image(
                  fit: BoxFit.cover,
                  color: Colors.pinkAccent,
                  colorBlendMode: BlendMode.darken,
                  image: AssetImage(
                    'assets/spreads/spread$index.jpg',
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${pagesTitles[index]}',
                  style: GoogleFonts.galada(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          );
        },
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.pinkAccent,
            color: Colors.blueGrey.withOpacity(
              0.3,
            ),
          ),
        ),
        itemCount: 14,
        itemWidth: 300.0,
        itemHeight: 300.0,
        layout: SwiperLayout.STACK,
        onTap: (index) {
          _interstitialCounter.counter += 1;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => pages[index],
            ),
          );
        },
        onIndexChanged: (index) {},
      ),
    );
  }
}

class _SingleCardChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    return GestureDetector(
      onTap: () {
        _interstitialCounter.counter += 1;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SingleTarotSpreadPage(),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: 'tarot_spread',
              child: Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
//                    child: Image(
//                      fit: BoxFit.cover,
//                      color: Colors.pink,
//                      colorBlendMode: BlendMode.darken,
//                      height: 100.0,
//                      image: AssetImage(
//                        'assets/images/goddess.jpg',
//                      ),
//                    ),
                  child: Image(
                    fit: BoxFit.cover,
                    color: Colors.pinkAccent,
                    colorBlendMode: BlendMode.darken,
                    image: AssetImage(
                      'assets/images/goddess.jpg',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).dailyReading,
                style: GoogleFonts.galada(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
