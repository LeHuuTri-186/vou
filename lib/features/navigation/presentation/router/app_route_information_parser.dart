import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    return uri.pathSegments.isEmpty ? 'signin' : uri.path;
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    return RouteInformation(uri: Uri.parse(configuration));
  }
}
