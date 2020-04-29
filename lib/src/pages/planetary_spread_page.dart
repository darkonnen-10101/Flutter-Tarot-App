import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/src/providers/current_index.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';

import 'single_card_detail_page.dart';

class PlanetarySpreadPage extends StatefulWidget {
  @override
  _PlanetarySpreadPageState createState() => _PlanetarySpreadPageState();
}

class _PlanetarySpreadPageState extends State<PlanetarySpreadPage> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CurrentIndexProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planetary Spread',
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
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
                      child: DragTargetSpread(),
                    ),
                    Positioned(
                      right: 0,
                      child: DragTargetSpread(),
                    ),
                    Positioned(
                      top: 0,
                      left: 50,
                      child: DragTargetSpread(),
                    ),
                    Positioned(
                      bottom: 0,
                      child: DragTargetSpread(),
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
    );
  }
}
