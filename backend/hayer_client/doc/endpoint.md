# Callable endpoints

Each class contains callable methods that will call a method on the server side. These are normally defined in the `endpoint` directory in your server project. This client sends requests to these endpoints and returns the result.

Example usage:

```dart
// How to use GreetingEndpoint.
client.greeting.hello("world!");

// Generic format.
client.<endpoint>.<method>(...);
```

Please see the full official documentation [here](https://docs.serverpod.dev)

## Hayer session choices

`client.hayerSession.chooseDestination` records or changes the authenticated
participant's single destination ballot:

```dart
final bundle = await client.hayerSession.chooseDestination(
  sessionId: sessionId,
  placeId: placeId,
  expectedRevision: bundle.destinationChoices!.myRevision,
);
```

Use only place IDs in `eligiblePlaceIds`. A null `destinationChoices` means
the connected server does not expose the build-7 choice contract. On a
`choice_conflict`, reload the bundle before another change. The response does
not reveal other participants' identities or individual ballots.
