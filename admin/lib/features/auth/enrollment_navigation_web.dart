import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

void openEnrollment(BuildContext _) {
  // A top-level navigation lets nginx perform Basic Auth before the enrollment
  // shell loads. The browser then reuses that realm only for enroll-api calls.
  web.window.location.assign('/admin/enroll');
}
