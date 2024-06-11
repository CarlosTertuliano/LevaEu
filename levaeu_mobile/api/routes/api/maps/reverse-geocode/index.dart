import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:maps_client/maps_client.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  return _get(context);
}

Future<Response> _get(RequestContext context) async {
  final mapsClient = context.read<GoogleMapsClient>();
  try {
    final data = context.request.uri.queryParameters;
    final lat = data['latitude'];
    final long = data['longitude'];

    if (lat == null || long == null) {
      return Response.json(
        body: {'error: Latitude e longitude são requeridas'},
        statusCode: HttpStatus.badRequest,
      );
    }

    final response = await mapsClient.latLonToAddress(
      latitude: double.parse(lat),
      longitude: double.parse(long),
    );

    return Response.json(body: {'address': response.toJson()});

  } catch (e) {
    return Response.json(
      body: {'Error: Falha ao obter endereço ${e.toString()}'},
      statusCode: HttpStatus.badRequest,
    );
  }

  
}