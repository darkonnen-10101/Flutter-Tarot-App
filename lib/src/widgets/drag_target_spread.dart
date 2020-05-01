import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/src/pages/single_card_detail_page.dart';
import 'package:tarotcardapp/src/providers/current_index.dart';

class DragTargetSpread extends StatefulWidget {
  final int numberOrder;

  DragTargetSpread({@required this.numberOrder});

  @override
  _DragTargetSpreadState createState() => _DragTargetSpreadState();
}

class _DragTargetSpreadState extends State<DragTargetSpread> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _AuxModel(),
      child: DragTargetInstance(
        numberOrder: widget.numberOrder,
      ),
    );
  }
}

class DragTargetInstance extends StatefulWidget {
  final int numberOrder;

  DragTargetInstance({@required this.numberOrder});

  @override
  _DragTargetInstanceState createState() => _DragTargetInstanceState();
}

class _DragTargetInstanceState extends State<DragTargetInstance> {
  bool accepted = false;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CurrentIndexProvider>(context);
    final goToPage = Provider.of<_AuxModel>(context);

    return Container(
      height: 130.0,
      width: 70.0,
      child: !accepted
          ? DragTarget<int>(
              onWillAccept: (data) {
//                    Navigator.pushNamed(context, '/detail');
//                print(data);
                //print(currentIndex.currentIndex);
                return true;
              },
              onAccept: (data) {
                goToPage.goToPage = currentIndex.currentIndex;
                Future<FlipCardState>.delayed(Duration(milliseconds: 1200), () {
                  return cardKey.currentState;
                })
                  ..then((myVar) {
                    myVar.toggleCard();
                  });

                accepted = true;
              },
              builder: (context, accepted, rejected) {
                return Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image(
                        fit: BoxFit.cover,
                        color: Colors.grey,
                        colorBlendMode: BlendMode.hardLight,
                        image: AssetImage(
                          //'assets/images/back.jpeg',
                          'assets/images/tarotback.png',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.numberOrder}',
                        style: GoogleFonts.galada(
                          color: Colors.pink,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SingleCardDetailPage(
                      index: goToPage.goToPage,
                    ),
                  ),
                );
              },
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: false,
                key: cardKey,
                front: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Color(0x44000000))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            //'assets/images/back.jpeg',
                            'assets/images/tarotback.png',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.numberOrder}',
                          style: GoogleFonts.galada(
                            color: Colors.pink,
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                back: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 7, color: Color(0x44000000))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Stack(
                      children: <Widget>[
                        Image(
                          fit: BoxFit.fill,
                          width: 200.0,
                          image: AssetImage(
                            //'assets/images/back.jpeg',
                            'assets/images/${goToPage.goToPage}.jpg',
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.numberOrder}',
                            style: GoogleFonts.galada(
                              color: Colors.pink,
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
//          : GestureDetector(
//              onTap: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (_) => SingleCardDetailPage(
//                      index: goToPage.goToPage,
//                    ),
//                  ),
//                );
//              },
//              child: Container(
//                decoration: BoxDecoration(
//                  color: Color(0xFF9c0c74),
//                  boxShadow: [
//                    BoxShadow(blurRadius: 3, color: Color(0x44000000))
//                  ],
//                  borderRadius: BorderRadius.all(Radius.circular(5)),
//                ),
//                child: ClipRRect(
//                  borderRadius: BorderRadius.all(Radius.circular(5)),
//                  child: Image(
//                    fit: BoxFit.cover,
//                    image: AssetImage(
//                      //'assets/images/back.jpeg',
//                      'assets/images/tarotback.png',
//                    ),
//                  ),
//                ),
//              ),
//            ),
    );
  }
}

class _AuxModel with ChangeNotifier {
  int _goToPage = 0;

  int get goToPage => _goToPage;

  set goToPage(int value) {
    _goToPage = value;
    notifyListeners();
  }
}
