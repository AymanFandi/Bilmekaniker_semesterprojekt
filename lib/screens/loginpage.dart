import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  late String _email;
  late String _password;

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Log Ind"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration: InputDecoration(
                  hintText: "Email..."
              ),
            ),
            TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              onChanged: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                  hintText: "Adgangskode..."
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _login,
                  child: Text("Log ind", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: StadiumBorder()
                  ),
                ),

                ElevatedButton(
                  onPressed: _createUser,
                  child: Text("Opret bruger", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    shape: StadiumBorder()
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
