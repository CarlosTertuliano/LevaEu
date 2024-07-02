import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:levaeu_mobile/api/directions_service.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';

class RouteMapScreen extends StatefulWidget {
  final Race race;
  final List<LatLng> waypoints;

  const RouteMapScreen({Key? key, required this.race, required this.waypoints}) : super(key: key);

  @override
  _RouteMapScreenState createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  late GoogleMapController _mapController;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndDrawRoute();
  }

  Future<void> _fetchAndDrawRoute() async {
    final directionsService = DirectionsService(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!);
    final origin = LatLng(widget.race.saidaLat, widget.race.saidaLng);
    final destination = LatLng(widget.race.destinoLat, widget.race.destinoLng);

    try {
      final directions = await directionsService.fetchDirections(
        '${origin.latitude},${origin.longitude}',
        '${destination.latitude},${destination.longitude}',
        widget.waypoints.map((point) => '${point.latitude},${point.longitude}').toList(),
      );

      _drawPolyline(directions['routes'][0]['overview_polyline']['points']);

      setState(() {
        _markers.add(Marker(
          markerId: const MarkerId('origin'),
          position: origin,
          infoWindow: InfoWindow(title: widget.race.saidaName),
        ));

        _markers.add(Marker(
          markerId: const MarkerId('destination'),
          position: destination,
          infoWindow: InfoWindow(title: widget.race.destinoName),
        ));

        for (int i = 0; i < widget.waypoints.length; i++) {
          _markers.add(Marker(
            markerId: MarkerId('waypoint_$i'),
            position: widget.waypoints[i],
            infoWindow: InfoWindow(title: 'Waypoint ${i + 1}'),
          ));
        }

        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load directions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _drawPolyline(String encodedPolyline) {
    final polylinePoints = PolylinePoints();
    final List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);

    if (result.isNotEmpty) {
      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          points: result.map((point) => LatLng(point.latitude, point.longitude)).toList(),
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rota Final'),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.race.saidaLat, widget.race.saidaLng),
                zoom: 12,
              ),
              markers: _markers,
              polylines: _polylines,
            ),
    );
  }
}
