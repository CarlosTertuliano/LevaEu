part of 'new_race_map_view.dart';

class _NewRaceMap extends StatefulWidget {
  const _NewRaceMap({required this.target});

  final LatLng target;

  @override
  State<_NewRaceMap> createState() => _NewRaceMapState();
}

class _NewRaceMapState extends State<_NewRaceMap>{
  
  late Completer<GoogleMapController> _controller;

  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.target,
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}