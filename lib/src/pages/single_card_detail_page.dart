import 'package:admob_flutter/admob_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/admob/admob_config.dart';
import 'package:tarotcardapp/src/widgets/admob_banner_wrapper.dart';

class SingleCardDetailPage extends StatefulWidget {
  final int index;
  static AdmobBannerSize bannerSize = AdmobBannerSize.FULL_BANNER;

  SingleCardDetailPage({this.index});

  @override
  _SingleCardDetailPageState createState() => _SingleCardDetailPageState();
}

class _SingleCardDetailPageState extends State<SingleCardDetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final AdmobBannerWrapper fixedAdmobBanner = AdmobBannerWrapper(
    adSize: SingleCardDetailPage.bannerSize,
    adUnitId: getBannerAdUnitId(),
  );

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

    List titleCards = [
      S.of(context).cardName0,
      S.of(context).cardName1,
      S.of(context).cardName2,
      S.of(context).cardName3,
      S.of(context).cardName4,
      S.of(context).cardName5,
      S.of(context).cardName6,
      S.of(context).cardName7,
      S.of(context).cardName8,
      S.of(context).cardName9,
      S.of(context).cardName10,
      S.of(context).cardName11,
      S.of(context).cardName12,
      S.of(context).cardName13,
      S.of(context).cardName14,
      S.of(context).cardName15,
      S.of(context).cardName16,
      S.of(context).cardName17,
      S.of(context).cardName18,
      S.of(context).cardName19,
      S.of(context).cardName20,
      S.of(context).cardName21,
      S.of(context).cardName22,
      S.of(context).cardName23,
      S.of(context).cardName24,
      S.of(context).cardName25,
      S.of(context).cardName26,
      S.of(context).cardName27,
      S.of(context).cardName28,
      S.of(context).cardName29,
      S.of(context).cardName30,
      S.of(context).cardName31,
      S.of(context).cardName32,
      S.of(context).cardName33,
      S.of(context).cardName34,
      S.of(context).cardName35,
      S.of(context).cardName36,
      S.of(context).cardName37,
      S.of(context).cardName38,
      S.of(context).cardName39,
      S.of(context).cardName40,
      S.of(context).cardName41,
      S.of(context).cardName42,
      S.of(context).cardName43,
      S.of(context).cardName44,
      S.of(context).cardName45,
      S.of(context).cardName46,
      S.of(context).cardName47,
      S.of(context).cardName48,
      S.of(context).cardName49,
      S.of(context).cardName50,
      S.of(context).cardName51,
      S.of(context).cardName52,
      S.of(context).cardName53,
      S.of(context).cardName54,
      S.of(context).cardName55,
      S.of(context).cardName56,
      S.of(context).cardName57,
      S.of(context).cardName58,
      S.of(context).cardName59,
      S.of(context).cardName60,
      S.of(context).cardName61,
      S.of(context).cardName62,
      S.of(context).cardName63,
      S.of(context).cardName64,
      S.of(context).cardName65,
      S.of(context).cardName66,
      S.of(context).cardName67,
      S.of(context).cardName68,
      S.of(context).cardName69,
      S.of(context).cardName70,
      S.of(context).cardName71,
      S.of(context).cardName72,
      S.of(context).cardName73,
      S.of(context).cardName74,
      S.of(context).cardName75,
      S.of(context).cardName76,
      S.of(context).cardName77,
    ];

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
      S.of(context).card22,
      S.of(context).card23,
      S.of(context).card24,
      S.of(context).card25,
      S.of(context).card26,
      S.of(context).card27,
      S.of(context).card28,
      S.of(context).card29,
      S.of(context).card30,
      S.of(context).card31,
      S.of(context).card32,
      S.of(context).card33,
      S.of(context).card34,
      S.of(context).card35,
      S.of(context).card36,
      S.of(context).card37,
      S.of(context).card38,
      S.of(context).card39,
      S.of(context).card40,
      S.of(context).card41,
      S.of(context).card42,
      S.of(context).card43,
      S.of(context).card44,
      S.of(context).card45,
      S.of(context).card46,
      S.of(context).card47,
      S.of(context).card48,
      S.of(context).card49,
      S.of(context).card50,
      S.of(context).card51,
      S.of(context).card52,
      S.of(context).card53,
      S.of(context).card54,
      S.of(context).card55,
      S.of(context).card56,
      S.of(context).card57,
      S.of(context).card58,
      S.of(context).card59,
      S.of(context).card60,
      S.of(context).card61,
      S.of(context).card62,
      S.of(context).card63,
      S.of(context).card64,
      S.of(context).card65,
      S.of(context).card66,
      S.of(context).card67,
      S.of(context).card68,
      S.of(context).card69,
      S.of(context).card70,
      S.of(context).card71,
      S.of(context).card72,
      S.of(context).card73,
      S.of(context).card74,
      S.of(context).card75,
      S.of(context).card76,
      S.of(context).card77,
    ];

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
          backgroundColor: Colors.transparent.withOpacity(
            0.0,
          ),
          title: Text(
            '${titleCards[widget.index]}',
            style: GoogleFonts.galada(),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
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
                                BoxShadow(
                                    blurRadius: 3, color: Color(0x44000000))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: Colors.pinkAccent,
                          elevation: 10.0,
                          child: Padding(
                            padding: EdgeInsets.all(
                              30.0,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${titleCards[widget.index]}',
                                  style: GoogleFonts.galada(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                  ),
                                ),
                                Text(
                                  '${content[widget.index]}',
                                  style: GoogleFonts.galada(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: fixedAdmobBanner,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
