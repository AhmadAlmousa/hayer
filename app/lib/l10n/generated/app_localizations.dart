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

  /// No description provided for @switchToLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to light theme'**
  String get switchToLightTheme;

  /// No description provided for @switchToDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark theme'**
  String get switchToDarkTheme;

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

  /// No description provided for @setupTimelineType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get setupTimelineType;

  /// No description provided for @setupTimelineWhere.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get setupTimelineWhere;

  /// No description provided for @setupTimelineOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get setupTimelineOptions;

  /// No description provided for @setupTimelineMode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get setupTimelineMode;

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

  /// No description provided for @locatingYou.
  ///
  /// In en, this message translates to:
  /// **'Finding your address…'**
  String get locatingYou;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Selected location'**
  String get currentLocation;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @searchingLocations.
  ///
  /// In en, this message translates to:
  /// **'Searching for locations'**
  String get searchingLocations;

  /// No description provided for @noLocationResults.
  ///
  /// In en, this message translates to:
  /// **'No locations found. Try a different area or use your current location.'**
  String get noLocationResults;

  /// No description provided for @locationSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Location search is unavailable. Try again or use your current location.'**
  String get locationSearchFailed;

  /// No description provided for @refreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Updates paused. Showing the last saved session information.'**
  String get refreshFailed;

  /// No description provided for @startingHayer.
  ///
  /// In en, this message translates to:
  /// **'Getting Hayer ready…'**
  String get startingHayer;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to use your current location.'**
  String get locationPermissionRequired;

  /// No description provided for @locationAddressAttribution.
  ///
  /// In en, this message translates to:
  /// **'Address from OpenStreetMap'**
  String get locationAddressAttribution;

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

  /// No description provided for @priceDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep every place, or set the highest price level you want to see.'**
  String get priceDescription;

  /// No description provided for @deckSize.
  ///
  /// In en, this message translates to:
  /// **'Deck size'**
  String get deckSize;

  /// No description provided for @deckSizeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how many places you want to swipe through.'**
  String get deckSizeDescription;

  /// No description provided for @visitTime.
  ///
  /// In en, this message translates to:
  /// **'When are you going?'**
  String get visitTime;

  /// No description provided for @visitTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a day and time and Hayer will leave out places known to be closed then.'**
  String get visitTimeDescription;

  /// No description provided for @anyTime.
  ///
  /// In en, this message translates to:
  /// **'Any time'**
  String get anyTime;

  /// No description provided for @chooseVisitTime.
  ///
  /// In en, this message translates to:
  /// **'Choose day and time'**
  String get chooseVisitTime;

  /// No description provided for @customTime.
  ///
  /// In en, this message translates to:
  /// **'Custom time'**
  String get customTime;

  /// No description provided for @clearVisitTime.
  ///
  /// In en, this message translates to:
  /// **'Clear time'**
  String get clearVisitTime;

  /// No description provided for @placesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} places'**
  String placesCount(int count);

  /// No description provided for @anyPrice.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get anyPrice;

  /// No description provided for @priceLevelValue.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String priceLevelValue(int level);

  /// No description provided for @solo.
  ///
  /// In en, this message translates to:
  /// **'Solo'**
  String get solo;

  /// No description provided for @soloDescription.
  ///
  /// In en, this message translates to:
  /// **'A quick decision just for you'**
  String get soloDescription;

  /// No description provided for @multiplayer.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer'**
  String get multiplayer;

  /// No description provided for @multiplayerDescription.
  ///
  /// In en, this message translates to:
  /// **'Invite friends and find a match'**
  String get multiplayerDescription;

  /// No description provided for @majority.
  ///
  /// In en, this message translates to:
  /// **'Majority'**
  String get majority;

  /// No description provided for @majorityTip.
  ///
  /// In en, this message translates to:
  /// **'A place matches when more than half of the group likes it.'**
  String get majorityTip;

  /// No description provided for @unanimous.
  ///
  /// In en, this message translates to:
  /// **'Unanimous'**
  String get unanimous;

  /// No description provided for @unanimousTip.
  ///
  /// In en, this message translates to:
  /// **'A place matches only when everyone likes it.'**
  String get unanimousTip;

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

  /// No description provided for @serverUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Hayer cannot reach the server. Check your connection and try again.'**
  String get serverUnavailable;

  /// No description provided for @serverRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'The Hayer server could not complete the request. Please try again.'**
  String get serverRequestFailed;

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

  /// No description provided for @sharePicks.
  ///
  /// In en, this message translates to:
  /// **'Share picks'**
  String get sharePicks;

  /// No description provided for @shareResults.
  ///
  /// In en, this message translates to:
  /// **'Share results'**
  String get shareResults;

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

  /// No description provided for @finalSwipePending.
  ///
  /// In en, this message translates to:
  /// **'Your final choice is saved on this device. Reconnect to finish syncing before viewing the result.'**
  String get finalSwipePending;

  /// No description provided for @retrySync.
  ///
  /// In en, this message translates to:
  /// **'Retry sync'**
  String get retrySync;

  /// No description provided for @swipeSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'This choice could not be saved on this device. Please try again.'**
  String get swipeSaveFailed;

  /// No description provided for @swipeRejected.
  ///
  /// In en, this message translates to:
  /// **'The server could not accept this choice. Refresh the session and try again.'**
  String get swipeRejected;

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

  /// No description provided for @resumeSoloSession.
  ///
  /// In en, this message translates to:
  /// **'Solo session'**
  String get resumeSoloSession;

  /// No description provided for @resumeMultiplayerSession.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer session'**
  String get resumeMultiplayerSession;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created {time}'**
  String createdAt(String time);

  /// No description provided for @endSoloSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'End this solo session?'**
  String get endSoloSessionTitle;

  /// No description provided for @endSoloSessionMessage.
  ///
  /// In en, this message translates to:
  /// **'Your deck and swipe progress will be deleted. This cannot be undone.'**
  String get endSoloSessionMessage;

  /// No description provided for @keepSwiping.
  ///
  /// In en, this message translates to:
  /// **'Keep swiping'**
  String get keepSwiping;

  /// No description provided for @endSession.
  ///
  /// In en, this message translates to:
  /// **'End session'**
  String get endSession;

  /// No description provided for @endSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'The session could not be ended. Please try again.'**
  String get endSessionFailed;

  /// No description provided for @installHayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoyed deciding with Hayer?'**
  String get installHayerTitle;

  /// No description provided for @installHayerMessage.
  ///
  /// In en, this message translates to:
  /// **'Install the app for faster joining and your next group decision.'**
  String get installHayerMessage;

  /// No description provided for @getItOnGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Get it on Google Play'**
  String get getItOnGooglePlay;

  /// No description provided for @downloadOnAppStore.
  ///
  /// In en, this message translates to:
  /// **'Download on the App Store'**
  String get downloadOnAppStore;

  /// No description provided for @resumeFailed.
  ///
  /// In en, this message translates to:
  /// **'That saved session is no longer available.'**
  String get resumeFailed;

  /// No description provided for @allLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allLabel;

  /// No description provided for @typesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} types'**
  String typesCount(int count);

  /// No description provided for @cuisinesLabel.
  ///
  /// In en, this message translates to:
  /// **'Cuisines'**
  String get cuisinesLabel;

  /// No description provided for @poiTypesLabel.
  ///
  /// In en, this message translates to:
  /// **'Place types'**
  String get poiTypesLabel;

  /// No description provided for @showQrCode.
  ///
  /// In en, this message translates to:
  /// **'Show QR code'**
  String get showQrCode;

  /// No description provided for @qrLabel.
  ///
  /// In en, this message translates to:
  /// **'QR'**
  String get qrLabel;

  /// No description provided for @sessionQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Session QR code'**
  String get sessionQrTitle;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get codeCopied;

  /// No description provided for @copyLabel.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyLabel;

  /// No description provided for @shareLabel.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareLabel;

  /// No description provided for @joinMySession.
  ///
  /// In en, this message translates to:
  /// **'Join my Hayer session: {url}'**
  String joinMySession(String url);

  /// No description provided for @firstMatch.
  ///
  /// In en, this message translates to:
  /// **'First match'**
  String get firstMatch;

  /// No description provided for @matchFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'It\'\'s a match!'**
  String get matchFoundTitle;

  /// No description provided for @matchFoundCelebration.
  ///
  /// In en, this message translates to:
  /// **'First match—decision made!'**
  String get matchFoundCelebration;

  /// No description provided for @fullDeck.
  ///
  /// In en, this message translates to:
  /// **'Full deck'**
  String get fullDeck;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @participantProgress.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total}'**
  String participantProgress(int current, int total);

  /// No description provided for @couldNotLoadSession.
  ///
  /// In en, this message translates to:
  /// **'Could not load session. Please try again.'**
  String get couldNotLoadSession;

  /// No description provided for @couldNotLoadResults.
  ///
  /// In en, this message translates to:
  /// **'Could not load results. Please try again.'**
  String get couldNotLoadResults;

  /// No description provided for @groupResults.
  ///
  /// In en, this message translates to:
  /// **'Group results'**
  String get groupResults;

  /// No description provided for @yourPicks.
  ///
  /// In en, this message translates to:
  /// **'Your picks'**
  String get yourPicks;

  /// No description provided for @codeLabel.
  ///
  /// In en, this message translates to:
  /// **'Code {code}'**
  String codeLabel(String code);

  /// No description provided for @participantsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} participants'**
  String participantsCount(int count);

  /// No description provided for @matchesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} matches'**
  String matchesCount(int count);

  /// No description provided for @completedCount.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} done'**
  String completedCount(int completed, int total);

  /// No description provided for @groupProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} completed'**
  String groupProgress(int completed, int total);

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by:'**
  String get sortBy;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String reviewsCount(int count);

  /// No description provided for @likedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% · {likes}/{voters} liked it'**
  String likedPercent(int percent, int likes, int voters);

  /// No description provided for @ourGroupPicks.
  ///
  /// In en, this message translates to:
  /// **'Our Hayer group picks'**
  String get ourGroupPicks;

  /// No description provided for @myPicks.
  ///
  /// In en, this message translates to:
  /// **'My Hayer picks'**
  String get myPicks;

  /// No description provided for @participantsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} participants completed'**
  String participantsCompleted(int completed, int total);

  /// No description provided for @hayerPicks.
  ///
  /// In en, this message translates to:
  /// **'Hayer picks'**
  String get hayerPicks;

  /// No description provided for @weeklyHours.
  ///
  /// In en, this message translates to:
  /// **'Weekly hours'**
  String get weeklyHours;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @checkedAt.
  ///
  /// In en, this message translates to:
  /// **'Checked {time}'**
  String checkedAt(String time);

  /// No description provided for @cachedDetailsHidden.
  ///
  /// In en, this message translates to:
  /// **'Cached details: dynamic fields are hidden.'**
  String get cachedDetailsHidden;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @selectedTime.
  ///
  /// In en, this message translates to:
  /// **'Selected {time}'**
  String selectedTime(String time);

  /// No description provided for @midnight.
  ///
  /// In en, this message translates to:
  /// **'midnight'**
  String get midnight;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQrCode;

  /// No description provided for @scanInstructions.
  ///
  /// In en, this message translates to:
  /// **'Use your device camera to scan a Hayer session QR code.'**
  String get scanInstructions;

  /// No description provided for @openingScanner.
  ///
  /// In en, this message translates to:
  /// **'Opening scanner…'**
  String get openingScanner;

  /// No description provided for @enterCodeInstead.
  ///
  /// In en, this message translates to:
  /// **'Enter code instead'**
  String get enterCodeInstead;

  /// No description provided for @invalidQrCode.
  ///
  /// In en, this message translates to:
  /// **'That QR code is not a Hayer session link.'**
  String get invalidQrCode;

  /// No description provided for @scannerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'QR scanning is available in the Android and iOS apps.'**
  String get scannerUnavailable;

  /// No description provided for @cameraPermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is needed to scan the session code.'**
  String get cameraPermissionNeeded;

  /// No description provided for @cameraStartFailed.
  ///
  /// In en, this message translates to:
  /// **'The camera could not start. Go back and enter the code instead.'**
  String get cameraStartFailed;

  /// No description provided for @joinFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not join this session.'**
  String get joinFailed;

  /// No description provided for @invalidSessionCode.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid session code.'**
  String get invalidSessionCode;

  /// No description provided for @invalidDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Enter a display name with 2–30 characters.'**
  String get invalidDisplayName;

  /// No description provided for @undoLastSwipe.
  ///
  /// In en, this message translates to:
  /// **'Undo last swipe'**
  String get undoLastSwipe;

  /// No description provided for @cardProgress.
  ///
  /// In en, this message translates to:
  /// **'Card {current} of {total}'**
  String cardProgress(int current, int total);

  /// No description provided for @likeStamp.
  ///
  /// In en, this message translates to:
  /// **'LIKE'**
  String get likeStamp;

  /// No description provided for @passStamp.
  ///
  /// In en, this message translates to:
  /// **'NOPE'**
  String get passStamp;

  /// No description provided for @openInGoogleMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Google Maps'**
  String get openInGoogleMaps;

  /// No description provided for @openWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open website'**
  String get openWebsite;

  /// No description provided for @placeFallback.
  ///
  /// In en, this message translates to:
  /// **'place'**
  String get placeFallback;

  /// No description provided for @futureVisitTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a future visit time.'**
  String get futureVisitTime;

  /// No description provided for @noSavedSession.
  ///
  /// In en, this message translates to:
  /// **'No saved session yet.'**
  String get noSavedSession;

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'\'s new'**
  String get whatsNew;

  /// No description provided for @couldNotOpenDirections.
  ///
  /// In en, this message translates to:
  /// **'Could not open directions.'**
  String get couldNotOpenDirections;

  /// No description provided for @mapEditHint.
  ///
  /// In en, this message translates to:
  /// **'Search area map. Drag the center dot to move it and the edge handle to resize it.'**
  String get mapEditHint;

  /// No description provided for @mapSelectedHint.
  ///
  /// In en, this message translates to:
  /// **'Selected search area map, {distance} radius.'**
  String mapSelectedHint(String distance);

  /// No description provided for @dragMapHint.
  ///
  /// In en, this message translates to:
  /// **'Drag center or edge · {distance}'**
  String dragMapHint(String distance);

  /// No description provided for @radiusDistance.
  ///
  /// In en, this message translates to:
  /// **'{distance} radius'**
  String radiusDistance(String distance);

  /// No description provided for @routeOriginTitle.
  ///
  /// In en, this message translates to:
  /// **'Where should your travel estimate start?'**
  String get routeOriginTitle;

  /// No description provided for @routeOriginDescription.
  ///
  /// In en, this message translates to:
  /// **'This changes only the distance and time shown to you. The group’s places and votes stay the same.'**
  String get routeOriginDescription;

  /// No description provided for @useHostLocation.
  ///
  /// In en, this message translates to:
  /// **'Use the host’s location'**
  String get useHostLocation;

  /// No description provided for @useHostLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep everyone’s estimates based on the shared search area.'**
  String get useHostLocationDescription;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my current location'**
  String get useMyLocation;

  /// No description provided for @useMyLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Calculate my estimates from where I am now.'**
  String get useMyLocationDescription;

  /// No description provided for @routeOriginSetting.
  ///
  /// In en, this message translates to:
  /// **'Your travel estimate'**
  String get routeOriginSetting;

  /// No description provided for @routeDistanceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Distance unavailable'**
  String get routeDistanceUnavailable;

  /// No description provided for @currentLocationUnavailableUsingHost.
  ///
  /// In en, this message translates to:
  /// **'Your location is unavailable, so the host’s location will be used.'**
  String get currentLocationUnavailableUsingHost;

  /// No description provided for @distanceMetersLabel.
  ///
  /// In en, this message translates to:
  /// **'{distance} m'**
  String distanceMetersLabel(String distance);

  /// No description provided for @distanceKilometersLabel.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKilometersLabel(String distance);

  /// No description provided for @approximateRouteEstimate.
  ///
  /// In en, this message translates to:
  /// **'~{minutes} min · {distance}'**
  String approximateRouteEstimate(int minutes, String distance);
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
