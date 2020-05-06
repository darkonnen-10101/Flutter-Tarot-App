import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';

class CelticCrossSpreadPage extends StatefulWidget {
  final int index;

  CelticCrossSpreadPage(this.index);

  @override
  _CelticCrossSpreadPageState createState() => _CelticCrossSpreadPageState();
}

class _CelticCrossSpreadPageState extends State<CelticCrossSpreadPage> {
  bool accepted = false;
  GlobalKey<FlipCardState> spreadKey = GlobalKey<FlipCardState>();

  final _controller = new ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          S.of(context).titleCelticCrossSpread,
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
                                height: 195.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 6,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 65.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 3,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  DragTargetSpread(
                                    numberOrder: 1,
                                  ),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: DragTargetSpread(
                                      numberOrder: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 4,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 195.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 5,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              DragTargetSpread(
                                numberOrder: 10,
                              ),
                              DragTargetSpread(
                                numberOrder: 9,
                              ),
                              DragTargetSpread(
                                numberOrder: 8,
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
              back: Padding(
                padding: EdgeInsets.all(
                  20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.all(
                    30.0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.pink, BlendMode.darken),
                      image: AssetImage('assets/images/tarotback.png'),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            S.of(context).titleCelticCrossSpread,
                            style: GoogleFonts.galada(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            S.of(context).spreadCelticCross,
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
          ),
        ],
      ),
    );
  }
}
