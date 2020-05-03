import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/data/tarot_cards.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tarotcardapp/src/routes/spread_routes.dart';
import 'single_card_detail_page.dart';
import 'single_tarot_spread_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text(
          'Tarot',
          style: GoogleFonts.galada(
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(
                0.0,
              ),
              child: Container(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 30.0,
            ),
            child: Column(
              children: <Widget>[
                _SingleCardChoice(),
                SizedBox(
                  height: 10.0,
                ),
                _TarotCardsDescription(),
                SizedBox(
                  height: 10.0,
                ),
                SpreadSwiper(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpreadSwiper extends StatelessWidget {
  SpreadSwiper();

  @override
  Widget build(BuildContext context) {
    List<String> pagesTitles = [
      S.of(context).titleAstrologicalSpread,
      S.of(context).titleBirthdaySpread,
      S.of(context).titleCelticCrossSpread,
      S.of(context).titleCrossAndTriangle,
      S.of(context).titleDreamExplorationSpread,
      S.of(context).titleMandalaSpread,
      S.of(context).titlePastLifeSpread,
      S.of(context).titlePlanetarySpread,
      S.of(context).titleRelationshipSpread,
      S.of(context).titleStarGuideSpread,
      S.of(context).titleTetraktys,
      S.of(context).titleThreeCardsSpread,
      S.of(context).titleTreeOfLifeSpread,
      S.of(context).titleTrueLoveSpread,
    ];

    return Container(
      width: double.infinity,
      height: 400.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                child: Image(
                  fit: BoxFit.cover,
                  color: Colors.pinkAccent,
                  colorBlendMode: BlendMode.darken,
                  image: AssetImage(
                    'assets/spreads/spread$index.jpg',
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${pagesTitles[index]}',
                  style: GoogleFonts.galada(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          );
        },
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.pinkAccent,
            color: Colors.blueGrey.withOpacity(
              0.3,
            ),
          ),
        ),
        itemCount: 14,
        itemWidth: 300.0,
        itemHeight: 300.0,
        layout: SwiperLayout.STACK,
        onTap: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => pages[index],
            ),
          );
        },
        onIndexChanged: (index) {},
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
  GlobalKey<FlipCardState> singleCardKey = GlobalKey<FlipCardState>();

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
                    Text(
                      '${cardsNames[int]}',
                      style: GoogleFonts.galada(color: Colors.pinkAccent),
                    ),
                  ],
                ),
            ],
          );
        },
        itemCount: cardsNames.length,
      ),
    );
  }
}

class _SingleCardChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SingleTarotSpreadPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            24.0,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.deepOrange,
            ],
            begin: Alignment.centerLeft,
            end: Alignment(
              1.0,
              1.0,
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: 'tarot_spread',
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9c0c74),
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Color(0x44000000))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        24.0,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        24.0,
                      ),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      color: Colors.pink,
                      colorBlendMode: BlendMode.darken,
                      height: 100.0,
                      image: AssetImage(
                        'assets/images/oracle.jpg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120.0,
              left: 30.0,
              child: Text(
                S.of(context).dailyReading,
                style: GoogleFonts.galada(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
