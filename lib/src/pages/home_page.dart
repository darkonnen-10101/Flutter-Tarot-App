import 'package:flutter/material.dart';
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
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
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
      color: Colors.green,
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SingleCardDetailPage(index: int),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.0,
                  ),
                  transform: Matrix4.identity()
                    ..translate(0.0, int == currentIndex ? -10.0 : 0.0),
                  child: Image(
                    height: 250.0,
                    image: AssetImage('assets/images/$int.jpg'),
                  ),
                ),
              ),
              Text(
                '${cardsNames[int]}',
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
  const _SingleCardChoice({
    Key key,
  }) : super(key: key);

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
      child: Hero(
        tag: 'tarot_spread',
        child: Container(
          height: 300.0,
          width: 300.0,
          decoration: BoxDecoration(
            color: Color(0xFF9c0c74),
            boxShadow: [BoxShadow(blurRadius: 3, color: Color(0x44000000))],
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
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
    );
  }
}
