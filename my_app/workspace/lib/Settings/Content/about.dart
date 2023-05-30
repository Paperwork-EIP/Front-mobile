import 'package:flutter/material.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      // backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.purpose,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.introductionText,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
