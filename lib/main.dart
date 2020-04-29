import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/src/pages/planetary_spread_page.dart';

import 'src/pages/home_page.dart';
import 'src/providers/current_index.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CurrentIndexProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
      },
      title: 'Material App',
      home: //HomePage(),
          PlanetarySpreadPage(),
    );
  }
}
