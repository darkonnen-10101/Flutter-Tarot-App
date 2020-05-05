import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/pages/single_card_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TutorialCardsPage extends StatelessWidget {
  final String title;
  final bool isMayorArcana;
  final int startPosition;

  TutorialCardsPage({this.isMayorArcana, this.startPosition, this.title});

  @override
  Widget build(BuildContext context) {
    int currentIndex;

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.pinkAccent, Colors.deepPurpleAccent],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          title: Text(
            this.title,
            style: GoogleFonts.galada(),
          ),
        ),
        body: StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: 30.0,
          ),
          crossAxisCount: 4,
          itemCount: this.isMayorArcana ? 22 : 14,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              currentIndex = index + this.startPosition;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SingleCardDetailPage(
                    index: currentIndex,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(
                8.0,
              ),
              child: new Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 16.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                ),
//              color: Colors.transparent,
                child: Image(
                  image: AssetImage(
                      'assets/images/${index + this.startPosition}.jpg'),
                ),
              ),
            ),
          ),
          staggeredTileBuilder: (int index) => new StaggeredTile.extent(2, 300),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

class _TarotCardsDescription extends StatefulWidget {
  @override
  __TarotCardsDescriptionState createState() => __TarotCardsDescriptionState();
}

class __TarotCardsDescriptionState extends State<_TarotCardsDescription> {
  PageController pageController;
  int currentIndex;

  @override
  void initState() {
    currentIndex = 0;
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.3,
    );

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 300.0,
        minHeight: 250.0,
      ),
      child: PageView.builder(
        controller: pageController,
        pageSnapping: true,
        onPageChanged: (int) {
          setState(() {
            currentIndex = int;
          });
        },
        itemBuilder: (context, int) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (int == currentIndex)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SingleCardDetailPage(index: int),
                      ),
                    );
                },
                child: Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius:
                            30.0, // has the effect of softening the shadow
                        spreadRadius:
                            5.0, // has the effect of extending the shadow
                        offset: Offset(
                          10.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.0,
                  ),
                  transform: Matrix4.identity()
                    ..translate(0.0, int == currentIndex ? -10.0 : 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 230.0,
                      ),
                      child: RotatedBox(
                        quarterTurns: int == currentIndex ? 0 : 2,
                        child: Image(
                          image: int == currentIndex
                              ? AssetImage('assets/images/$int.jpg')
                              : AssetImage('assets/images/tarotback.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (int == currentIndex)
                Column(
                  children: <Widget>[
                    Text(
                      '$int',
                      style: GoogleFonts.galada(color: Colors.pinkAccent),
                    ),
// TODO
//                    Text(
//                      '${cardsNames[int]}',
//                      style: GoogleFonts.galada(color: Colors.pinkAccent),
//                    ),
                  ],
                ),
            ],
          );
        },
        // TODO
//        itemCount: cardsNames.length,
        itemCount: 22,
      ),
    );
  }
}
