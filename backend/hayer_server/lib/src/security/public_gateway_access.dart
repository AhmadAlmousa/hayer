import 'dart:io';

import 'package:serverpod/serverpod.dart';

abstract final class PublicGatewayAccess {
  static const clientIpHeader = 'x-hayer-client-ip';

  /// Resolves the client address the public gateway vouched for.
  ///
  /// Returns null unless exactly one syntactically valid address is present, so
  /// a smuggled second header cannot widen the budget.
  static String? resolveClientIp(Iterable<String>? values) {
    final value = _single(values)?.trim();
    if (value == null || value.isEmpty) return null;
    final parsed = InternetAddress.tryParse(value);
    if (parsed == null) return null;
    return _normalize(parsed.address);
  }

  /// The rate-limit subject for an unauthenticated request.
  ///
  /// A request that reaches the server without the gateway's vouched address is
  /// budgeted against its own socket rather than a shared key, so bypassing the
  /// gateway cannot spend the budget belonging to legitimate clients.
  static String rateLimitSubject(Session session) {
    final request = session.request;
    final trusted = resolveClientIp(request?.headers[clientIpHeader]);
    if (trusted != null) return 'ip:$trusted';
    final peer = request?.connectionInfo.remote.address;
    if (peer == null) return 'peer:unknown';
    return 'peer:${_normalize(peer.toString())}';
  }

  /// Collapses the IPv4-mapped IPv6 form so one client cannot hold two budgets.
  static String _normalize(String address) {
    const mappedPrefix = '::ffff:';
    if (!address.toLowerCase().startsWith(mappedPrefix)) return address;
    final tail = address.substring(mappedPrefix.length);
    final mapped = InternetAddress.tryParse(tail);
    if (mapped == null || mapped.type != InternetAddressType.IPv4) {
      return address;
    }
    return mapped.address;
  }

  static String? _single(Iterable<String>? values) {
    if (values == null) return null;
    final iterator = values.iterator;
    if (!iterator.moveNext()) return null;
    final value = iterator.current;
    if (iterator.moveNext()) return null;
    return value;
  }
}
