import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:provider/provider.dart';

class CreateNewRace extends StatefulWidget{
  const CreateNewRace({super.key});

  @override
  _CreateNewRaceState createState() => _CreateNewRaceState();
}

class _CreateNewRaceState extends State<CreateNewRace>{

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
        child: Builder(builder: (context) {
          final local = context.watch<RaceController>();

          String mensagem = local.erro == ''
            ? 'Latitude ${local.lat} | Longitude ${local.long}'
            : local.erro;

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(local.lat, local.long),
              zoom: 15
            ),
            zoomControlsEnabled: true,
            mapType: MapType.terrain,
            myLocationEnabled: true,
            onMapCreated: local.onMapCreated,
          );

          },
        ),
      ),

    );
  }
}