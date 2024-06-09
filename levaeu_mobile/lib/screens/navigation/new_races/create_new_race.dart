import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:provider/provider.dart';

class CreateNewRace extends StatefulWidget{
  const CreateNewRace({super.key});

  @override
  _CreateNewRaceState createState() => _CreateNewRaceState();
}

class _CreateNewRaceState extends State<CreateNewRace>{
  TextEditingController _startLocationController = TextEditingController();
  TextEditingController _destinationLocationController = TextEditingController();

  //Controlador de acesso ao mapa
  Completer<GoogleMapController> _googleMapController = Completer();

  //Marcadores e polilinhas que serão exibidas no mapa
  Set<Marker> _marcadores = {};
  Set<Polyline> _polilinhas = {};

  //Cordenadas para a polilinhas
  List<LatLng> polylineCoordenadas = [];

  //Intância da dos pontos da polilinhas
  PolylinePoints polylinePoints = PolylinePoints();

  
  @override
  void initState(){
    super.initState();
  }

  Future<void> _calcularRota() async {
    String start = _startLocationController.text;
    String destination = _destinationLocationController.text;

    if(start.isEmpty || destination.isEmpty){
      return;
    }

    List<Location> startLocationResults = await locationFromAddress(start);
    List<Location> destinationResults = await locationFromAddress(destination);

    if (startLocationResults.isNotEmpty && destinationResults.isNotEmpty) {
      Location start = startLocationResults.first;
      Location destination = destinationResults.first;

      // Adicione marcadores para locais de origem e destino no mapa
      setState(() {
        _marcadores.clear();
        _marcadores.add(
          Marker(
            markerId: MarkerId('start'),
            position: LatLng(start.latitude, start.longitude),
            infoWindow: InfoWindow(title: 'Local de Saída'),
          ),
        );
        _marcadores.add(
          Marker(
            markerId: MarkerId('destination'),
            position: LatLng(destination.latitude, destination.longitude),
            infoWindow: InfoWindow(title: 'Destino'),
          ),
        );
      });
      

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        FlutterConfig.get('ANDROID_MAPS_APIKEY'), 
        PointLatLng(start.latitude, start.longitude), 
        PointLatLng(destination.latitude, destination.longitude),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordenadas.add(LatLng(point.latitude, point.longitude));
        });

        // Adicionar a polyline ao conjunto de polilinhas
        setState(() {
          _polilinhas.add(Polyline(
            polylineId: PolylineId('route1'),
            visible: true,
            width: 4,
            color: Colors.blue,
            points: polylineCoordenadas,
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Nova corrida",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: ChangeNotifierProvider<RaceController>(
        create: (context) => RaceController(),
        child: Builder(
          builder: (context) {
            final local = context.watch<RaceController>();

            String mensagem = local.erro == ''
              ? 'Latitude ${local.lat} | Longitude ${local.long}'
              : local.erro;

            return Stack(
              children: <Widget> [

                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(local.lat, local.long),
                    zoom: 2
                  ),
                  markers: _marcadores,
                  polylines: _polilinhas,
                  zoomControlsEnabled: true,
                  mapType: MapType.hybrid,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController.complete(controller);
                  },
                ),

                
                DraggableScrollableSheet(
                  initialChildSize: 0.3,
                  minChildSize: 0.2,
                  maxChildSize: 0.8,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: _startLocationController,
                              decoration: const InputDecoration(
                                hintText: 'Local de Saída',
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _destinationLocationController,
                              decoration: const InputDecoration(
                                hintText: 'Destino',
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                _calcularRota();
                              },
                              child: Text('Traçar Rota'),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }  

}
