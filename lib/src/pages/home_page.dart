import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/src/data/tarot_cards.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tarotcardapp/src/pages/spreads/planetary_spread_page.dart';
import 'single_card_detail_page.dart';
import 'single_tarot_spread_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    return Container(
      width: double.infinity,
      height: 400.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.pinkAccent,
          ),
        ),
        itemCount: 10,
        itemWidth: 300.0,
        layout: SwiperLayout.STACK,
        onTap: (index) {
          print(index);
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlanetarySpreadPage(),
              ),
            );
          }
        },
        onIndexChanged: (index) {
          print(index);
        },
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
      initialPage: 3,
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
        physics: BouncingScrollPhysics(),
        controller: pageController,
        pageSnapping: false,
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
                    child: Image(
                      image: int == currentIndex
                          ? AssetImage('assets/images/$int.jpg')
                          : AssetImage('assets/images/tarotback.png'),
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
                opacity: 0.3,
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
                      color: Colors.grey,
                      colorBlendMode: BlendMode.colorDodge,
                      height: 100.0,
                      image: NetworkImage(
                        'https://www.avcj.com/IMG/641/23641/gypsy-fortune-teller-crystal-ball-prediction-580x358.jpeg?1576576090',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150.0,
              left: 30.0,
              child: Text(
                'Daily Reading',
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
