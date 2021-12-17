import 'package:bilmekaniker_semesterprojekt/screens/homepage.dart';
import 'package:bilmekaniker_semesterprojekt/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


    return  MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Georgia',
            textTheme: const TextTheme(
              headline6: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ),
          home: Landingpage(
          ),
        );
  }
}

class Landingpage extends StatelessWidget {

  final Future<FirebaseApp>_initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                Object? user = snapshot.data;

                if(user == null){
                  return Loginpage();
                } else {
                  return Homepage();
                }
              }

              return Scaffold(
                body: Center(
                  child: Text("Checking Authentication..."),
                ),
              );
            },
          );
        }

        return Scaffold(
          body: Center(
            child: Text("Connecting to the app..."),
          ),
        );

      },
    );
  }
}


