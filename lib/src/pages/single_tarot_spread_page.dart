import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/admob/admob_config.dart';
import 'package:tarotcardapp/src/providers/interstitial_counter.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';

class SingleTarotSpreadPage extends StatefulWidget {
  @override
  _SingleTarotSpreadPageState createState() => _SingleTarotSpreadPageState();
}

class _SingleTarotSpreadPageState extends State<SingleTarotSpreadPage> {
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

    Future<bool> getInterstitial() async {
      bool myBool = await interstitialAd.isLoaded;
      if (myBool && _interstitialCounter.counter >= 10) {
        interstitialAd.show();
        _interstitialCounter.counter = 0;
      }
      return myBool;
    }

    getInterstitial();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          title: Text(
            S.of(context).dailyReading,
            style: GoogleFonts.galada(),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: 'tarot_spread',
                    child: Image(
                      color: Colors.pinkAccent,
                      colorBlendMode: BlendMode.darken,
                      fit: BoxFit.fitWidth,
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
                child: Container(
                  height: 150.0,
                  width: 95.0,
                  child: DragTargetSpread(
                    autoDetail: true,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: TarotDeck(),
            ),
          ],
        ),
      ),
    );
  }
}
