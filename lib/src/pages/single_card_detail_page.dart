import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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

//  cardKey.currentState.toggleCard()

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(
          0.0,
        ),
      ),
      body: Container(
        //color: Colors.red,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
            ],
          ),
        ),
      ),
    );
  }
}
