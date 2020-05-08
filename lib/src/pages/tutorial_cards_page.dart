import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/admob/admob_config.dart';
import 'package:tarotcardapp/src/pages/single_card_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tarotcardapp/src/providers/interstitial_counter.dart';
import 'package:tarotcardapp/src/widgets/admob_banner_wrapper.dart';

class TutorialCardsPage extends StatefulWidget {
  final String title;
  final bool isMayorArcana;
  final int startPosition;
  final String image;

  static AdmobBannerSize bannerSize = AdmobBannerSize.FULL_BANNER;

  TutorialCardsPage(
      {this.isMayorArcana, this.startPosition, this.title, this.image});

  @override
  _TutorialCardsPageState createState() => _TutorialCardsPageState();
}

class _TutorialCardsPageState extends State<TutorialCardsPage> {
  final AdmobBannerWrapper fixedAdmobBanner = AdmobBannerWrapper(
    adSize: TutorialCardsPage.bannerSize,
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
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);
    int currentIndex;

    Future<bool> getInterstitial() async {
      bool myBool = await interstitialAd.isLoaded;
      if (myBool && _interstitialCounter.counter >= 10) {
        interstitialAd.show();
        _interstitialCounter.counter = 0;
      }
      return myBool;
    }

    getInterstitial();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        title: Text(
          this.widget.title,
          style: GoogleFonts.galada(),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(this.widget.image),
          ),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: Colors.pinkAccent,
          ),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      S.of(context).instructionsClick,
                      style: GoogleFonts.galada(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: 30.0,
                      ),
                      crossAxisCount: 4,
                      itemCount: this.widget.isMayorArcana ? 22 : 14,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          _interstitialCounter.counter += 1;
                          currentIndex = index + this.widget.startPosition;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SingleCardDetailPage(
                                index: currentIndex,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(
                            8.0,
                          ),
                          child: new Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(
                                    3.0,
                                    3.0,
                                  ),
                                  blurRadius: 16.0,
                                  spreadRadius: 4.0,
                                ),
                              ],
                            ),
//              color: Colors.transparent,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/${index + this.widget.startPosition}.jpg'),
                            ),
                          ),
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.extent(2, 300),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
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
        ),
      ),
    );
  }
}
