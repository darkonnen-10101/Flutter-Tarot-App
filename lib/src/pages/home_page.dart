import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tarotcardapp/src/pages/tutorial_cards_page.dart';
import 'package:tarotcardapp/src/providers/all_deck.dart';
import 'package:tarotcardapp/src/routes/spread_routes.dart';
import 'single_tarot_spread_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _allDeckChoice = Provider.of<AllDeck>(context);

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
        child: Container(
          child: Column(
            children: <Widget>[
              SafeArea(
                child: DrawerHeader(
                  padding: EdgeInsets.all(
                    0.0,
                  ),
                  child: Container(
                    color: Colors.green,
                  ),
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
              ListTile(
                title: Text(
                  S.of(context).useAllCards,
                ),
                trailing: Switch.adaptive(
                  value: _allDeckChoice.allDeck,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    _allDeckChoice.allDeck = value;
                  },
                ),
              ),
              ListTile(
                title: Text(
                  S.of(context).onlyUprightReading,
                ),
                trailing: Switch.adaptive(
                  value: _allDeckChoice.onlyUpright,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    _allDeckChoice.onlyUpright = value;
                  },
                ),
              ),
            ],
          ),
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
//                _TarotCardsDescription(),
                SizedBox(
                  height: 10.0,
                ),
                SpreadSwiper(),
                SizedBox(
                  height: 20.0,
                ),
                _TarotTutorial(
                  image: 'assets/images/oracle.jpg',
                  title: S.of(context).tutorialMajor,
                  isMayorArcana: true,
                  startPosition: 0,
                ),
                _TarotTutorial(
                  image: 'assets/images/oracle.jpg',
                  title: S.of(context).tutorialMinorWands,
                  isMayorArcana: false,
                  startPosition: 22,
                ),
                _TarotTutorial(
                  image: 'assets/images/oracle.jpg',
                  title: S.of(context).tutorialMinorPentacles,
                  isMayorArcana: false,
                  startPosition: 36,
                ),
                _TarotTutorial(
                  image: 'assets/images/oracle.jpg',
                  title: S.of(context).tutorialMinorCups,
                  isMayorArcana: false,
                  startPosition: 50,
                ),
                _TarotTutorial(
                  image: 'assets/images/oracle.jpg',
                  title: S.of(context).tutorialMinorSwords,
                  isMayorArcana: false,
                  startPosition: 64,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TarotTutorial extends StatelessWidget {
  final String image;
  final String title;
  final bool isMayorArcana;
  final int startPosition;

  _TarotTutorial(
      {this.image, this.title, this.isMayorArcana, this.startPosition});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          _TarotTutorialSlivers(
            image: this.image,
            title: this.title,
            page: TutorialCardsPage(
              isMayorArcana: this.isMayorArcana,
              startPosition: this.startPosition,
              title: this.title,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class _TarotTutorialSlivers extends StatelessWidget {
  final String image;
  final String title;
  final page;

  _TarotTutorialSlivers(
      {@required this.image, @required this.title, @required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => this.page,
          ),
        );
      },
      child: Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: this.title,
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
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
                        this.image,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  this.title,
                  style: GoogleFonts.galada(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
      child: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: 'tarot_spread',
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width * 0.8,
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
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).dailyReading,
                style: GoogleFonts.galada(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
