// ignore_for_file: empty_catches

import 'package:url_launcher/url_launcher.dart';

Future<bool> launchUrlWrapped(Uri url) async {
  try {
    if (await _launchUrlMain(url)) return true;
    if (await _launchUrlNoChecks(url)) return true;
    if (await _launchUrlForceExternal(url)) return true;
  } catch (e) {}
  return false;
}

Future<bool> _launchUrlMain(Uri url) async {
  try {
    if (await canLaunchUrl(url)) {
      return await launchUrl(url);
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> _launchUrlNoChecks(Uri url) async {
  try {
    return await launchUrl(url);
  } catch (e) {
    return false;
  }
}

Future<bool> _launchUrlForceExternal(Uri url) async {
  try {
    return await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    return false;
  }
}
