// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get savedPlaces => 'Saved places';

  @override
  String get wantToTry => 'Want to try';

  @override
  String get favorites => 'Favorites';

  @override
  String get savePlace => 'Save place';

  @override
  String get removeSavedPlace => 'Remove from saved places';

  @override
  String get savedPlaceConfirmation => 'Saved to Want to try.';

  @override
  String get removedSavedPlaceConfirmation => 'Removed from saved places.';

  @override
  String get savedPlaceFailed =>
      'Could not update saved places on this device.';

  @override
  String get privateOnDeviceTitle => 'Private on this device';

  @override
  String get privateOnDeviceMessage =>
      'Saved places and notes stay on this device. They are not synced or exportable yet and may be lost if you clear app data or uninstall Hayer.';

  @override
  String get noSavedPlaces =>
      'No places here yet. Save one while swiping or viewing results.';

  @override
  String get selectForShortlist => 'Select places for a shortlist';

  @override
  String selectedPlacesCount(int count) {
    return '$count selected';
  }

  @override
  String startShortlist(int count) {
    return 'Start shortlist ($count)';
  }

  @override
  String get minimumShortlist =>
      'Select at least two places to start a shortlist.';

  @override
  String get editSavedPlace => 'Edit saved place';

  @override
  String get privateNote => 'Private note';

  @override
  String get privateNoteHint => 'Only you can see this note on this device.';

  @override
  String get deleteSavedPlace => 'Delete saved place';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get startShortlistTitle => 'Start from saved places';

  @override
  String shortlistSelectedCount(int count) {
    return 'Your room will start with $count saved places.';
  }

  @override
  String get freshIdeas => 'Add 5 fresh ideas';

  @override
  String get freshIdeasDescription =>
      'Hayer will look nearby for up to five new places. Your saved places stay in the room even if discovery is unavailable.';

  @override
  String get shortlistAreaTooWide =>
      'Choose saved places that fit within one 10 km search area.';

  @override
  String get shortlistCategoryUnavailable =>
      'These saved places no longer have a supported category.';

  @override
  String get shortlistUnavailable =>
      'Some saved places are no longer available for this room. Update your shortlist and try again.';

  @override
  String get createShortlistRoom => 'Create shortlist room';

  @override
  String get placeDetails => 'Details';

  @override
  String get myChoice => 'My choice';

  @override
  String choiceVotes(String count) {
    return '$count votes';
  }

  @override
  String choiceProgress(String chosen, String total) {
    return '$chosen of $total have chosen';
  }

  @override
  String get chooseDestination => 'Where are we going?';

  @override
  String get choiceHint =>
      'Tap My choice on your favorite. Most votes wins; the host’s choice breaks a tie. You can change your choice.';

  @override
  String get leadingChoice => 'Leading choice';

  @override
  String get groupChoice => 'Group choice';

  @override
  String get choiceTie => 'Tied — waiting for the host’s choice';

  @override
  String get choiceHostTie => 'Choose one of the tied places to break the tie.';

  @override
  String get choiceHostDecided => 'The host’s choice broke the tie.';

  @override
  String get choiceSaving => 'Saving…';

  @override
  String get choiceFailed =>
      'Couldn’t confirm your choice. Check the latest counts and try again.';

  @override
  String get choiceConflict =>
      'Your choice changed elsewhere. The latest choice is shown.';

  @override
  String get choiceNotReady => 'Choices open when everyone finishes swiping.';

  @override
  String get choiceClosed => 'Voting has ended. These are the saved choices.';

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
  String get currentLocation => 'Selected location';

  @override
  String get tryAgain => 'Try again';

  @override
  String get backToHome => 'Back to home';

  @override
  String get searchingLocations => 'Searching for locations';

  @override
  String get noLocationResults =>
      'No locations found. Try a different area or use your current location.';

  @override
  String get locationSearchFailed =>
      'Location search is unavailable. Try again or use your current location.';

  @override
  String get refreshFailed =>
      'Updates paused. Showing the last saved session information.';

  @override
  String get startingHayer => 'Getting Hayer ready…';

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
  String get serverRequestFailed =>
      'The Hayer server could not complete the request. Please try again.';

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
  String get finalSwipePending =>
      'Your final choice is saved on this device. Reconnect to finish syncing before viewing the result.';

  @override
  String get retrySync => 'Retry sync';

  @override
  String get swipeSaveFailed =>
      'This choice could not be saved on this device. Please try again.';

  @override
  String get swipeRejected =>
      'The server could not accept this choice. Refresh the session and try again.';

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
  String get cuisinesLabel => 'Cuisines';

  @override
  String get poiTypesLabel => 'Place types';

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
  String get scanInstructions =>
      'Use your device camera to scan a Hayer session QR code.';

  @override
  String get openingScanner => 'Opening scanner…';

  @override
  String get enterCodeInstead => 'Enter code instead';

  @override
  String get invalidQrCode => 'That QR code is not a Hayer session link.';

  @override
  String get scannerUnavailable =>
      'QR scanning is available in the Android and iOS apps.';

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

  @override
  String get routeOriginTitle => 'Where should your travel estimate start?';

  @override
  String get routeOriginDescription =>
      'This changes only the distance and time shown to you. The group’s places and votes stay the same.';

  @override
  String get useHostLocation => 'Use the host’s location';

  @override
  String get useHostLocationDescription =>
      'Keep everyone’s estimates based on the shared search area.';

  @override
  String get useMyLocation => 'Use my current location';

  @override
  String get useMyLocationDescription =>
      'Calculate my estimates from where I am now.';

  @override
  String get routeOriginSetting => 'Your travel estimate';

  @override
  String get routeDistanceUnavailable => 'Distance unavailable';

  @override
  String get currentLocationUnavailableUsingHost =>
      'Your location is unavailable, so the host’s location will be used.';

  @override
  String distanceMetersLabel(String distance) {
    return '$distance m';
  }

  @override
  String distanceKilometersLabel(String distance) {
    return '$distance km';
  }

  @override
  String approximateRouteEstimate(int minutes, String distance) {
    return '~$minutes min · $distance';
  }

  @override
  String get reportDataIssue => 'Report a data issue';

  @override
  String get reportDataIssueExplanation =>
      'Use this for factual problems with the place data—not because the place is not your taste.';

  @override
  String get reportReasonRequired => 'Choose the factual issue type.';

  @override
  String get reportWrongCategory => 'Wrong category';

  @override
  String get reportClosed => 'Closed';

  @override
  String get reportWrongLocation => 'Wrong location';

  @override
  String get reportDuplicate => 'Duplicate place';

  @override
  String get reportMisleadingPhoto => 'Misleading photo';

  @override
  String get reportOtherDataIssue => 'Other data issue';

  @override
  String get reportDetailsLabel => 'Details (optional)';

  @override
  String get reportDetailsHint => 'What should our reviewer verify?';

  @override
  String get reportDetailsRequired => 'Please describe the other data issue.';

  @override
  String get reportDetailsLength => 'Enter 4–500 characters.';

  @override
  String get reportPrivacyHint =>
      'Do not include personal or sensitive information.';

  @override
  String get submitReport => 'Send for review';

  @override
  String get reportThanks => 'Thanks—your report was sent for review.';

  @override
  String get reportRateLimited =>
      'You have sent several reports. Please try again later.';

  @override
  String get reportFailed => 'Could not send the report. Please try again.';

  @override
  String get dataAndPrivacy => 'Your data';

  @override
  String get dataIntro =>
      'What Hayer sends, what stays on this device, and what your group can see.';

  @override
  String get dataIdentityTitle => 'No account';

  @override
  String get dataIdentityBody =>
      'Hayer never asks for an email address, a phone number, or a password. The app signs in anonymously and keeps that sign-in on this device. The name you type when you create or join a room is shown to that room; it is not checked against anything.';

  @override
  String get dataLocationTitle => 'Location';

  @override
  String get dataLocationBody =>
      'The search location you pick — your current position or a place you searched for — is sent to Hayer with your radius to find places nearby. Addresses come from OpenStreetMap, and place details, photos, and ratings come from Google Maps. If you ask for travel time from where you are, that position is sent with the request. Hayer does not follow your position in the background.';

  @override
  String get dataGroupTitle => 'What your group sees';

  @override
  String get dataGroupBody =>
      'People in your room see the name you joined with, how far through the deck you are, and whether you have finished. Results show how many people liked each place and how many chose it — never who liked or chose what.';

  @override
  String get dataDeviceTitle => 'Kept on this device';

  @override
  String get dataDeviceBody =>
      'Saved places and their notes, the name you last used, the room you can resume, and any swipes that have not reached the server yet stay here. Nothing is synced to an account, so uninstalling Hayer removes them.';

  @override
  String get dataMeasurementTitle => 'Measurement';

  @override
  String get dataMeasurementBody =>
      'Hayer counts anonymous usage — rooms started, cards seen, decisions made — under a random identifier that covers one room and is then dropped, together with the app version, platform, and language. It carries no lasting device identity and is not tied to your saved places or notes.';

  @override
  String get dataEraseTitle => 'Remove data from this device';

  @override
  String get dataEraseBody =>
      'Erasing deletes saved places and notes, the remembered name, the resumable room, and the anonymous sign-in. Rooms expire on the server on their own; erasing here does not remove what the server has already recorded.';

  @override
  String get dataEraseAction => 'Erase data on this device';

  @override
  String get dataEraseConfirmTitle => 'Erase data on this device?';

  @override
  String get dataEraseConfirmBody => 'This cannot be undone.';

  @override
  String dataErasePendingWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count swipes have not reached the server yet and will be lost.',
      one: 'One swipe has not reached the server yet and will be lost.',
    );
    return '$_temp0';
  }

  @override
  String get dataEraseKeep => 'Keep data';

  @override
  String get dataEraseConfirm => 'Erase';

  @override
  String get dataErased => 'Data on this device was erased.';

  @override
  String get dataEraseFailed => 'Could not erase everything. Please try again.';
}
