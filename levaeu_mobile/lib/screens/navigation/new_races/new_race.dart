import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/create_new_race.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/new_race_map_view.dart';
import 'package:provider/provider.dart';

class NewRace extends StatefulWidget{
  const NewRace({super.key});

  @override
  _NewRaceState createState() => _NewRaceState();
}

class _NewRaceState extends State<NewRace> {
  @override
  Widget build(BuildContext context) {
    final userMotorista = Provider.of<UserData>(context);
    final user1 = UserData(
      name: "Hermonie",
      email: "hermonie@gmail.com",
      phone: "99999999999",
      cep: "55555555",
      street: "Alguma",
      number: "10",
      district: "cidade ai",
      city: "cidade ai",
      state: "Algum",
      country: "dos bobos",
      gender: "Feminino",
    );

    final List<UserData> passageiros1 = [user1, user1, user1];
    final List<UserData> passageiros2 = [userMotorista, user1, user1];

    final pass2 = Race(
      saida: "Via Direta",
      destino: "Parnamirim",
      data: DateTime(2024, 6, 10),
      horario: const TimeOfDay(hour: 11, minute: 0),
      motorista: userMotorista,
      passageiros: passageiros1,
    );

    final pass1 = Race(
      saida: "IMD",
      destino: "Natal Shopping",
      data: DateTime(2024, 12, 25),
      horario: const TimeOfDay(hour: 15, minute: 30),
      motorista: user1,
      passageiros: passageiros2,
    );

    final List<Race> races = [pass1, pass2];

    return Stack(
      children: <Widget>[

        Column(
          children: <Widget> [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    Container(
                      constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
                      margin: const EdgeInsets.only(top: 15, left: 5, bottom: 10),
                      child: const Text(
                        "Solicite entrada em uma corrida!",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                              
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: races.length,
                      itemBuilder: (context, index) {
                        final race = races[index];

                        return Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),

                          child: Card(
                            color: const Color.fromRGBO(255, 255, 255, 1.0),
                            margin: const EdgeInsets.all(10.0),

                            child: ListTile(
                              leading: const Icon(Icons.person_outline_sharp),
                              trailing: const CircleAvatar(
                                backgroundColor: Color.fromRGBO(57, 96, 143, 1.0),
                                child: Icon(
                                  Icons.drive_eta_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text("${race.motorista.name}\n${race.saida} \u2192 ${race.destino}"),
                              subtitle: Text("Horário: ${race.horario.format(context)}")
                            ),

                          ),
                        );
                      },

                    ),
                  
                  ],
                ),
              ),
            ),
          ],
        ),

        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewRaceMapScreen()));
            },
            child: const Icon(
              Icons.add,
              color: Color.fromRGBO(57, 96, 143, 1.0),
            ),
          ),
        ),

      ],
    );
  }
}