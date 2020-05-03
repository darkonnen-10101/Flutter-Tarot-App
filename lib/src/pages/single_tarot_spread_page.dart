import 'package:deck_scrollview/deck_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/widgets/drag_target_spread.dart';
import 'package:tarotcardapp/src/widgets/tarot_deck.dart';
import 'single_card_detail_page.dart';
import 'dart:math';

class SingleTarotSpreadPage extends StatefulWidget {
  @override
  _SingleTarotSpreadPageState createState() => _SingleTarotSpreadPageState();
}

class _SingleTarotSpreadPageState extends State<SingleTarotSpreadPage> {
//  ScrollController controller;

  int currentIndex = 0;

  int myCount = 22;
  bool myBool = false;

  @override
  void initState() {
    super.initState();

//    controller = ScrollController(
//      initialScrollOffset: 10.0,
//      keepScrollOffset: true,
//    ); // NEW
//
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      controller
//        ..animateTo(
//          // NEW
//          controller.position.maxScrollExtent, // NEW
//          duration: const Duration(milliseconds: 500), // NEW
//          curve: Curves.easeInOutCubic, // NEW
//        );
//    });
  }

  @override
  void dispose() {
//    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: DragTargetSpread(),
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
