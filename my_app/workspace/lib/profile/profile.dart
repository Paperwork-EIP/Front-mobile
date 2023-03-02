import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/global.dart' as globals;

import 'package:my_app/home/view/home_page.dart';

class ModifyProfile {
  final String message;

  const ModifyProfile({required this.message});

  factory ModifyProfile.fromJson(Map<String, dynamic> json) {
    return ModifyProfile(
      message: json['message'],
    );
  }
}


Future<ModifyProfile> setModifyUser({
  required String email,
  required String newEmail,
  required String newUsername,
  required String newPassword,
  required profilePicture,
}) async {
  try {
    print(newEmail);
    if (newEmail == "") {
      newEmail = globals.email;
    } else {
      globals.email = newEmail;
    }
    if (newUsername == "") {
      newUsername = globals.username;
    }
    if (newPassword == "") {
      newPassword = globals.password;

    } else {

      globals.password = newPassword;
    }
    if (profilePicture == "") {
      profilePicture = globals.globalUserPicture;
    } else {
      globals.globalUserPicture = profilePicture;
    }
    var response = await http.get(
      Uri.parse(
          "${dotenv.get('SERVER_URL')}/user//modifyDatas?email=$email&username=$newUsername&new_email=$newEmail&password=$newPassword&profile_picture=$profilePicture"),

      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      return ModifyProfile.fromJson(jsonDecode(response.body));
    }
    return ModifyProfile.fromJson(
        {'message': 'Error : Failed to load process', 'response': null});
  } catch (error) {
    throw Exception('Failed to load Process');
  }
}

class Profile extends StatelessWidget {
  // late String profilePicture;
  final _controllerPicture = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Drawer(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Row(children: const <Widget>[
            SizedBox(
                height: 150.0,
                child: 
            BackButton(
              color: Color.fromRGBO(252, 105, 118, 1),
            ))
          ]),
          Column(children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                width: 325,
                height: 200,
                child:
                    // FutureBuilder<UserPicture>(
                    //     future: getUserPicture(email: globals.email),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData) {
                    //         // globals.globalUserPicture = snapshot.data!.picture;
                    //         return
                    ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Insert the link of your new picture'),
                      content: SizedBox(
                        // width: width,
                        // height: height,
                        child: TextField(
                          controller: _controllerPicture,
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Your link',
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            _controllerPicture.clear();
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            globals.tentativeLink = _controllerPicture.text;
                            // profilePicture = globals.tentativeLink;
                            // print(_controllerPicture.text);
                            Navigator.pop(context, 'Submit');
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: Material(
                      color: Colors.white,
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
                              image: NetworkImage(globals.globalUserPicture),
                              // image: NetworkImage(snapshot.data!.picture),
                              // const AssetImage('assets/makima.png'),

                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ))),
                )
                // } else {
                //   return
                //   // ElevatedButton(
                //   //   onPressed: () {},
                //   //   child:
                //     Material(
                //         color: Colors.white,
                //         elevation: 8,
                //         shape: const CircleBorder(),
                //         // borderRadius: BorderRadius.circular(1000),
                //         clipBehavior: Clip.antiAliasWithSaveLayer,
                //         child: InkWell(
                //             splashColor: Colors.black26,
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 color: Colors.transparent,
                //                 border: Border.all(
                //                     color: Colors.white, width: 3),
                //                 shape: BoxShape.circle,
                //               ),
                //               child: Ink.image(
                //                 image: const AssetImage('assets/makima.png'),
                //                 height: 75,
                //                 width: 75,
                //                 fit: BoxFit.cover,
                //               ),
                //             )));
                // );
                // }
                ),
            MyForm(),
          ])
        ])));
  }
}

class MyForm extends StatefulWidget {

  @override
  MyFormState createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _username = globals.username;
  final _email = globals.email;
  final _changePassword = "change password";

  final _controllerUsername = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          // width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _controllerUsername,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: _username,
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: _email,
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _controllerPassword,
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: _changePassword,
                  labelText: 'Change Password',
                ),
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     icon: const Icon(Icons.password_outlined),
              //     // hintText: _changePassword,
              //     labelText: 'Confirm Password',
              //   ),
              // ),
              
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Your Modifications has been send'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Ok');
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                  setModifyUser(
                      email: globals.email,
                      newEmail: _controllerEmail.text,
                      newUsername: _controllerUsername.text,
                      newPassword: _controllerPassword.text,
                      profilePicture: globals.tentativeLink,
                    );
                  _controllerEmail.clear();
                  _controllerUsername.clear();
                  _controllerPassword.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF29C9B3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(color: Color(0xFF29C9B3))),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                //   TextButton(
                //   style: TextButton.styleFrom(
                //       backgroundColor: const Color(0xFF29C9B3),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(25.0),
                //           side: const BorderSide(color: Color(0xFF29C9B3)))),
                //   onPressed: () {
                //     // print(_controllerEmail.text);
                //     // print(_controllerPassword.text);
                //     // print(_controllerUsername.text);
                //     setModifyUser(
                //       email: globals.email,
                //       newEmail: _controllerEmail.text,
                //       newUsername: _controllerUsername.text,
                //       newPassword: _controllerPassword.text,
                //       profilePicture: globals.tentativeLink,
                //     );
                //   },
                //   child: const Text(
                //     'Submit',
                //     style: TextStyle(fontSize: 18, color: Colors.white),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                )
                
              ]),
            ],
          ),
        ));
  }
}
