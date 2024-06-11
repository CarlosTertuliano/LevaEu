import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maps_client/maps_client.dart';

late GoogleMapsClient mapsClient;

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  final apiKey = dotenv.env['ANDROID_MAPS_APIKEY']!;
  mapsClient = GoogleMapsClient(
    apiKey: apiKey,
  );
  return serve(handler, ip, port);
}
