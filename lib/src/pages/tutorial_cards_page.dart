import 'package:flutter/material.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarotcardapp/generated/l10n.dart';
import 'package:tarotcardapp/src/pages/single_card_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TutorialCardsPage extends StatelessWidget {
  final String title;
  final bool isMayorArcana;
  final int startPosition;
  final String image;

  TutorialCardsPage(
      {this.isMayorArcana, this.startPosition, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    int currentIndex;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        title: Text(
          this.title,
          style: GoogleFonts.galada(),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(this.image),
          ),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: Colors.pinkAccent,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  S.of(context).instructionsClick,
                  style: GoogleFonts.galada(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
                StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 30.0,
                  ),
                  crossAxisCount: 4,
                  itemCount: this.isMayorArcana ? 22 : 14,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
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
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.extent(2, 300),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
