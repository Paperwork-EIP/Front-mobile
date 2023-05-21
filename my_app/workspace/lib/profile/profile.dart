import 'package:flutter/material.dart';
import 'dart:core';
// import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/global.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';

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
  required String token,
  required String newEmail,
  required String newUsername,
  required String newPassword,
  required profilePicture,
  required String language,
}) async {
  try {
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
    var response = await http.post(
      Uri.parse(
          "${dotenv.get('SERVER_URL')}/user/modifyDatas"),

      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "token": token,
        "new_email": newEmail,
        "username": newUsername,
        "password": newPassword,
        "profile_picture": profilePicture,
        "language": language,
      }),
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

class UserProcess {
  final String message;
  final response;

  const UserProcess({required this.message, required this.response});

  factory UserProcess.fromJson(Map<String, dynamic> json) {
    return UserProcess(
      message: json['message'],
      response: json['response'],
    );
  }
}

Future<UserProcess> getUserProcess({
  required String token,
}) async {

  try {
    var response;
    response = await http.get(
      Uri.parse(
          "${dotenv.get('SERVER_URL')}/userProcess/getUserProcesses?user_token=$token"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    
    if (response.statusCode == 200) {
      print(response.body);
      return UserProcess.fromJson(jsonDecode(response.body));
    }
    return UserProcess.fromJson({
      'message': 'Failed to load Process',
      'response': '',
    });
  } catch (error) {

    throw Exception('Failed to load Process');
  }
}


// ignore: use_key_in_widget_constructors
class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

// ignore: use_key_in_widget_constructors
class ProfileState extends State<Profile> {

  imageDefault () {
    if (globals.tentativeLink == null) {
      return const AssetImage('assets/avatar/NoAvatar.png');
    } else {
      return NetworkImage(globals.tentativeLink);
    }
  }

  createAvatartButton(pathAvatar) {
    return Material(
          color: Colors.transparent,
          elevation: 8,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
              splashColor: Colors.blue,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle,
                ),
                child: Ink.image(
                  image: AssetImage(pathAvatar),
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              )),
    );
  }

  List<bool> _isSelected = [false, false, false, false, false, false, false, false];
  final List<String> _avatarPath = [
    "assets/avatar/Avatar01.png",
    "assets/avatar/Avatar02.png",
    "assets/avatar/Avatar03.png",
    "assets/avatar/Avatar04.png",
    "assets/avatar/Avatar05.png",
    "assets/avatar/Avatar06.png",
    "assets/avatar/Avatar07.png",
    "assets/avatar/Avatar08.png",
  ];
  @override
  Widget build(BuildContext context) {
    globals.tentativeLink = globals.globalUserPicture;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: const Color(0xFF29C9B3),
      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Image.asset(
            'assets/images/profil_background.png',
            fit: BoxFit.cover,
          ),
          Column(children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                width: 350,
                height: 100,
                child: ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Choose avatar'),
                      content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                    return Ink(
      height: 500, 
      color: Colors.white,
      child: GridView.count(
        primary: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2, 
        crossAxisSpacing: 8, 
        childAspectRatio: 1,
        mainAxisSpacing: 5,
        children: List.generate(_isSelected.length, (index) {
          //using Inkwell widget to create a button
          return InkWell( 
              splashColor: Colors.blue, //the default splashColor is grey
              onTap: () {
                //set the toggle logic
                setState(() { 
                  for (int indexBtn = 0;
                      indexBtn < _isSelected.length;
                      indexBtn++) {
                    if (indexBtn == index) {
                      _isSelected[indexBtn] = true;
                    } else {
                      _isSelected[indexBtn] = false;
                    }
                  }
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: _isSelected[index] ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(30), 
                ),
                child: createAvatartButton(_avatarPath[index]), 
              ));
        }),
      ),
    );
                    // SizedBox(
                    //     height: 360,
                    //     child: ToggleButtons(
                    //     // Row(
                    //       direction: Axis.vertical,
                    //     children: [
                    //       // Column(
                    //       // children: [
                    //         createAvatartButton("assets/avatar/Avatar01.png"),
                    //         // const Padding(padding: EdgeInsets.only(top: 10)),
                    //         createAvatartButton("assets/avatar/Avatar02.png"),
                    //         // const Padding(padding: EdgeInsets.only(top: 10)),
                    //         createAvatartButton("assets/avatar/Avatar03.png"),
                    //         // const Padding(padding: EdgeInsets.only(top: 10)),
                    //         createAvatartButton("assets/avatar/Avatar04.png"),
                    //     //   ],
                    //     // ),
                    //     // Column(
                    //     //   children: [
                    //         createAvatartButton("assets/avatar/Avatar05.png"),
                    //         // const Padding(padding: EdgeInsets.only(top: 10)),
                    //         createAvatartButton("assets/avatar/Avatar06.png"),
                    //         // const Padding(padding: EdgeInsets.only(top: 10)),
                    //         createAvatartButton("assets/avatar/Avatar07.png"),
                    //         // const Padding(padding: EdgeInsets.only(top: 10)),
                    //         createAvatartButton("assets/avatar/Avatar08.png"),
                    //     //   ],
                    //     // )
                    //   ],
                    //   isSelected: _isSelected,
                    //   onPressed: (int index) {
                    //     setState(() {
                    //       for (int i = 0; i < _isSelected.length; i++) {
                    //         _isSelected[i] = i == index;
                    //       }
                    //     });
                    //    },
                    //   selectedColor: Colors.blue,
                    //   ));
                      }
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            _isSelected = [false, false, false, false, false, false, false, false];
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            for (int index = 0; index < _isSelected.length; index++) {
                              if (_isSelected[index] == true) {
                                globals.tentativeLink = _avatarPath[index];
                                _isSelected = [false, false, false, false, false, false, false, false];
                                Navigator.pop(context, 'Submit');
                              }
                            }
                            Fluttertoast.showToast(
                                msg: "Select an avatar",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 178, 255, 191),
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              );
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Material(
                      color: Colors.transparent,
                      elevation: 8,
                      shape: const CircleBorder(),
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
                              image: imageDefault(),
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ))),
                )
                ),
            SizedBox(
              width: 300,
              child: MyForm(),
            ),
            SizedBox(
              child: FutureBuilder<UserProcess>(
                future: getUserProcess(token: globals.token),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.response.isEmpty) {
                      return const Center(
                            child: Text(
                              "No requirement to get this process",
                              style: TextStyle(
                                color: Color.fromARGB(255, 98, 153, 141),
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.response.length,
                            itemBuilder: (context, index) {
                              return Text(snapshot.data!.response[index].name);
                            },
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }),
                                    )
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
  String _dropDownValue = globals.language;

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("English"), value: "english"),
      const DropdownMenuItem(child: Text("Français"), value: "french"),
      // DropdownMenuItem(child: Text("Español"), value: "Spanish"),
      // DropdownMenuItem(child: Text("Português"), value: "Portuguese"),
    ];
  return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          // padding: const EdgeInsets.only(bottom: 20),
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
                validator: (value) {
                  value!.length < 8 && value.isNotEmpty ? 'Minimum character length is 8' : null;
                }
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     icon: const Icon(Icons.password_outlined),
              //     // hintText: _changePassword,
              //     labelText: 'Confirm Password',
              //   ),
              // ),
              SizedBox(
                  width: 100,
                  child: DropdownButton<String>(
                    value: _dropDownValue,
                    hint: const Text('Select Process'),
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 20,
                      color: Color.fromARGB(255, 166, 221, 204),
                    ),
                    underline: Container(
                      height: 1,
                      color: const Color.fromARGB(255, 228, 117, 126),
                    ),
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropDownValue = newValue!;
                      });
                    },
                    disabledHint: const Text("Disabled"),
                    elevation: 4,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    iconDisabledColor: Colors.grey[350],
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
                      token: globals.token,
                      newEmail: _controllerEmail.text,
                      newUsername: _controllerUsername.text,
                      newPassword: _controllerPassword.text,
                      profilePicture: globals.tentativeLink,
                      language: _dropDownValue,
                    );
                    _controllerEmail.clear();
                    _controllerUsername.clear();
                    _controllerPassword.clear();
                  }},
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
