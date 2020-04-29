import 'package:deck_scrollview/deck_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/src/providers/current_index.dart';

class TarotDeck extends StatefulWidget {
  @override
  _TarotDeckState createState() => _TarotDeckState();
}

class _TarotDeckState extends State<TarotDeck> {
  ScrollController controller;

  int myCount = 22;
  bool myBool = false;
  final List allCards = List.generate(22, (int) => int);

  @override
  void initState() {
    super.initState();

    controller = ScrollController(
      initialScrollOffset: 10.0,
      keepScrollOffset: true,
    ); // NEW

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller
        ..animateTo(
          // NEW
          controller.position.maxScrollExtent, // NEW
          duration: const Duration(milliseconds: 500), // NEW
          curve: Curves.easeInOutCubic, // NEW
        );
    });
  }

  int randomChoice = 0;

  int getRand() {
    randomChoice = (allCards..shuffle()).first;
    return randomChoice;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CurrentIndexProvider>(context);
    int myData = 0;

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: RotatedBox(
        quarterTurns: 1,
        child: DeckScrollView.useDelegate(
          layoutPow: 2.5,
          itemExtent: 95,
          controller: controller,
          clipToSize: true,
          childDelegate: DeckChildBuilderDelegate(
            builder: (context, index) => Draggable<int>(
              maxSimultaneousDrags: 1,
              //axis: Axis.vertical,
              affinity: Axis.vertical,
              onDragStarted: () {
                currentIndex.currentIndex = getRand();
//                myData = currentIndex.currentIndex;
//                print(currentIndex.currentIndex);

//                int randomNumber = (allCards..shuffle()).first;
//
//                currentIndex.currentIndex = randomNumber;
//
//                myData = randomNumber;
//                print(myData);
                //allCards.remove(randomNumber);
              },
              onDraggableCanceled: (vel, off) {
                setState(() {});
              },
              onDragCompleted: () {
                setState(() {
//                  currentIndex.currentIndex = getRand();
                  myData = randomChoice;
                  allCards.remove(randomChoice);

//                  int randomNumber = (allCards..shuffle()).first;
//
//                  currentIndex.currentIndex = randomNumber;
//
//                  myData = randomNumber;
//                  allCards.remove(randomNumber);
                });
              },
              data: myData,
              childWhenDragging: Container(),
              feedback: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: Color(0x44000000))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image(
                    width: 150.0,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      //'assets/images/back.jpeg',
                      'assets/images/tarotback.png',
                    ),
                  ),
                ),
              ),
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
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
                      image: AssetImage(
                        //'assets/images/back.jpeg',
                        'assets/images/tarotback.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            childCount: allCards.length,
          ),
        ),
      ),
    );
  }
}
