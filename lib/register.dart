import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.greenAccent.shade100,
            Colors.greenAccent.shade400
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 50,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 40, bottom: 15, top: 10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 40, bottom: 10, top: 10),
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password'),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 30, bottom: 70),
                        width: 250,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                18), /* side: BorderSide(color: Colors.blue)*/
                          ))),
                          child: Text("Register"),
                          onPressed: () {
                            Future result = FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text);
                            result.then((value) {
                              print("Sign-in success!");
                              Navigator.pop(context);
                            });
                            result.catchError((error) {
                              print(error.toString());
                              return AlertDialog(
                                  content: Text("Sign-in Failed!"));
                            });
                          },
                        )),
                    Container(
                      child: Image(
                        image: AssetImage('assets/calIcon.png'),
                        height: 250,
                        width: 250,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ])),
    );
  }
}
