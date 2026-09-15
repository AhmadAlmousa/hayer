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
  String get liveUpdatesPaused =>
      'Live updates are paused. Hayer keeps checking for changes.';

  @override
  String get liveUpdatesUnreachable =>
      'Hayer cannot reach the server. This is the last view that loaded.';

  @override
  String get refreshNow => 'Refresh now';

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
      'The search location you pick — your current position or a place you searched for — is sent to Hayer with your radius to find places nearby. Addresses come from OpenStreetMap, and place details, photos, and ratings come from Google Maps. If you ask for travel time from where you are, that position is sent with the request. In Got time, Hayer receives the map area you search, not your position. If you allow location, the map opens around you, so that first area is near you, and distances to places are worked out on this device. Hayer does not follow your position in the background.';

  @override
  String get dataGroupTitle => 'What your group sees';

  @override
  String get dataGroupBody =>
      'People in your room see the name you joined with, how far through the deck you are, and whether you have finished. Results show how many people liked each place and how many chose it — never who liked or chose what.';

  @override
  String get dataDeviceTitle => 'Kept on this device';

  @override
  String get dataDeviceBody =>
      'Saved places and their notes, the name you last used, the room you can resume, the last area you searched in Got time, a Got time link kept while it was unavailable, and any swipes that have not reached the server yet stay here. Nothing is synced to an account, so uninstalling Hayer removes them.';

  @override
  String get dataMeasurementTitle => 'Measurement';

  @override
  String get dataMeasurementBody =>
      'Hayer counts anonymous usage — rooms started, cards seen, decisions made — under a random identifier that covers one room and is then dropped, together with the app version, platform, and language. It carries no lasting device identity and is not tied to your saved places or notes.';

  @override
  String get dataEraseTitle => 'Remove data from this device';

  @override
  String get dataEraseBody =>
      'Erasing deletes saved places and notes, the remembered name, the resumable room, the last Got time area and any kept Got time link, and the anonymous sign-in. Rooms expire on the server on their own; erasing here does not remove what the server has already recorded.';

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

  @override
  String get homeTimeQuestion => 'How much time do you have?';

  @override
  String get inAHurry => 'In a hurry';

  @override
  String get inAHurryDescription =>
      'Pick a vibe, swipe a deck, decide in a minute';

  @override
  String inAHurryCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cards',
      one: '1 card',
    );
    return '$_temp0';
  }

  @override
  String get inAHurrySoloOrGroup => 'Solo or group';

  @override
  String get inAHurryDuration => '~60 sec';

  @override
  String get gotTime => 'Got time';

  @override
  String get gotTimeDescription =>
      'Dig through every place on the map, your way';

  @override
  String get gotTimeSortAndFilter => 'Sort & filter';

  @override
  String get gotTimeHiddenGems => 'Hidden gems';

  @override
  String get gotTimeFullMap => 'Full map';

  @override
  String get discoveryUnavailable =>
      'Got time isn’t available right now. Try again later.';

  @override
  String get discoveryChecking => 'Checking whether Got time is available';

  @override
  String get discoveryLinkSavedTitle => 'Your Got time link is saved';

  @override
  String get discoveryLinkReady => 'Got time is available now.';

  @override
  String get openDiscoveryLink => 'Open link';

  @override
  String get dismissDiscoveryLink => 'Dismiss';

  @override
  String get discoveryStillUnavailable =>
      'Got time still isn’t available. Your link is kept.';

  @override
  String get discoveryThisArea => 'This area';

  @override
  String discoveryAreaThisView(String area) {
    return '$area · this view';
  }

  @override
  String discoveryPreviousArea(String area) {
    return 'Previous area · $area';
  }

  @override
  String discoveryPlacesInView(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString places in view',
      one: '1 place in view',
      zero: 'No places in view',
    );
    return '$_temp0';
  }

  @override
  String discoveryPlacesInPreviousArea(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString places in the previous area',
      one: '1 place in the previous area',
      zero: 'No places in the previous area',
    );
    return '$_temp0';
  }

  @override
  String get discoveryLoadingPlaces => 'Loading places';

  @override
  String get discoverySearchThisArea => 'Search this area';

  @override
  String get discoveryShowMyLocation => 'Show my location';

  @override
  String get discoverySortTitle => 'Sort places';

  @override
  String get discoverySortBest => 'Best';

  @override
  String get discoverySortTopRated => 'Top rated';

  @override
  String get discoverySortMostReviewed => 'Most reviewed';

  @override
  String get discoverySortHiddenGems => 'Hidden gems';

  @override
  String get discoverySortWorstRated => 'Worst rated';

  @override
  String get discoverySortRecent => 'Recently discovered';

  @override
  String get discoveryExplainBest =>
      'Rating weighted by how many people rated it';

  @override
  String get discoveryExplainTopRated =>
      'Highest rating first, any review count';

  @override
  String discoveryExplainTopRatedMinimum(String count) {
    return 'Highest rating first, with at least $count reviews';
  }

  @override
  String get discoveryExplainMostReviewed => 'The busiest places in this view';

  @override
  String discoveryExplainHiddenGems(String rating, String reviews) {
    return '$rating+ on fewer than $reviews reviews';
  }

  @override
  String get discoveryExplainWorstRated =>
      'Lowest rating first — useful for ruling out';

  @override
  String discoveryExplainWorstRatedMinimum(String count) {
    return 'Lowest rating first, with at least $count reviews — useful for ruling out';
  }

  @override
  String get discoveryExplainRecent => 'Newest to our catalog';

  @override
  String discoveryTagHiddenGem(String count) {
    return '💎 Hidden gem · only $count reviews';
  }

  @override
  String get discoveryTagHiddenGemPlain => '💎 Hidden gem';

  @override
  String discoveryTagAdded(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '🆕 Added $daysString days ago',
      one: '🆕 Added yesterday',
      zero: '🆕 Added today',
    );
    return '$_temp0';
  }

  @override
  String discoveryTagRatedBelow(String rating) {
    return '⚠️ Rated below $rating';
  }

  @override
  String discoveryTagManyReviews(String count) {
    return '🔥 $count reviews';
  }

  @override
  String discoveryReviewsCompact(String count) {
    return '$count reviews';
  }

  @override
  String get discoveryNoRating => 'No rating';

  @override
  String discoveryDistanceAway(String distance) {
    return '$distance away';
  }

  @override
  String get discoveryStraightLineNote =>
      'Distances are in a straight line from your location.';

  @override
  String discoveryCountedAt(String time) {
    return 'Counted at $time';
  }

  @override
  String get discoveryFullList => 'Full list';

  @override
  String get discoveryShowMap => 'Show map';

  @override
  String get discoveryRefresh => 'Refresh results';

  @override
  String get discoveryEmptyFiltered =>
      'No places in this view match your filters.';

  @override
  String get discoveryClearFilters => 'Clear filters';

  @override
  String get discoveryEmptyUnexplored => 'We haven’t explored this area yet.';

  @override
  String get discoveryEmptyUnexploredHint =>
      'Places will show up here once we have. Try a nearby area in the meantime.';

  @override
  String discoveryEmptySort(String sort) {
    return 'No places in this view qualify for $sort.';
  }

  @override
  String get discoveryShowBest => 'Show Best instead';

  @override
  String get discoveryLoadFailed =>
      'Couldn’t load places. Check your connection and try again.';

  @override
  String discoveryRateLimited(int seconds) {
    final intl.NumberFormat secondsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String secondsString = secondsNumberFormat.format(seconds);

    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Too many searches. Try again in $secondsString seconds.',
      one: 'Too many searches. Try again in 1 second.',
    );
    return '$_temp0';
  }

  @override
  String get discoveryRateLimitedShort =>
      'Too many searches right now. Try again shortly.';

  @override
  String get discoveryInvalidArea =>
      'This area can’t be searched. Zoom in and search again.';

  @override
  String get discoveryUnsupportedArea =>
      'Got time covers the Gulf countries only. Move the map there and search again.';

  @override
  String get discoveryBadQuery =>
      'Part of this search can’t be used. Clear the filters and try again.';

  @override
  String get discoveryShowingPrevious => 'Showing the previous results.';

  @override
  String get discoveryMoreFailed => 'Couldn’t load more places.';

  @override
  String get discoveryResultsChanged =>
      'Results changed, so the list started over.';

  @override
  String get discoveryLinkPartlyApplied =>
      'Part of this link couldn’t be used, so it was left out.';

  @override
  String get discoveryFilters => 'Filters';

  @override
  String get discoveryFiltersTitle => 'Advanced filters';

  @override
  String get discoveryFiltersReset => 'Reset';

  @override
  String get discoveryFilterText => 'Search names and descriptions';

  @override
  String get discoveryFilterTextHint => 'For example, rooftop or kunafa';

  @override
  String get discoveryFilterReviews => 'Number of reviews';

  @override
  String discoveryReviewBandRange(String from, String to) {
    return '$from–$to';
  }

  @override
  String discoveryReviewBandOpen(String from) {
    return '$from+';
  }

  @override
  String discoveryReviewBandSemantics(int count, String band) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$band reviews, $countString places',
      one: '$band reviews, 1 place',
      zero: '$band reviews, no places',
    );
    return '$_temp0';
  }

  @override
  String get discoveryFilterPrice => 'Price';

  @override
  String discoveryPriceLevelName(String level) {
    return 'Price level $level';
  }

  @override
  String get discoveryAny => 'Any';

  @override
  String get discoveryFilterRating => 'Minimum rating';

  @override
  String discoveryRatingAtLeast(String rating) {
    return '$rating+';
  }

  @override
  String get discoveryFilterHours => 'Opening hours';

  @override
  String get discoveryHoursOpenNow => 'Open now';

  @override
  String get discoveryHoursOpenLate => 'Open late (after 23:00)';

  @override
  String get discoveryHoursBreakfast => 'Open for breakfast';

  @override
  String get discoveryHoursFriday => 'Open Friday';

  @override
  String get discoveryFilterCompleteness => 'Details on file';

  @override
  String get discoveryHasPhotos => 'Has photos';

  @override
  String get discoveryHasHours => 'Has opening hours';

  @override
  String get discoveryHasContact => 'Has contact details';

  @override
  String get discoveryHasPrice => 'Has a price level';

  @override
  String get discoveryFilterAmenities => 'Amenities';

  @override
  String get discoveryAmenityOutdoorSeating => 'Outdoor seating';

  @override
  String get discoveryAmenityWifi => 'Wi-Fi';

  @override
  String get discoveryAmenityFamilySection => 'Family section';

  @override
  String get discoveryAmenityReservations => 'Takes reservations';

  @override
  String get discoveryAmenityParking => 'Parking';

  @override
  String get discoveryAmenitiesUnavailable =>
      'Amenity filters are not available yet.';

  @override
  String discoveryTextQuery(String text) {
    return '“$text”';
  }

  @override
  String discoveryFiltersInPlay(String filters) {
    return 'Filters: $filters';
  }

  @override
  String get discoveryFiltersClear => 'Clear';

  @override
  String discoveryShowPlaces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Show $countString places',
      one: 'Show 1 place',
      zero: 'No places match',
    );
    return '$_temp0';
  }

  @override
  String discoveryShowAllPlaces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Show all $countString places',
      one: 'Show 1 place',
      zero: 'No places in view',
    );
    return '$_temp0';
  }

  @override
  String get discoveryShowResults => 'Show results';

  @override
  String get discoveryCountingPlaces => 'Counting places';

  @override
  String get discoveryPreviewFailed => 'Couldn’t count the places that match.';

  @override
  String get discoveryCategories => 'Categories';

  @override
  String get discoveryCategorySearch => 'Find a category';

  @override
  String get discoveryCollapseAll => 'Collapse all';

  @override
  String discoveryCategoriesHidden(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString categories have nothing in view and are hidden.',
      one: '1 category has nothing in view and is hidden.',
      zero: 'No categories are hidden.',
    );
    return '$_temp0';
  }

  @override
  String get discoveryCategoriesHiddenHint =>
      'Changing the area or clearing filters can bring them back.';

  @override
  String get discoveryCategoryOther => 'Other';

  @override
  String get discoveryCategoryFallback => 'Category';

  @override
  String discoveryCategoryNoMatch(String text) {
    return 'No categories in view match “$text”.';
  }

  @override
  String get discoveryCategoriesNone => 'Nothing in view has a category yet.';

  @override
  String get discoveryCategoriesFailed => 'Couldn’t load the categories.';

  @override
  String get discoveryCategoriesRemoved =>
      'Some categories in this link no longer exist, so they were removed.';

  @override
  String discoveryRemoveCategory(String category) {
    return 'Remove $category';
  }

  @override
  String get discoveryZoomInForPlaces => 'Zoom in to see places';

  @override
  String get discoverySelectionGone =>
      'The place you selected isn’t in these results anymore.';

  @override
  String get discoveryPreviewTitle => 'Selected on the map';

  @override
  String get discoveryPlaceLoadFailed => 'Couldn’t load this place.';

  @override
  String get discoveryLoadingPlace => 'Loading this place…';

  @override
  String discoveryPreviewRank(String ordinal, String total) {
    return 'Number $ordinal of $total in this view';
  }

  @override
  String get discoveryClearSelection => 'Clear selection';

  @override
  String get discoveryCoverageUnexplored => 'Not explored yet';

  @override
  String discoveryCoverageKnown(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString places known here from earlier searches',
      one: '1 place known here from earlier searches',
      zero: 'Nothing known here yet',
    );
    return '$_temp0';
  }

  @override
  String get discoveryCoveragePartial => 'Partly explored';

  @override
  String get discoveryCoveragePartialDetail =>
      'Only part of this view has been explored.';

  @override
  String get discoveryCoverageExplored => 'Explored';

  @override
  String get discoveryCoverageExploredDetail =>
      'All of this view has been explored. There may still be places we haven’t found.';

  @override
  String discoveryCoverageLastExplored(String when) {
    return 'Last explored $when';
  }

  @override
  String get discoveryCoverageExploring => 'Exploring this area…';

  @override
  String discoveryCoverageProgress(int completed, int total) {
    final intl.NumberFormat completedNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String completedString = completedNumberFormat.format(completed);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$completedString of $totalString searches done',
      one: '$completedString of 1 search done',
    );
    return '$_temp0';
  }

  @override
  String get discoveryCoverageStarting => 'Starting…';

  @override
  String get discoveryCoverageUnfinished =>
      'The last exploration didn’t finish.';

  @override
  String discoveryCoverageRetryAt(String time) {
    return 'You can try again at $time.';
  }

  @override
  String get discoveryDeepen => 'Deepen this area';

  @override
  String get discoveryDeepenFailed => 'Couldn’t start exploring this area.';

  @override
  String get discoveryEmptyExploring =>
      'We’re exploring this area now. Places will show up here as we find them.';

  @override
  String get discoveryExplorationUpdated =>
      'Results updated with newly explored places.';

  @override
  String get discoveryShareSearch => 'Share this search';

  @override
  String discoveryShareMessage(String link) {
    return 'Places on Hayer: $link';
  }

  @override
  String get discoveryStandingLoading =>
      'Comparing this place with the others…';

  @override
  String get discoveryStandingFailed =>
      'Couldn’t compare this place with the others.';

  @override
  String get discoveryStandingChanged =>
      'These results changed after they loaded. Close this to see the new ones.';

  @override
  String get discoveryStandingIneligible =>
      'This place no longer matches this search.';

  @override
  String discoveryStandingRank(String ordinal) {
    return '#$ordinal';
  }

  @override
  String discoveryStandingOfPlaces(int total) {
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'of $totalString places',
      one: 'of 1 place',
    );
    return '$_temp0';
  }

  @override
  String discoveryStandingOfCategory(int total, String category) {
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'of $totalString in $category',
      one: 'of 1 in $category',
    );
    return '$_temp0';
  }

  @override
  String discoveryStandingSortedBy(String sort) {
    return 'Sorted by $sort';
  }

  @override
  String get discoveryStandingHeading => 'Where it sits in this view';

  @override
  String discoveryPercentilePlaces(String percent) {
    return 'Rated higher than $percent of the other places in view';
  }

  @override
  String discoveryPercentileCategory(String percent, String category) {
    return 'Rated higher than $percent of $category in view';
  }

  @override
  String get discoveryPercentileNonePlaces =>
      'No other place in view is rated lower';

  @override
  String discoveryPercentileNoneCategory(String category) {
    return 'Nothing else in $category in view is rated lower';
  }

  @override
  String discoveryStraightLineDistance(String distance) {
    return '$distance away in a straight line';
  }

  @override
  String discoveryPhotoCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString photos',
      one: '1 photo',
    );
    return '$_temp0';
  }

  @override
  String discoveryAddedToHayer(String month) {
    return 'Added to Hayer in $month';
  }

  @override
  String get reportUnavailable =>
      'Reporting isn’t available right now. Please try again later.';

  @override
  String get reportPlaceGone =>
      'This place is no longer listed, so it can’t be reported.';
}
