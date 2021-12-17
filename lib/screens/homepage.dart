import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:bilmekaniker_semesterprojekt/Indrapportering/Indrapportering.dart';

class Album {
  final String? registration_number;
  final String? status;
  final String? type;
  final String? use;
  final String? first_registration;
  final String? vin;
  final int? doors;
  final String? make;
  final String? model;
  final String? variant;
  final String? model_type;
  final String? color;
  final String? chasis_type;
  final double? engine_power;
  final String? fuel_type;
  final String? RegistreringssynToldsyn;
  final String? date;
  final String? result;

  Album({
    this.registration_number,
    this.status,
    this.type,
    this.use,
    this.first_registration,
    this.vin,
    this.doors,
    this.make,
    this.model,
    this.variant,
    this.model_type,
    this.color,
    this.chasis_type,
    this.engine_power,
    this.fuel_type,
    this.RegistreringssynToldsyn,
    this.date,
    this.result,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      registration_number: json['registration_number'],
      status: json['status'],
      type: json['type'],
      use: json['use'],
      first_registration: json['first_registration'],
      vin: json['vin'],
      doors: json['doors'],
      make: json['make'],
      model: json['model'],
      variant: json['variant'],
      model_type: json['model_type'],
      color: json['color'],
      chasis_type: json['chasis_type'],
      //engine_power: json['engine_power'],
      fuel_type: json['fuel_type'],
      RegistreringssynToldsyn: json['RegistreringssynToldsyn'],
      date: json['date'],
      result: json['result'],
    );
  }
}


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<Album>? futureAlbum;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RaisedButton(child:
                Text('Indrapporteringer'),
                  color: Colors.green,
                  shape: StadiumBorder(),
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Indrapporter()));
              }
              ),
             
              ElevatedButton(
                 onPressed: () async {
                 await FirebaseAuth.instance.signOut();
                 },
                 child: Text("Log ud", style: TextStyle(color: Colors.white),),
                 style: ElevatedButton.styleFrom(
                 primary: Colors.green,
                   shape: StadiumBorder(),
                 ),
              ),

                TextField(
                onSubmitted: (str) async {
                  setState(() {
                    query = str;
                  });
                },
              ),


              Center(
                child: FutureBuilder<Album?>(
                  future: fetchAlbum(query),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Registreringsnummer: "
                              "${snapshot.data!.registration_number}"),
                          Text("Status: " "${snapshot.data!.status}"),
                          Text("Type: " "${snapshot.data!.type}"),
                          Text("Brug: " "${snapshot.data!.use}"),
                          Text("Første registrerings dato: "
                              "${snapshot.data!.first_registration}"),
                          Text("Vin nummer: " "${snapshot.data!.vin}"),
                          Text("Mærke: " "${snapshot.data!.make}"),
                          Text("Model: " "${snapshot.data!.model}"),
                          Text("Variant: " "${snapshot.data!.variant}"),
                          Text("Model type: " "${snapshot.data!.model_type}"),
                          Text("Farve: " "${snapshot.data!.color}"),
                          Text("Bil type: " "${snapshot.data!.chasis_type}"),
                          Text("Brændstof: " "${snapshot.data!.fuel_type}"),
                          Text("Sidste syn: " "${snapshot.data!.date}"),
                        ],
                      );

                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData == false) {
                      return const Text('Indtast Nummerplade');
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      );
  }


  Future<Album?> fetchAlbum(String query) async {
    if (query.isEmpty) return null;
    final endpoint = 'https://v1.motorapi.dk/vehicles/$query';
    final response = await http.get(Uri.parse(endpoint), headers: {
      "X-AUTH-TOKEN": "crt87d9c4jv19tlo3eh7uenxqoprwdpy",
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Recieved Data');
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
