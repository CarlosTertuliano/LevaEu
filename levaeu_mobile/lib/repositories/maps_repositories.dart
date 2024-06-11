
import 'package:api_client/api_client.dart';
import 'package:core/entities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsRepository {
  MapsRepository({required this.apiClient});

  final ApiClient apiClient;

  Future<Address?> fetchAddressFromUserCoordinates() async {
    LocationPermission? permission;
    try{
      permission = await Geolocator.checkPermission();

      if(permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final addressData = await apiClient.mapsResource.fetchAddressFromCoordinates(
        latitude: position.latitude.toString(), 
        longitude: position.longitude.toString(),
      );

      print(addressData);

    } catch(e) {
      throw Exception("Falha em obter coordenada do usuário: $e");
    }
  }

  Future<Address> fetchAddressFromCoordinates({
    required double lat,
    required double long,
  }) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      throw Exception("Falha ao obter endereço pela coordenada: $e");
    }
  }

  Future<List<AddressSuggestion>> fetchAddressSugestion({
    required String query,
    required double lat,
    required double long,
  }) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      throw Exception("Falha ao obter sugestão do endereço: $e");
    }
  }

  Future<List<LatLng>> fetchDirections({
    required String originId,
    required String destinationId,
  }) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      throw Exception("Falha ao obter endereço pelo ID da local: $e");
    }
  }
}