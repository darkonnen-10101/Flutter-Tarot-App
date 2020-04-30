import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';

class TetraktysSpreadPage extends StatefulWidget {
  @override
  _TetraktysSpreadPageState createState() => _TetraktysSpreadPageState();
}

class _TetraktysSpreadPageState extends State<TetraktysSpreadPage> {
  bool accepted = false;
  GlobalKey<FlipCardState> spreadKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
              spreadKey.currentState.toggleCard();
            },
            child: Icon(
              Icons.info,
            ),
          ),
        ],
        title: Text(
          S.of(context).titleTetraktys,
        ),
      ),
      body: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        flipOnTouch: false,
        key: spreadKey,
        front: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 180.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: DragTargetSpread(
                          numberOrder: 0,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: DragTargetSpread(
                          numberOrder: 1,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 50,
                        child: DragTargetSpread(
                          numberOrder: 2,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: DragTargetSpread(
                          numberOrder: 3,
                        ),
                      ),
                    ],
                  ),
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
          color: Colors.green,
          child: Image(
            image: AssetImage('assets/images/tarotback.png'),
          ),
        ),
      ),
    );
  }
}
