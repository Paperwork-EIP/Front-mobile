import 'package:flutter/material.dart';
import 'package:authentication_repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/login/login.dart';
import 'package:formz/formz.dart';
import 'package:formz/formz.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _controllerEmail = TextEditingController();
    // final _controllerPassword = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
          Row(children: const <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   tooltip: "Go Back",
            //   color: Color(0xFF29C9B3),
            //   onPressed: () {
                
            //   },
            // ),
            BackButton(color: Color(0xFF29C9B3),)
          ]),
          Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              width: 325,
              height: 200,
              child: Material(
                  color: Colors.blue,
                  elevation: 8,
                  shape: const CircleBorder(),
                  // borderRadius: BorderRadius.circular(1000),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                      splashColor: Colors.black26,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,
                        ),
                        child: Ink.image(
                          image: AssetImage('assets/makima.png'),
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ))),
            ),
            MyForm(),
          ])
        ]));
  }
}

class MyForm extends StatefulWidget {
  @override
  MyFormState createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final _username = 'Sandros';
  final _email = 'sandros@gmail.com';
  final _changePassword = "change password";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
      margin: const EdgeInsets.only(left: 20),
      width: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.person),
              hintText: _username,
              labelText: 'Username',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.email),
              hintText: _email,
              labelText: 'Email',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.password),
              hintText: _changePassword,
              labelText: 'Change Password',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.password_outlined),
              // hintText: _changePassword,
              labelText: 'Confirm Password',
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 380, top: 40.0),
              child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF29C9B3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                    color: Color(0xFF29C9B3)))),
                        onPressed: () {},
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
        ],
      ),
    ));
  }
}
