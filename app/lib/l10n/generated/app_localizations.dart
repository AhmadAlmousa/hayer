import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Hayer'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Swipe less. Decide together.'**
  String get tagline;

  /// No description provided for @newSearch.
  ///
  /// In en, this message translates to:
  /// **'New search'**
  String get newSearch;

  /// No description provided for @joinSession.
  ///
  /// In en, this message translates to:
  /// **'Join a session'**
  String get joinSession;

  /// No description provided for @sessionCode.
  ///
  /// In en, this message translates to:
  /// **'Session code'**
  String get sessionCode;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayName;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @setupWhatTitle.
  ///
  /// In en, this message translates to:
  /// **'What are you in the mood for?'**
  String get setupWhatTitle;

  /// No description provided for @setupWhereTitle.
  ///
  /// In en, this message translates to:
  /// **'Where to?'**
  String get setupWhereTitle;

  /// No description provided for @setupOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune your deck'**
  String get setupOptionsTitle;

  /// No description provided for @setupModeTitle.
  ///
  /// In en, this message translates to:
  /// **'How are we deciding?'**
  String get setupModeTitle;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @backLabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backLabel;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @cafes.
  ///
  /// In en, this message translates to:
  /// **'Cafes'**
  String get cafes;

  /// No description provided for @thingsToDo.
  ///
  /// In en, this message translates to:
  /// **'Things to do'**
  String get thingsToDo;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use current location'**
  String get useCurrentLocation;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search for a place or neighborhood'**
  String get searchLocation;

  /// No description provided for @radius.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get radius;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Maximum price'**
  String get price;

  /// No description provided for @deckSize.
  ///
  /// In en, this message translates to:
  /// **'Deck size'**
  String get deckSize;

  /// No description provided for @anyPrice.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get anyPrice;

  /// No description provided for @solo.
  ///
  /// In en, this message translates to:
  /// **'Solo'**
  String get solo;

  /// No description provided for @multiplayer.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer'**
  String get multiplayer;

  /// No description provided for @majority.
  ///
  /// In en, this message translates to:
  /// **'Majority'**
  String get majority;

  /// No description provided for @unanimous.
  ///
  /// In en, this message translates to:
  /// **'Unanimous'**
  String get unanimous;

  /// No description provided for @stopOnFirstMatch.
  ///
  /// In en, this message translates to:
  /// **'Stop on first match'**
  String get stopOnFirstMatch;

  /// No description provided for @startSwiping.
  ///
  /// In en, this message translates to:
  /// **'Start swiping'**
  String get startSwiping;

  /// No description provided for @createSession.
  ///
  /// In en, this message translates to:
  /// **'Create session'**
  String get createSession;

  /// No description provided for @findingPlaces.
  ///
  /// In en, this message translates to:
  /// **'Finding the best places…'**
  String get findingPlaces;

  /// No description provided for @bestEffortGcc.
  ///
  /// In en, this message translates to:
  /// **'Hayer is still best effort outside Saudi Arabia.'**
  String get bestEffortGcc;

  /// No description provided for @cachedPlacesWarning.
  ///
  /// In en, this message translates to:
  /// **'Some place details are cached and may be out of date.'**
  String get cachedPlacesWarning;

  /// No description provided for @underfilledDeck.
  ///
  /// In en, this message translates to:
  /// **'We found fewer places than requested. Try a larger radius or broader category.'**
  String get underfilledDeck;

  /// No description provided for @temporarySourceError.
  ///
  /// In en, this message translates to:
  /// **'The place source is temporarily unavailable. Please try again.'**
  String get temporarySourceError;

  /// No description provided for @noPlaces.
  ///
  /// In en, this message translates to:
  /// **'No eligible places were found. Try a larger radius or broader category.'**
  String get noPlaces;

  /// No description provided for @lobby.
  ///
  /// In en, this message translates to:
  /// **'Lobby'**
  String get lobby;

  /// No description provided for @shareCode.
  ///
  /// In en, this message translates to:
  /// **'Share code'**
  String get shareCode;

  /// No description provided for @participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get participants;

  /// No description provided for @viewResults.
  ///
  /// In en, this message translates to:
  /// **'View results'**
  String get viewResults;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @sourceAttribution.
  ///
  /// In en, this message translates to:
  /// **'Place information from Google Maps'**
  String get sourceAttribution;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// No description provided for @openNow.
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get openNow;

  /// No description provided for @closedNow.
  ///
  /// In en, this message translates to:
  /// **'Closed now'**
  String get closedNow;

  /// No description provided for @unknownHours.
  ///
  /// In en, this message translates to:
  /// **'Hours unavailable'**
  String get unknownHours;

  /// No description provided for @noPhoto.
  ///
  /// In en, this message translates to:
  /// **'No photo available'**
  String get noPhoto;

  /// No description provided for @waitingForGroup.
  ///
  /// In en, this message translates to:
  /// **'Results may change while others finish.'**
  String get waitingForGroup;

  /// No description provided for @everyoneFinished.
  ///
  /// In en, this message translates to:
  /// **'Everyone has finished'**
  String get everyoneFinished;

  /// No description provided for @noLikes.
  ///
  /// In en, this message translates to:
  /// **'No places liked. Start a new search to try again.'**
  String get noLikes;

  /// No description provided for @noGroupMatch.
  ///
  /// In en, this message translates to:
  /// **'No places matched the group.'**
  String get noGroupMatch;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'This session has expired.'**
  String get sessionExpired;

  /// No description provided for @offlineQueued.
  ///
  /// In en, this message translates to:
  /// **'Saved offline. Hayer will sync this swipe when you reconnect.'**
  String get offlineQueued;

  /// No description provided for @updateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update Hayer to continue.'**
  String get updateRequired;

  /// No description provided for @downloadUpdate.
  ///
  /// In en, this message translates to:
  /// **'Download update'**
  String get downloadUpdate;

  /// No description provided for @resumeSession.
  ///
  /// In en, this message translates to:
  /// **'Resume session'**
  String get resumeSession;

  /// No description provided for @resumeFailed.
  ///
  /// In en, this message translates to:
  /// **'That saved session is no longer available.'**
  String get resumeFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
