import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/src/admob/admob_config.dart';
import 'package:tarotcardapp/src/providers/interstitial_counter.dart';

class TreeOfLifeSpread extends StatefulWidget {
  final int index;

  TreeOfLifeSpread(this.index);

  @override
  _TreeOfLifeSpreadState createState() => _TreeOfLifeSpreadState();
}

class _TreeOfLifeSpreadState extends State<TreeOfLifeSpread> {
  bool accepted = false;
  GlobalKey<FlipCardState> spreadKey = GlobalKey<FlipCardState>();

  final _controller = new ScrollController();

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
    _controller.dispose();
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        actions: <Widget>[
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.pinkAccent,
            onPressed: () {
              spreadKey.currentState.toggleCard();
            },
            child: Icon(
              Icons.info,
            ),
          ),
        ],
        title: Text(
          S.of(context).titleTreeOfLifeSpread,
          style: GoogleFonts.galada(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
//          Container(
//            height: MediaQuery.of(context).size.height,
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                colors: [Colors.pinkAccent, Colors.purple],
//              ),
//            ),
//          ),
          Image(
            fit: BoxFit.cover,
            color: Colors.pinkAccent,
            colorBlendMode: BlendMode.darken,
            image: AssetImage(
              'assets/spreads/spread${widget.index}.jpg',
            ),
          ),
          Container(
            height: double.infinity,
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              flipOnTouch: false,
              key: spreadKey,
              front: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: _controller,
                      padding: EdgeInsets.only(
                        top: 40.0,
                        bottom: 150.0,
                      ),
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 65.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 3,
                              ),
                              DragTargetSpread(
                                numberOrder: 5,
                              ),
                              DragTargetSpread(
                                numberOrder: 8,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              DragTargetSpread(
                                numberOrder: 1,
                              ),
                              DragTargetSpread(
                                numberOrder: 6,
                              ),
                              DragTargetSpread(
                                numberOrder: 9,
                              ),
                              DragTargetSpread(
                                numberOrder: 10,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 65.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 2,
                              ),
                              DragTargetSpread(
                                numberOrder: 4,
                              ),
                              DragTargetSpread(
                                numberOrder: 7,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: TarotDeck(),
                    ),
                  ],
                ),
              ),
              back: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(
                      30.0,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.pink, BlendMode.darken),
                        image: AssetImage('assets/images/tarotback.png'),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          S.of(context).titleTreeOfLifeSpread,
                          style: GoogleFonts.galada(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          S.of(context).spreadTreeOfLife,
                          style: GoogleFonts.galada(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
