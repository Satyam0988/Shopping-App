import 'package:flutter/material.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.yellow[50],
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: double.infinity,
                    decoration: customBoxDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: 42.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[50],
                            //fontFamily:
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.yellow[50],
                            //fontFamily:
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                              //fontFamily: ,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade900,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.75,
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val!.isEmpty ? "Please enter an email" : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                              //fontFamily: ,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade900,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.75,
                                ),
                              ),
                            ),
                            validator: (val) => val!.length < 8
                                ? "Password should be longer than 8 characters"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  error =
                                      "Could not sign in with those credentials";
                                  loading = false;
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 0.0, 15.0, 0.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 50.0,
                                  width: 150.0,
                                  decoration: customBoxDecoration.copyWith(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.yellow[50],
                                          //fontfamily: ,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(fontSize: 18.0, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 55.0,
                          width: 150.0,
                          decoration: customBoxDecoration.copyWith(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.yellow[50],
                                  //fontfamily: ,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
