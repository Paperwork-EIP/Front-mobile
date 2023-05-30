import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/global.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final bool isHTML = false;

  late String platformResponse;

  Future<void> send(String _body, String _subject) async {
    final Email email = Email(
      body: _body,
      subject: _subject,
      recipients: ['paperwork_2024@labeip.epitech.eu'],
      isHTML: isHTML,
    );

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
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
        title: Text(
          AppLocalizations.of(context)!.constactUs,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 255, 255, 255),
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
                         Text(
                          AppLocalizations.of(context)!.submitAproblem,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        CreateInput(AppLocalizations.of(context)!.subject, AppLocalizations.of(context)!.subject, true, 335, 60,
                            _controllerSubject),
                        SizedBox(
                          width: 335,
                          child: TextField(
                            controller: _controllerBody,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.desribeProblem,
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
                            send(_controllerBody.text, _controllerSubject.text);
                            if (platformResponse == 'success') {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!.emailSend,
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 178, 255, 191),
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              );
                              _controllerSubject.clear();
                              _controllerBody.clear();
                              platformResponse = '';
                            } else {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!.problemSubmit,
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 178, 255, 191),
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              );
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.submit),
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
