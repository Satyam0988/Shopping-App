import 'package:flutter/material.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/loading.dart';

class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                            color: Colors.white,
                            //fontFamily:
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Register to continue",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
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
                            decoration: textInputDecoration,
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
                            decoration: textInputDecoration,
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
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  error =
                                      "Could not register with those credentials";
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
                                      "REGISTER",
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
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
                    "Already have an account?",
                    style: TextStyle(
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
                              "SIGN IN",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
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
