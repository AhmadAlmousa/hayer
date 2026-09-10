import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// The widest source photo this bound has to keep covered.
///
/// The extractor rewrites every kept photo URL to `=w1600` and does not pin a
/// height, so the shape of the bitmap that arrives is whatever the venue
/// uploaded. 16:9 is the widest common photograph; assuming it keeps the bound
/// safe for anything narrower, which is every other ordinary aspect ratio.
const double _widestSourcePhotoAspect = 16 / 9;

/// The decode width for a place photo drawn with [BoxFit.cover] in a
/// [boxWidth] x [boxHeight] logical box, or null when the box has no finite
/// size to measure against.
///
/// Photos arrive at 1600 logical pixels wide, so a card showing one as a 48 px
/// thumbnail still decodes roughly 1600x1067 — about 6.8 MB of bitmap that
/// Flutter's image cache then holds long after the card is gone. Passing the
/// result as `memCacheWidth` decodes the photo at the size it is actually
/// drawn; [ResizeImage] clamps to the source's own width, so a box larger than
/// the photo leaves it untouched rather than upscaling it.
///
/// Only the width is bounded, deliberately. [ResizeImage] defaults to
/// [ResizeImagePolicy.exact], which resizes to exactly the width *and* height
/// it is given and ignores the source's aspect ratio, so supplying both
/// squashes every photo that is not already the shape of its box.
///
/// A width alone leaves the height to the source's aspect ratio, which is
/// unknown here, so the bound has to be wide enough that the resulting height
/// still covers the box: a 48x48 box needs a photo about 85 px wide before its
/// height reaches 48. Hence [_widestSourcePhotoAspect] rather than [boxWidth]
/// on its own.
int? placePhotoDecodeWidth(
  BuildContext context, {
  required double boxWidth,
  required double boxHeight,
}) {
  if (!boxWidth.isFinite || !boxHeight.isFinite) return null;
  if (boxWidth <= 0 || boxHeight <= 0) return null;
  final covering = math.max(boxWidth, boxHeight * _widestSourcePhotoAspect);
  return (covering * MediaQuery.devicePixelRatioOf(context)).ceil();
}
