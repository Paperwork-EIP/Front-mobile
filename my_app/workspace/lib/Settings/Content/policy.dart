import 'package:flutter/material.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPolicy extends StatelessWidget {
  const SettingsPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privacyPolicy),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.privacyPolicyTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.privacyPolicyText,
                  style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
