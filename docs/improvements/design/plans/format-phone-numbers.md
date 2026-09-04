# Fix: Place phone numbers appear as an unreadable digit run

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/format-phone-numbers
- **Needs new dependency**: `phone_numbers_parser` because results may contain numbers from multiple GCC countries

## Why

Place details currently show the provider's raw phone string. Country-aware grouping makes Saudi and other GCC numbers easier to verify while preserving a normalized dial target.

## Where

```dart
// app/lib/features/results/results_screen.dart:648 — current
if (place.phoneNumber != null)
  OutlinedButton.icon(
    onPressed: () => launchUrl(
      Uri(scheme: 'tel', path: place.phoneNumber),
    ),
    icon: const Icon(Icons.call_outlined),
    label: Text(place.phoneNumber!),
  ),
```

## The fix

Create `app/lib/core/phone_display.dart`. Map `SA`, `AE`, `BH`, `KW`, `OM`, and `QA` to the package's `IsoCode`; strip non-digits for national input, use `PhoneNumberFormatter.formatNsn(digits, isoCode)` for the visible grouped number, and retain a leading `+` international form when the source already supplies it. On parse failure, return the trimmed original only if it passes the shared usable-string guard.

Expose a record:

```dart
({String display, String dial}) formatPhoneNumber(
  String raw,
  String? countryCode,
)
```

Use `display` in the label and `dial` in the `tel:` URI. The details sheet already receives `countryCode`.

## Steps

1. Add `phone_numbers_parser` and the GCC-aware helper.
2. Replace the raw label and tel URI with one computed formatted record.
3. Add unit tests for local/international Saudi, UAE, Bahrain, Kuwait, Oman, Qatar, whitespace, punctuation, and malformed input.

## Check it

`dart analyze` exits clean. `grep -c "Text(place.phoneNumber!)" app/lib/features/results/results_screen.dart` → 0. Phone helper tests pass.

## Don't touch

- Do not alter provider snapshots or persist formatted phone values.
- Do not use one fixed Saudi mask for all GCC countries.
- Do not change website or directions links.

## STOP if

- The installed parser API cannot produce stable display and dial forms.
- Session country code is unavailable in the details sheet.
- A check fails twice.

## When you're done

Tell the developer that GCC place phone numbers are now grouped for reading while taps use a dial-safe value. Open a Saudi and UAE place to demonstrate both.
