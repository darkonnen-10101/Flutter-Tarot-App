import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';

class SingleCardDetailPage extends StatefulWidget {
  final int index;

  SingleCardDetailPage({this.index});

  @override
  _SingleCardDetailPageState createState() => _SingleCardDetailPageState();
}

class _SingleCardDetailPageState extends State<SingleCardDetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1,
      ),
    )..addListener(() {
        cardKey.currentState.toggleCard();
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    List content = [
      S.of(context).card0,
      S.of(context).card1,
      S.of(context).card2,
      S.of(context).card3,
      S.of(context).card4,
      S.of(context).card5,
      S.of(context).card6,
      S.of(context).card7,
      S.of(context).card8,
      S.of(context).card9,
      S.of(context).card10,
      S.of(context).card11,
      S.of(context).card12,
      S.of(context).card13,
      S.of(context).card14,
      S.of(context).card15,
      S.of(context).card16,
      S.of(context).card17,
      S.of(context).card18,
      S.of(context).card19,
      S.of(context).card20,
      S.of(context).card21,
    ];

    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(
          0.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.red,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
            ),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'single_card_detail',
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: false,
                    key: cardKey,
                    front: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF9c0c74),
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: Color(0x44000000))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Image(
                            fit: BoxFit.cover,
                            width: 200.0,
                            image: AssetImage(
                              //'assets/images/back.jpeg',
                              'assets/images/tarotback.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF9c0c74),
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: Color(0x44000000))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image(
                          fit: BoxFit.cover,
                          width: 200.0,
                          image: AssetImage(
                            //'assets/images/back.jpeg',
                            'assets/images/${widget.index}.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(
                    20.0,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.pinkAccent,
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.all(
                        30.0,
                      ),
                      child: Text(
                        '${content[widget.index]}',
                        style: GoogleFonts.galada(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
