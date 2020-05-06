import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';

class MandalaSpreadPage extends StatefulWidget {
  final int index;

  MandalaSpreadPage(this.index);

  @override
  _MandalaSpreadPageState createState() => _MandalaSpreadPageState();
}

class _MandalaSpreadPageState extends State<MandalaSpreadPage> {
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
          S.of(context).titleMandalaSpread,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DragTargetSpread(numberOrder: 9),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DragTargetSpread(
                                numberOrder: 8,
                              ),
                              DragTargetSpread(
                                numberOrder: 2,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DragTargetSpread(
                                numberOrder: 7,
                              ),
                              DragTargetSpread(
                                numberOrder: 1,
                              ),
                              DragTargetSpread(
                                numberOrder: 3,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DragTargetSpread(
                                numberOrder: 6,
                              ),
                              DragTargetSpread(
                                numberOrder: 4,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DragTargetSpread(
                                numberOrder: 5,
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
                            S.of(context).titleMandalaSpread,
                            style: GoogleFonts.galada(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            S.of(context).spreadMandala,
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
