import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/global.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgottenPasswordPage extends StatelessWidget {
  const ForgottenPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(41, 201, 179, 1),
        elevation: 0,
        title: Center(
            child: Text(
          AppLocalizations.of(context)!.forgotPassword,
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          runSpacing: 25,
          children: [
            Text(
                AppLocalizations.of(context)!.provideEmail,
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
                width: 500,
                height: 60,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Email',
                  ),
                )),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 100)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF29C9B3))),
                child: Text(
                  AppLocalizations.of(context)!.sendEmail,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                onPressed: () async {
                  await _sendResetEmail(email: emailController.text).then(
                    (value) => ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(value))),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> _sendResetEmail({required String email}) async {
    http.Response response;

    try {
      response = await http.get(
        Uri.parse(
            "${dotenv.get('SERVER_URL')}/user/sendResetPasswordEmail?email=$email"),
      );
      if (response.statusCode == 200) {
        return "An email was just sent to you. It may take a few minutes to appear in your inbox.";
      }
    } catch (e) {
      return (e.toString());
    }
    return ("An error has occured. Please try again later.");
  }
}
