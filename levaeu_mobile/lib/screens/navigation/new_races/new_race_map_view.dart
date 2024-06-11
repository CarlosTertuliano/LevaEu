library new_race_map;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'new_race_map.dart';

class NewRaceMapScreen extends StatelessWidget{
  const NewRaceMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewRaceMapView();
  }
}

class NewRaceMapView extends StatelessWidget{
  const NewRaceMapView({super.key});

  @override 
  Widget build(BuildContext context) {

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

      body: const Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _NewRaceMap(target: LatLng(-5.832325279595681, -35.205239253973794)),
        ],
      ),

    );
  }
}