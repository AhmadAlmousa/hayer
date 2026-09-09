# Hayer generated client

Shared Serverpod protocol and endpoint client consumed by the Flutter consumer
and admin applications. Do not hand-edit files under `lib/src/protocol`; change
the server endpoint or `.spy.yaml` model and run `serverpod generate` instead.

The build-7 contract adds optional `SessionBundle.destinationChoices` and the
`hayerSession.chooseDestination` RPC. Consumers must tolerate a null choice
state from older compatible servers and must send the latest
`myRevision` when changing a ballot. `CreateSessionRequest` also accepts an
optional ordered `shortlistPlaceIds` list and a zero-or-five
`freshDiscoveryCount`; clients must deploy the supporting server first and
verify that the returned deck preserves the saved prefix.
