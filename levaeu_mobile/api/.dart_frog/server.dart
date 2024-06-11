// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../main.dart' as entrypoint;
import '../routes/api/maps/routes/index.dart' as api_maps_routes_index;
import '../routes/api/maps/reverse-geocode/index.dart' as api_maps_reverse_geocode_index;
import '../routes/api/maps/places/index.dart' as api_maps_places_index;
import '../routes/api/maps/autocomplete/index.dart' as api_maps_autocomplete_index;

import '../routes/api/maps/_middleware.dart' as api_maps_middleware;

void main() async {
  final address = InternetAddress.tryParse('') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return entrypoint.run(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/api/maps/autocomplete', (context) => buildApiMapsAutocompleteHandler()(context))
    ..mount('/api/maps/places', (context) => buildApiMapsPlacesHandler()(context))
    ..mount('/api/maps/reverse-geocode', (context) => buildApiMapsReverseGeocodeHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildApiMapsAutocompleteHandler() {
  final pipeline = const Pipeline().addMiddleware(api_maps_middleware.middleware);
  final router = Router()
    ..all('/', (context) => api_maps_autocomplete_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiMapsPlacesHandler() {
  final pipeline = const Pipeline().addMiddleware(api_maps_middleware.middleware);
  final router = Router()
    ..all('/', (context) => api_maps_places_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiMapsReverseGeocodeHandler() {
  final pipeline = const Pipeline().addMiddleware(api_maps_middleware.middleware);
  final router = Router()
    ..all('/', (context) => api_maps_reverse_geocode_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline().addMiddleware(api_maps_middleware.middleware);
  final router = Router()
    ..all('/api/maps/routes', (context) => api_maps_routes_index.onRequest(context,));
  return pipeline.addHandler(router);
}

