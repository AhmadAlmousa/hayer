// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Hayer';

  @override
  String get tagline => 'Swipe less. Decide together.';

  @override
  String get newSearch => 'New search';

  @override
  String get joinSession => 'Join a session';

  @override
  String get sessionCode => 'Session code';

  @override
  String get displayName => 'Display name';

  @override
  String get join => 'Join';

  @override
  String get switchToLightTheme => 'Switch to light theme';

  @override
  String get switchToDarkTheme => 'Switch to dark theme';

  @override
  String get setupWhatTitle => 'What are you in the mood for?';

  @override
  String get setupWhereTitle => 'Where to?';

  @override
  String get setupOptionsTitle => 'Fine-tune your deck';

  @override
  String get setupModeTitle => 'How are we deciding?';

  @override
  String get setupTimelineType => 'Type';

  @override
  String get setupTimelineWhere => 'Where';

  @override
  String get setupTimelineOptions => 'Options';

  @override
  String get setupTimelineMode => 'Mode';

  @override
  String get continueLabel => 'Continue';

  @override
  String get backLabel => 'Back';

  @override
  String get restaurants => 'Restaurants';

  @override
  String get cafes => 'Cafes';

  @override
  String get thingsToDo => 'Things to do';

  @override
  String get useCurrentLocation => 'Use current location';

  @override
  String get locatingYou => 'Finding your address…';

  @override
  String get currentLocation => 'Current location';

  @override
  String get locationPermissionRequired =>
      'Location permission is required to use your current location.';

  @override
  String get locationAddressAttribution => 'Address from OpenStreetMap';

  @override
  String get searchLocation => 'Search for a place or neighborhood';

  @override
  String get radius => 'Radius';

  @override
  String get price => 'Maximum price';

  @override
  String get priceDescription =>
      'Keep every place, or set the highest price level you want to see.';

  @override
  String get deckSize => 'Deck size';

  @override
  String get deckSizeDescription =>
      'Choose how many places you want to swipe through.';

  @override
  String get visitTime => 'When are you going?';

  @override
  String get visitTimeDescription =>
      'Choose a day and time and Hayer will leave out places known to be closed then.';

  @override
  String get anyTime => 'Any time';

  @override
  String get chooseVisitTime => 'Choose day and time';

  @override
  String get customTime => 'Custom time';

  @override
  String get clearVisitTime => 'Clear time';

  @override
  String placesCount(int count) {
    return '$count places';
  }

  @override
  String get anyPrice => 'Any';

  @override
  String priceLevelValue(int level) {
    return 'Level $level';
  }

  @override
  String get solo => 'Solo';

  @override
  String get soloDescription => 'A quick decision just for you';

  @override
  String get multiplayer => 'Multiplayer';

  @override
  String get multiplayerDescription => 'Invite friends and find a match';

  @override
  String get majority => 'Majority';

  @override
  String get majorityTip =>
      'A place matches when more than half of the group likes it.';

  @override
  String get unanimous => 'Unanimous';

  @override
  String get unanimousTip => 'A place matches only when everyone likes it.';

  @override
  String get stopOnFirstMatch => 'Stop on first match';

  @override
  String get startSwiping => 'Start swiping';

  @override
  String get createSession => 'Create session';

  @override
  String get findingPlaces => 'Finding the best places…';

  @override
  String get bestEffortGcc =>
      'Hayer is still best effort outside Saudi Arabia.';

  @override
  String get cachedPlacesWarning =>
      'Some place details are cached and may be out of date.';

  @override
  String get underfilledDeck =>
      'We found fewer places than requested. Try a larger radius or broader category.';

  @override
  String get temporarySourceError =>
      'The place source is temporarily unavailable. Please try again.';

  @override
  String get serverUnavailable =>
      'Hayer cannot reach the server. Check your connection and try again.';

  @override
  String get noPlaces =>
      'No eligible places were found. Try a larger radius or broader category.';

  @override
  String get lobby => 'Lobby';

  @override
  String get shareCode => 'Share code';

  @override
  String get participants => 'Participants';

  @override
  String get viewResults => 'View results';

  @override
  String get results => 'Results';

  @override
  String get navigate => 'Navigate';

  @override
  String get sharePicks => 'Share picks';

  @override
  String get shareResults => 'Share results';

  @override
  String get details => 'Details';

  @override
  String get sourceAttribution => 'Place information from Google Maps';

  @override
  String get like => 'Like';

  @override
  String get pass => 'Pass';

  @override
  String get openNow => 'Open now';

  @override
  String get closedNow => 'Closed now';

  @override
  String get unknownHours => 'Hours unavailable';

  @override
  String get noPhoto => 'No photo available';

  @override
  String get waitingForGroup => 'Results may change while others finish.';

  @override
  String get everyoneFinished => 'Everyone has finished';

  @override
  String get noLikes => 'No places liked. Start a new search to try again.';

  @override
  String get noGroupMatch => 'No places matched the group.';

  @override
  String get sessionExpired => 'This session has expired.';

  @override
  String get offlineQueued =>
      'Saved offline. Hayer will sync this swipe when you reconnect.';

  @override
  String get updateRequired => 'Update Hayer to continue.';

  @override
  String get downloadUpdate => 'Download update';

  @override
  String get resumeSession => 'Resume session';

  @override
  String get resumeSoloSession => 'Solo session';

  @override
  String get resumeMultiplayerSession => 'Multiplayer session';

  @override
  String createdAt(String time) {
    return 'Created $time';
  }

  @override
  String get endSoloSessionTitle => 'End this solo session?';

  @override
  String get endSoloSessionMessage =>
      'Your deck and swipe progress will be deleted. This cannot be undone.';

  @override
  String get keepSwiping => 'Keep swiping';

  @override
  String get endSession => 'End session';

  @override
  String get endSessionFailed =>
      'The session could not be ended. Please try again.';

  @override
  String get installHayerTitle => 'Enjoyed deciding with Hayer?';

  @override
  String get installHayerMessage =>
      'Install the app for faster joining and your next group decision.';

  @override
  String get getItOnGooglePlay => 'Get it on Google Play';

  @override
  String get downloadOnAppStore => 'Download on the App Store';

  @override
  String get resumeFailed => 'That saved session is no longer available.';

  @override
  String get allLabel => 'All';

  @override
  String typesCount(int count) {
    return '$count types';
  }

  @override
  String get showQrCode => 'Show QR code';

  @override
  String get qrLabel => 'QR';

  @override
  String get sessionQrTitle => 'Session QR code';

  @override
  String get codeCopied => 'Code copied';

  @override
  String get copyLabel => 'Copy';

  @override
  String get shareLabel => 'Share';

  @override
  String joinMySession(String url) {
    return 'Join my Hayer session: $url';
  }

  @override
  String get firstMatch => 'First match';

  @override
  String get matchFoundTitle => 'It\'s a match!';

  @override
  String get matchFoundCelebration => 'First match—decision made!';

  @override
  String get fullDeck => 'Full deck';

  @override
  String get host => 'Host';

  @override
  String get done => 'Done';

  @override
  String participantProgress(int current, int total) {
    return '$current/$total';
  }

  @override
  String get couldNotLoadSession => 'Could not load session. Please try again.';

  @override
  String get couldNotLoadResults => 'Could not load results. Please try again.';

  @override
  String get groupResults => 'Group results';

  @override
  String get yourPicks => 'Your picks';

  @override
  String codeLabel(String code) {
    return 'Code $code';
  }

  @override
  String participantsCount(int count) {
    return '$count participants';
  }

  @override
  String matchesCount(int count) {
    return '$count matches';
  }

  @override
  String completedCount(int completed, int total) {
    return '$completed/$total done';
  }

  @override
  String groupProgress(int completed, int total) {
    return '$completed/$total completed';
  }

  @override
  String get sortBy => 'Sort by:';

  @override
  String get rating => 'Rating';

  @override
  String get reviews => 'Reviews';

  @override
  String get distance => 'Distance';

  @override
  String reviewsCount(int count) {
    return '$count reviews';
  }

  @override
  String likedPercent(int percent, int likes, int voters) {
    return '$percent% · $likes/$voters liked it';
  }

  @override
  String get ourGroupPicks => 'Our Hayer group picks';

  @override
  String get myPicks => 'My Hayer picks';

  @override
  String participantsCompleted(int completed, int total) {
    return '$completed/$total participants completed';
  }

  @override
  String get hayerPicks => 'Hayer picks';

  @override
  String get weeklyHours => 'Weekly hours';

  @override
  String get website => 'Website';

  @override
  String get directions => 'Directions';

  @override
  String checkedAt(String time) {
    return 'Checked $time';
  }

  @override
  String get cachedDetailsHidden =>
      'Cached details: dynamic fields are hidden.';

  @override
  String get closed => 'Closed';

  @override
  String selectedTime(String time) {
    return 'Selected $time';
  }

  @override
  String get midnight => 'midnight';

  @override
  String get scanQrCode => 'Scan QR code';

  @override
  String get scanInstructions => 'Center the Hayer QR code inside the frame';

  @override
  String get cameraPermissionNeeded =>
      'Camera permission is needed to scan the session code.';

  @override
  String get cameraStartFailed =>
      'The camera could not start. Go back and enter the code instead.';

  @override
  String get joinFailed => 'Could not join this session.';

  @override
  String get invalidSessionCode => 'Enter a valid session code.';

  @override
  String get invalidDisplayName => 'Enter a display name with 2–30 characters.';

  @override
  String get undoLastSwipe => 'Undo last swipe';

  @override
  String cardProgress(int current, int total) {
    return 'Card $current of $total';
  }

  @override
  String get likeStamp => 'LIKE';

  @override
  String get passStamp => 'NOPE';

  @override
  String get openInGoogleMaps => 'Open in Google Maps';

  @override
  String get openWebsite => 'Open website';

  @override
  String get placeFallback => 'place';

  @override
  String get futureVisitTime => 'Choose a future visit time.';

  @override
  String get noSavedSession => 'No saved session yet.';

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get couldNotOpenDirections => 'Could not open directions.';

  @override
  String get mapEditHint =>
      'Search area map. Drag the center dot to move it and the edge handle to resize it.';

  @override
  String mapSelectedHint(String distance) {
    return 'Selected search area map, $distance radius.';
  }

  @override
  String dragMapHint(String distance) {
    return 'Drag center or edge · $distance';
  }

  @override
  String radiusDistance(String distance) {
    return '$distance radius';
  }
}
