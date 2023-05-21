import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/global.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => HelpState();
}

// ignore: use_key_in_widget_constructors
class HelpState extends State<Help> {
  // List<String> attachments = [];
  final bool isHTML = false;

  // final _recipientController = TextEditingController(
  //   text: 'example@example.com',
  // );

  // final _subjectController = TextEditingController(text: 'The subject');

  // final _bodyController = TextEditingController(
  //   text: 'Mail body.',
  // );
  
  late String platformResponse;
  
  Future<void> send(String _body, String _subject ) async {
    final Email email = Email(
      body: _body,
      subject: _subject,
      recipients: ['paperwork_2024@labeip.epitech.eu'],
      // attachmentPaths: attachments,
      isHTML: isHTML,
    );
  
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    final _controllerEmail = TextEditingController();
    final _controllerSubject = TextEditingController();
    final _controllerBody = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("Contact us", style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(
          color: Colors.black,
          ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 255, 255, 255),
        child:
        ListView(
                children: [ ConstrainedBox(
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
                        // CreateInput(
                        //     'Email', 'email', true, 335, 60, _controllerEmail),
                        CreateInput('Subject', 'subject', true, 335, 60,
                            _controllerSubject),
                        SizedBox(
                          width: 335,
                          // height: height,
                          child: TextField(
                            controller: _controllerBody,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Describe your problem',
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
                          onPressed: () {
                            // print(_controllerBody.text);
                            send(_controllerBody.text, _controllerSubject.text);
                            if (platformResponse == 'success') {
                              Fluttertoast.showToast(
                                msg: "Email send",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 178, 255, 191),
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              );
                              // _controllerEmail.clear();
                              _controllerSubject.clear();
                              _controllerBody.clear();
                              platformResponse = '';
                            } else {
                              Fluttertoast.showToast(
                                msg: "Problem submit",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 178, 255, 191),
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              );
                            }
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
