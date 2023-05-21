import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/global.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> submitProcessIdea(
    {required String title,
    required String description,
    required String content,
    required String email}) async {
  var response;
  try {
    response = await http.post(
      Uri.parse("${dotenv.get('SERVER_URL')}/process/add"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "title": title,
        "description": description,
        "content": content,
        "token": email,
      }),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      // _controller.add(AuthStatus.authenticated);
    }
  } catch (e) {
    print('r= ${response}');
    print(e);
  }
}

// ignore: non_constant_identifier_names
SizedBox CreateInput(String name, String type, bool outline, double width,
    double height, TextEditingController _controller) {
  return SizedBox(
    width: width,
    height: height,
    child: TextField(
      controller: _controller,
      obscureText: (type == 'password') ? true : false,
      decoration: InputDecoration(
        border: outline ? const OutlineInputBorder() : null,
        labelText: name,
      ),
      style: const TextStyle(fontSize: 14),
    ),
  );
}

// ignore: use_key_in_widget_constructors
class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controllerEmail = TextEditingController();
    final _controllerPassword = TextEditingController();
    final _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
        title: const Text("Contact us"),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(31, 98, 133, 114),
        child: ListView(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 600,
                    width: 420,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Submit a problem',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        CreateInput(
                            'Email', 'email', true, 335, 60, _controllerEmail),
                        CreateInput('Subject', 'subject', true, 335, 60,
                            _controllerPassword),
                        SizedBox(
                          width: 335,
                          // height: height,
                          child: TextField(
                            controller: _controller,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'What is your problem ?',
                            ),
                            minLines: 10,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 40),
                              backgroundColor: const Color(0xFFFC6976)),
                          // ),
                          onPressed: () {
                            // submitProcessIdea(
                            //     title: _controllerEmail.text,
                            //     description: _controllerPassword.text,
                            //     content: _controller.text,
                            //     email: globals.email);
                            _controllerEmail.clear();
                            _controllerPassword.clear();
                            _controller.clear();
                            Fluttertoast.showToast(
                              msg: "Problem submit",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 178, 255, 191),
                              textColor: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16.0,
                            );
                          },
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
