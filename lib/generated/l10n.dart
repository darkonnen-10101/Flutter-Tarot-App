// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get titlePlanetary {
    return Intl.message(
      'Planetary Spread',
      name: 'titlePlanetary',
      desc: '',
      args: [],
    );
  }

  String get titleTetraktys {
    return Intl.message(
      'Tetraktys Spread',
      name: 'titleTetraktys',
      desc: '',
      args: [],
    );
  }

  String get titleCrossAndTriangle {
    return Intl.message(
      'Cross and Triangle Spread',
      name: 'titleCrossAndTriangle',
      desc: '',
      args: [],
    );
  }

  String get titleCelticCrossSpread {
    return Intl.message(
      'Celtic Cross Spread',
      name: 'titleCelticCrossSpread',
      desc: '',
      args: [],
    );
  }

  String get titleAstrologicalSpread {
    return Intl.message(
      'Astrological Spread',
      name: 'titleAstrologicalSpread',
      desc: '',
      args: [],
    );
  }

  String get titleRelationshipSpread {
    return Intl.message(
      'Relationship Spread',
      name: 'titleRelationshipSpread',
      desc: '',
      args: [],
    );
  }

  String get titlePlanetarySpread {
    return Intl.message(
      'Planetary Spread',
      name: 'titlePlanetarySpread',
      desc: '',
      args: [],
    );
  }

  String get titleBirthdaySpread {
    return Intl.message(
      'Birthday Spread',
      name: 'titleBirthdaySpread',
      desc: '',
      args: [],
    );
  }

  String get titleMandalaSpread {
    return Intl.message(
      'Mandala Spread',
      name: 'titleMandalaSpread',
      desc: '',
      args: [],
    );
  }

  String get titleStarGuideSpread {
    return Intl.message(
      'Star Guide Spread',
      name: 'titleStarGuideSpread',
      desc: '',
      args: [],
    );
  }

  String get titleTreeOfLifeSpread {
    return Intl.message(
      'Tree of Life Spread',
      name: 'titleTreeOfLifeSpread',
      desc: '',
      args: [],
    );
  }

  String get titlePastLifeSpread {
    return Intl.message(
      'Past Life Spread',
      name: 'titlePastLifeSpread',
      desc: '',
      args: [],
    );
  }

  String get titleDreamExplorationSpread {
    return Intl.message(
      'Dream Exploration Spread',
      name: 'titleDreamExplorationSpread',
      desc: '',
      args: [],
    );
  }

  String get titleTrueLoveSpread {
    return Intl.message(
      'True Love Spread',
      name: 'titleTrueLoveSpread',
      desc: '',
      args: [],
    );
  }

  String get titleThreeCardsSpread {
    return Intl.message(
      'Three Cards Spread',
      name: 'titleThreeCardsSpread',
      desc: '',
      args: [],
    );
  }

  String textWithPlaceHolder(Object cardName) {
    return Intl.message(
      'Card $cardName',
      name: 'textWithPlaceHolder',
      desc: '',
      args: [cardName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}