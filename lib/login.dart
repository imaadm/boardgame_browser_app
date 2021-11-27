import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
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
                        "Login",
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
                        margin: EdgeInsets.only(top: 20),
                        width: 250,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                18), /* side: BorderSide(color: Colors.blue)*/
                          ))),
                          child: Text("Login"),
                          onPressed: () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text)
                                .then((value) {
                              print("Login Success!");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            title: 'Personal',
                                          )));
                            }).catchError((error) {
                              print("Failed to login!");
                              print(error.toString());
                            });
                          },
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 60),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage(
                                          title: 'Register',
                                        )));
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
